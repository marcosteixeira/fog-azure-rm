module Fog
  module AzureRM
    class ApplicationGateway
      # Frontenf Port model class for Application Gateway Service
      class FrontendPort < Fog::Model
        identity :name
        attribute :id
        attribute :port

        def self.parse(frontend_port)
          hash = {}
          hash['id'] = frontend_port.id
          hash['name'] = frontend_port.name
          hash['port'] = frontend_port.port
          hash
        end
      end
    end
  end
end
