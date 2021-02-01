module Fog
  module AzureRM
    class DNS
      # This class is giving implementation of create/save and
      # delete/destroy for RecordSet.
      class RecordSet < Fog::Model
        attribute :id
        identity :name
        attribute :resource_group
        attribute :zone_name
        attribute :records
        attribute :type
        attribute :ttl
        attribute :cname_record
        attribute :a_records

        def self.parse(recordset)
          hash = get_hash_from_object(recordset)
          hash['resource_group'] = get_resource_group_from_id(recordset.id)
          hash['zone_name'] = get_record_set_from_id(recordset.id)
          type = get_type_from_recordset_type(recordset.type)

          hash['records'] = []
          if type == 'A'
            record_entries = recordset.arecords
            record_entries.each do |record|
              hash['records'] << record.ipv4address
            end
          end
          if type == 'CNAME'
            record_entries = recordset.cname_record
            hash['records'] << record_entries.cname
          end

          unless recordset.arecords.nil?
            a_records = []
            recordset.arecords.each do |record|
              a_record = Fog::AzureRM::DNS::ARecord.new
              a_record.merge_attributes(Fog::AzureRM::DNS::ARecord.parse(record))
              a_records.push(a_record)
            end
            hash['a_records'] = a_records
          end

          unless recordset.cname_record.nil?
            cname_record = Fog::AzureRM::DNS::CnameRecord.new
            cname_record.merge_attributes(Fog::AzureRM::DNS::CnameRecord.parse(recordset.cname_record))
            hash['cname_record'] = cname_record
          end

          hash
        end

        def save
          requires :name, :resource_group, :zone_name, :records, :type, :ttl
          record_set = service.create_or_update_record_set(record_set_params, type)
          merge_attributes(Fog::AzureRM::DNS::RecordSet.parse(record_set))
        end

        def destroy
          service.delete_record_set(resource_group, name, zone_name, get_record_type(type))
        end

        def get_records(resource_group, name, zone_name, record_type)
          service.get_records_from_record_set(resource_group, name, zone_name, record_type)
        end

        def update_ttl(ttl)
          params = record_set_params
          params[:ttl] = ttl
          record_set = service.create_or_update_record_set(params, get_record_type(type))
          merge_attributes(Fog::AzureRM::DNS::RecordSet.parse(record_set))
        end

        def add_a_type_record(record)
          records << record
          record_set = service.create_or_update_record_set(record_set_params, get_record_type(type))
          merge_attributes(Fog::AzureRM::DNS::RecordSet.parse(record_set))
        end

        def remove_a_type_record(record)
          records.delete(record)
          record_set = service.create_or_update_record_set(record_set_params, get_record_type(type))
          merge_attributes(Fog::AzureRM::DNS::RecordSet.parse(record_set))
        end

        private

        def record_set_params
          {
            name: name,
            resource_group: resource_group,
            zone_name: zone_name,
            records: records,
            ttl: ttl,
            cname_record: cname_record,
            a_records: a_records
          }
        end
      end
    end
  end
end
