module Fog
  module Network
    class AzureRM
      # Frontend IP Configuration model class for Network Service
      class FrontendIPConfiguration < Fog::Model
        identity :name
        attribute :publicIpAddressId
        attribute :privateIPAllocationMethod
        attribute :privateIPAddress
        def self.parse(frontend_ip_configuration)
          frontend_ip_configuration_properties = frontend_ip_configuration['properties']

          hash = {}
          hash['name'] = frontend_ip_configuration['name']
          unless frontend_ip_configuration_properties.nil?
            unless frontend_ip_configuration_properties['publicIPAddress'].nil?
              hash['publicIpAddressId'] = frontend_ip_configuration_properties['publicIPAddress']['id']
            end
            hash['privateIPAllocationMethod'] = frontend_ip_configuration_properties['privateIPAllocationMethod']
            private_ip_address = frontend_ip_configuration_properties['privateIPAddress']
            unless private_ip_address.nil?
              hash['privateIPAddress'] = private_ip_address
            end
          end
          hash
        end
      end
    end
  end
end
