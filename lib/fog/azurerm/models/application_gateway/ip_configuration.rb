module Fog
  module AzureRM
    class ApplicationGateway
      # GatewayIPConfiguration model class for Application Gateway Service
      class IPConfiguration < Fog::Model
        identity :name
        attribute :id
        attribute :subnet_id

        def self.parse(gateway_ip_configuration)
          hash = {}
          if gateway_ip_configuration.is_a? Hash
            hash['id'] = gateway_ip_configuration['id']
            hash['name'] = gateway_ip_configuration['name']
            hash['subnet_id'] = gateway_ip_configuration['subnet']['id'] unless gateway_ip_configuration['subnet'].nil?
          else
            hash['id'] = gateway_ip_configuration.id
            hash['name'] = gateway_ip_configuration.name
            hash['subnet_id'] = gateway_ip_configuration.subnet.id unless gateway_ip_configuration.subnet.nil?
          end
          hash
        end
      end
    end
  end
end
