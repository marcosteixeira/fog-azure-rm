module Fog
  module AzureRM
    class Compute
      # ImageReference model for Compute Service
      class ImageDiskReference < Fog::Model
        attribute :id
        attribute :lun

        def self.parse(image_reference)
          get_hash_from_object(image_reference)
        end
      end
    end
  end
end
