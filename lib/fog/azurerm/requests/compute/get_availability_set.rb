module Fog
  module AzureRM
    class Compute
      # This class provides the actual implementation for service call.
      class Real
        def get_availability_set(resource_group, name)
          msg = "Listing Availability Set: #{name} in Resource Group: #{resource_group}"
          Fog::Logger.debug msg
          begin
            @compute_mgmt_client.availability_sets.get(resource_group, name)
          rescue MsRestAzure::AzureOperationError => e
            raise_azure_exception(e, msg)
          end
        end
      end
      # This class provides the mock implementation for unit tests.
      class Mock
        def get_availability_set(*)
          {
            'id' => "/subscriptions/########-####-####-####-############/resourceGroups/'resource_group'/providers/Microsoft.Compute/virtualMachines/'name'",
            'name' => 'name',
            'type' => 'Microsoft.Compute/virtualMachines',
            'location' => 'westus',
            '@platform_update_domain_count' => UPDATE_DOMAIN_COUNT,
            '@platform_fault_domain_count' => FAULT_DOMAIN_COUNT,
            '@virtual_machines' => []
          }
        end
      end
    end
  end
end
