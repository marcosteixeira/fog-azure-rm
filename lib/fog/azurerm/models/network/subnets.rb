module Fog
  module AzureRM
    class Network
      # Subnet collection for network service
      class Subnets < Fog::Collection
        model Fog::AzureRM::Network::Subnet
        attribute :resource_group
        attribute :virtual_network_name

        def all
          requires :resource_group, :virtual_network_name
          subnets = []
          service.list_subnets(resource_group, virtual_network_name).each do |subnet|
            subnets << Fog::AzureRM::Network::Subnet.parse(subnet)
          end
          load(subnets)
        end

        def get(resource_group, virtual_network_name, subnet_name)
          subnet = service.get_subnet(resource_group, virtual_network_name, subnet_name)
          subnet_fog = Fog::AzureRM::Network::Subnet.new(service: service)
          subnet_fog.merge_attributes(Fog::AzureRM::Network::Subnet.parse(subnet))
        end

        def check_subnet_exists(resource_group, virtual_network_name, subnet_name)
          service.check_subnet_exists(resource_group, virtual_network_name, subnet_name)
        end
      end
    end
  end
end
