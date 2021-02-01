module Fog
  module AzureRM
    class Network
      # VirtualNetworkGateways collection class for Network Service
      class VirtualNetworkGateways < Fog::Collection
        model Fog::AzureRM::Network::VirtualNetworkGateway
        attribute :resource_group

        def all
          requires :resource_group
          network_gateways = []
          service.list_virtual_network_gateways(resource_group).each do |gateway|
            network_gateways << Fog::AzureRM::Network::VirtualNetworkGateway.parse(gateway)
          end
          load(network_gateways)
        end

        def get(resource_group_name, name)
          network_gateway = service.get_virtual_network_gateway(resource_group_name, name)
          virtual_network_gateway = Fog::AzureRM::Network::VirtualNetworkGateway.new(service: service)
          virtual_network_gateway.merge_attributes(Fog::AzureRM::Network::VirtualNetworkGateway.parse(network_gateway))
        end

        def check_vnet_gateway_exists(resource_group_name, name)
          service.check_vnet_gateway_exists(resource_group_name, name)
        end
      end
    end
  end
end
