module Fog
  module AzureRM
    class Network
      # NetworkInterfaces collection class for Network Service
      class NetworkInterfaces < Fog::Collection
        model Fog::AzureRM::Network::NetworkInterface
        attribute :resource_group

        def all
          requires :resource_group
          network_interfaces = []
          service.list_network_interfaces(resource_group).each do |nic|
            network_interfaces << Fog::AzureRM::Network::NetworkInterface.parse(nic)
          end
          load(network_interfaces)
        end

        def create_async(attributes = {})
          network_interface = new(attributes)
          promise = network_interface.save(true)
          Fog::AzureRM::AsyncResponse.new(network_interface, promise)
        end

        def get(resource_group_name, name)
          network_interface_card = service.get_network_interface(resource_group_name, name)
          network_interface_card_fog = Fog::AzureRM::Network::NetworkInterface.new(service: service)
          network_interface_card_fog.merge_attributes(Fog::AzureRM::Network::NetworkInterface.parse(network_interface_card))
        end

        def check_network_interface_exists(resource_group_name, name)
          service.check_network_interface_exists(resource_group_name, name)
        end
      end
    end
  end
end
