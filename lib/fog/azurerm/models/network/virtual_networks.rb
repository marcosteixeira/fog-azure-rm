module Fog
  module AzureRM
    class Network
      # This class is giving implementation of all/list, get and
      # check name availability for virtual network.
      class VirtualNetworks < Fog::Collection
        model Fog::AzureRM::Network::VirtualNetwork
        attribute :resource_group

        def all
          virtual_networks = []
          if !resource_group.nil?
            requires :resource_group
            vnets = service.list_virtual_networks(resource_group)
          else
            vnets = service.list_virtual_networks_in_subscription
          end
          vnets.each do |vnet|
            virtual_networks << Fog::AzureRM::Network::VirtualNetwork.parse(vnet)
          end
          load(virtual_networks)
        end

        def get(resource_group_name, virtual_network_name)
          virtual_network = service.get_virtual_network(resource_group_name, virtual_network_name)
          virtual_network_fog = Fog::AzureRM::Network::VirtualNetwork.new(service: service)
          virtual_network_fog.merge_attributes(Fog::AzureRM::Network::VirtualNetwork.parse(virtual_network))
        end

        def check_virtual_network_exists(resource_group, name)
          service.check_virtual_network_exists(resource_group, name)
        end
      end
    end
  end
end
