module Fog
  module AzureRM
    class Network
      # LoadBalancers collection class for Network Service
      class LoadBalancers < Fog::Collection
        model Fog::AzureRM::Network::LoadBalancer
        attribute :resource_group

        def all
          load_balancers = []
          if !resource_group.nil?
            requires :resource_group
            l_balancers = service.list_load_balancers(resource_group)
          else
            l_balancers = service.list_load_balancers_in_subscription
          end

          l_balancers.each do |load_balancer|
            load_balancers << Fog::AzureRM::Network::LoadBalancer.parse(load_balancer)
          end
          load(load_balancers)
        end

        def get(resource_group_name, load_balancer_name)
          load_balancer = service.get_load_balancer(resource_group_name, load_balancer_name)
          load_balancer_fog = Fog::AzureRM::Network::LoadBalancer.new(service: service)
          load_balancer_fog.merge_attributes(Fog::AzureRM::Network::LoadBalancer.parse(load_balancer))
        end

        def check_load_balancer_exists(resource_group_name, load_balancer_name)
          service.check_load_balancer_exists(resource_group_name, load_balancer_name)
        end
      end
    end
  end
end
