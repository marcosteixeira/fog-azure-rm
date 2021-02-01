module Fog
  module AzureRM
    class Network
      # collection class for Network Security Group
      class NetworkSecurityGroups < Fog::Collection
        model Fog::AzureRM::Network::NetworkSecurityGroup
        attribute :resource_group

        def all
          requires :resource_group
          network_security_groups = []
          service.list_network_security_groups(resource_group).each do |nsg|
            network_security_groups << Fog::AzureRM::Network::NetworkSecurityGroup.parse(nsg)
          end
          load(network_security_groups)
        end

        def get(resource_group, name)
          network_security_group = service.get_network_security_group(resource_group, name)
          network_security_group_fog = Fog::AzureRM::Network::NetworkSecurityGroup.new(service: service)
          network_security_group_fog.merge_attributes(Fog::AzureRM::Network::NetworkSecurityGroup.parse(network_security_group))
        end

        def check_net_sec_group_exists(resource_group, name)
          service.check_net_sec_group_exists(resource_group, name)
        end
      end
    end
  end
end
