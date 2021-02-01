module Fog
  module AzureRM
    class Compute
      # CreationData model for Compute Service
      class CreationData < Fog::Model
        attribute :create_option
        attribute :storage_account_id
        attribute :source_uri
        attribute :source_resource_id
        attribute :image_reference

        def self.parse(creation_data)
          data = get_hash_from_object(creation_data)
          unless creation_data.image_reference.nil?
            image_reference = Fog::AzureRM::Compute::ImageDiskReference.new
            data['image_reference'] = image_reference.merge_attributes(Fog::AzureRM::Compute::ImageDiskReference.parse(creation_data.image_reference))
          end
          data
        end
      end
    end
  end
end
