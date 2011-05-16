module Boat
  # class to work with Noah Ephemeral objects
  class Ephemeral
    include Boat::Common
    # path to the node
    attr_accessor :path
    # contents of node
    attr_accessor :data

    # saves the ephemeral object
    def save(opts={:path => self.path, :data => self.data})
      options = {:body => opts[:data]}
      begin
        response = self.class.put("#{self.class.noah_base_path}#{opts[:path]}", options)
        case response.code
        when 200
          %w[updated_at created_at id].each do |var|
            self.instance_variable_set("@#{var}", response.parsed_response["#{var}"])
          end
          self
        when 500
          puts "Noah returned an error: #{response.parsed_response["error_message"]}"
        end
      rescue Errno::ECONNREFUSED
        "Noah server is unreachable"
      end
    end

    # reads the raw value of the ephemeral object from the server
    def read(path=@path)
      begin
        self.class.get("#{self.class.noah_base_path}#{path}").parsed_response
      rescue Errno::ECONNREFUSED
        "Noah server is unreachable"
      end
    end

    def self.all
      raise NotImplementedError, "Ephemerals are not browsable"
    end
  end
end
