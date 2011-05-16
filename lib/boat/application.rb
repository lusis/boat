module Boat
  # class to work with Noah Application objects
  class Application
    include Boat::Common
    # path to the node
    attr_accessor :name
    # contents of node
    attr_accessor :configurations

    # saves the current state of the object
    def save(opts={:name => self.name, :configurations => nil})
      body = {"name" => opts[:name]}
      options = {:body => body.to_json}
      begin
        response = self.class.put("#{self.class.noah_base_path}/#{opts[:name]}", options)
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

  end
end
