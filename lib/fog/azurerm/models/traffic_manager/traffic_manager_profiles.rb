module Fog
  module AzureRM
    class TrafficManager
      # Traffic Manager Profile Collection for TrafficManager Service
      class TrafficManagerProfiles < Fog::Collection
        attribute :resource_group
        model Fog::AzureRM::TrafficManager::TrafficManagerProfile

        def all
          requires :resource_group
          traffic_manager_profiles = service.list_traffic_manager_profiles(resource_group).map { |profile| Fog::AzureRM::TrafficManager::TrafficManagerProfile.parse(profile) }
          load(traffic_manager_profiles)
        end

        def get(resource_group, traffic_manager_profile_name)
          profile = service.get_traffic_manager_profile(resource_group, traffic_manager_profile_name)
          profile_fog = Fog::AzureRM::TrafficManager::TrafficManagerProfile.new(service: service)
          profile_fog.merge_attributes(Fog::AzureRM::TrafficManager::TrafficManagerProfile.parse(profile))
        end

        def check_traffic_manager_profile_exists(resource_group, traffic_manager_profile_name)
          service.check_traffic_manager_profile_exists(resource_group, traffic_manager_profile_name)
        end
      end
    end
  end
end
