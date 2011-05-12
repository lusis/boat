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
      end
    end

    def initialize(attrs={})
      attrs.each do |key, value|
        m = "#{key}=".to_sym
        self.send(m, value) if self.respond_to?(m)
      end
    end
  end
end
