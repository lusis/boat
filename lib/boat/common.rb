module Boat

  module Common
    def self.included(base)
      base.send :include, CommonAttributes
      base.send :include, CommonClassMethods
    end
  end

  module CommonAttributes
    # Common attributes across all nodes in Noah
    def self.included(base)
      base.send :include, HTTParty
      base.send :base_uri, Boat::Client.server
      base.send :default_timeout, Boat::Client.timeout

      # id of the node
      attr_reader :id
      # timestamp of node creation time
      attr_reader :created_at
      # timestamp of node last update
      attr_reader :updated_at
      # tags associated with node
      attr_accessor :tags
      # links associated with node
      attr_accessor :links
    end
  end

  module CommonClassMethods
    # Common class methods across all models
    def self.included(base)
      class << base
        def noah_base_path
          @@noah_base_path = "/#{self.to_s.gsub(/(.*)::(\w)/, '\2').downcase}s"
        end
        def all
          begin
            self.get("#{self.noah_base_path}").parsed_response
          rescue Errno::ECONNREFUSED
            "Noah server is unreachable"
          end
        end
      end
    end

    def initialize(attrs={})
      attrs.each do |key, value|
        m = "#{key}=".to_sym
        self.send(m, value) if self.respond_to?(m)
      end
    end

    def read(name=@name)
      begin
        a = self.class.new
        res = self.class.get("#{self.class.noah_base_path}/#{name}").parsed_response
        res.each do |key, value|
          a.instance_variable_set("@#{key}", value)
        end
        a
      rescue Errno::ECONNREFUSED
        "Noah server is unreachable"
      end
    end
  end
end
