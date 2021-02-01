module Fog
  module AzureRM
    class Resources
      # This class provides the actual implementation for service calls.
      class Real
        def delete_resource_tag(resource_id, tag_name, tag_value, api_version = API_VERSION)
          split_resource = resource_id.split('/') unless resource_id.nil?
          if split_resource.count != 9
            raise 'Invalid Resource Id'
          end

          resource_group_name = get_resource_from_resource_id(resource_id, RESOURCE_GROUP_NAME)
          resource_provider_namespace = get_resource_from_resource_id(resource_id, RESOURCE_PROVIDER_NAMESPACE)
          resource_type = get_resource_from_resource_id(resource_id, RESOURCE_TYPE)
          resource_name = get_resource_from_resource_id(resource_id, RESOURCE_NAME)

          msg = "Deleting Tag #{tag_name} from Resource #{resource_name}"
          Fog::Logger.debug msg

          begin
            resource = @rmc.resources.get(resource_group_name, resource_provider_namespace, '', resource_type, resource_name, api_version)

            if resource.tags.key?(tag_name)
              resource.tags.delete_if { |key, value| key == tag_name && value == tag_value }
            end
            @rmc.resources.create_or_update(resource_group_name, resource_provider_namespace, '', resource_type, resource_name, api_version, resource)
          rescue  MsRestAzure::AzureOperationError => e
            raise_azure_exception(e, msg)
          end
          Fog::Logger.debug "Tag #{tag_name} deleted successfully from Resource #{resource_name}"
          true
        end
      end

      # This class provides the mock implementation for unit tests.
      class Mock
        def delete_resource_tag(_resource_id, tag_name, _tag_value, _api_version)
          Fog::Logger.debug "Tag #{tag_name} deleted successfully from Resource your-resource-name"
          true
        end
      end
    end
  end
end
