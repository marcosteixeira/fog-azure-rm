module Fog
  module AzureRM
    class DNS
      # This class is giving implementation of
      # all/get for Zones.
      class Zones < Fog::Collection
        model Fog::AzureRM::DNS::Zone

        def all
          zones = []
          service.list_zones.each do |z|
            zones << Fog::AzureRM::DNS::Zone.parse(z)
          end
          load(zones)
        end

        def get(resource_group, name)
          zone = service.get_zone(resource_group, name)
          zone_fog = Fog::AzureRM::DNS::Zone.new(service: service)
          zone_fog.merge_attributes(Fog::AzureRM::DNS::Zone.parse(zone))
        end

        def check_zone_exists(resource_group, name)
          service.check_zone_exists(resource_group, name)
        end
      end
    end
  end
end
