module Fog
  module AzureRM
    class Resources
      # This class is giving implementation of all/list and get.
      class AzureResources < Fog::Collection
        attribute :tag_name
        attribute :tag_value
        model Fog::AzureRM::Resources::AzureResource

        def all
          unless tag_name.nil? && tag_value.nil?
            resources = []
            service.list_tagged_resources(tag_name, tag_value).each do |resource|
              resources << Fog::AzureRM::Resources::AzureResource.parse(resource)
            end
            resources.inspect
            return load(resources)
          end
          nil
        end

        def get(resource_id)
          all.find { |f| f.id == resource_id }
        end

        def check_azure_resource_exists(resource_id, api_version)
          service.check_azure_resource_exists(resource_id, api_version)
        end

        def list_resources_in_resource_group(resource_group_name)
          resources = []
          service.list_resources_in_resource_group(resource_group_name).each do |resource|
            resources.push(Fog::AzureRM::Resources::AzureResource.parse(resource))
          end
          load(resources)
        end
      end
    end
  end
end
