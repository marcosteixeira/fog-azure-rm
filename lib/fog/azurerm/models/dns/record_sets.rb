module Fog
  module AzureRM
    class DNS
      # This class is giving implementation of
      # all/get for RecordSets.
      class RecordSets < Fog::Collection
        attribute :resource_group
        attribute :zone_name
        attribute :type

        model Fog::AzureRM::DNS::RecordSet

        def all
          requires :resource_group, :zone_name
          record_sets = []
          service.list_record_sets(resource_group, zone_name).each do |r|
            record_sets << Fog::AzureRM::DNS::RecordSet.parse(r)
          end
          load(record_sets)
        end

        def get(resource_group, name, zone_name, record_type)
          record_set = service.get_record_set(resource_group, name, zone_name, record_type)
          record_set_fog = Fog::AzureRM::DNS::RecordSet.new(service: service)
          record_set_fog.merge_attributes(Fog::AzureRM::DNS::RecordSet.parse(record_set))
        end

        def check_record_set_exists(resource_group, name, zone_name, record_type)
          service.check_record_set_exists(resource_group, name, zone_name, record_type)
        end
      end
    end
  end
end
