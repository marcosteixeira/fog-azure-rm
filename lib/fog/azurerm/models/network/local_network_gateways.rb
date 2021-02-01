module Fog
  module AzureRM
    class Network
      # LocalNetworkGateways collection class for Network Service
      class LocalNetworkGateways < Fog::Collection
        model Fog::AzureRM::Network::LocalNetworkGateway
        attribute :resource_group

        def all
          requires :resource_group
          local_network_gateways = service.list_local_network_gateways(resource_group).map { |gateway| Fog::AzureRM::Network::LocalNetworkGateway.parse(gateway) }
          load(local_network_gateways)
        end

        def get(resource_group_name, name)
          local_network_gateway = service.get_local_network_gateway(resource_group_name, name)
          local_network_gateway_fog = Fog::AzureRM::Network::LocalNetworkGateway.new(service: service)
          local_network_gateway_fog.merge_attributes(Fog::AzureRM::Network::LocalNetworkGateway.parse(local_network_gateway))
        end

        def check_local_net_gateway_exists(resource_group_name, name)
          service.check_local_net_gateway_exists(resource_group_name, name)
        end
      end
    end
  end
end
