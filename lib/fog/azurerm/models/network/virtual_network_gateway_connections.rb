module Fog
  module AzureRM
    class Network
      # VirtualNetworkGatewayConnections collection class for Network Service
      class VirtualNetworkGatewayConnections < Fog::Collection
        model Fog::AzureRM::Network::VirtualNetworkGatewayConnection
        attribute :resource_group

        def all
          requires :resource_group
          gateway_connections = service.list_virtual_network_gateway_connections(resource_group).map { |connection| Fog::AzureRM::Network::VirtualNetworkGatewayConnection.parse(connection) }
          load(gateway_connections)
        end

        def get(resource_group_name, name)
          connection = service.get_virtual_network_gateway_connection(resource_group_name, name)
          gateway_connection = Fog::AzureRM::Network::VirtualNetworkGatewayConnection.new(service: service)
          gateway_connection.merge_attributes(Fog::AzureRM::Network::VirtualNetworkGatewayConnection.parse(connection))
        end

        def check_vnet_gateway_connection_exists(resource_group_name, name)
          service.check_vnet_gateway_connection_exists(resource_group_name, name)
        end
      end
    end
  end
end
