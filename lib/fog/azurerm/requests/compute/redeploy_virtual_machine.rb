module Fog
  module AzureRM
    class Compute
      # This class provides the actual implementation for service calls.
      class Real
        def redeploy_virtual_machine(resource_group, name, async)
          msg = "Redeploying Virtual Machine #{name} in Resource Group #{resource_group}."
          Fog::Logger.debug msg
          begin
            if async
              response = @compute_mgmt_client.virtual_machines.redeploy_async(resource_group, name)
            else
              @compute_mgmt_client.virtual_machines.redeploy(resource_group, name)
            end
          rescue  MsRestAzure::AzureOperationError => e
            raise_azure_exception(e, msg)
          end
          if async
            response
          else
            Fog::Logger.debug "Virtual Machine #{name} Redeployed Successfully."
            true
          end
        end
      end
      # This class provides the mock implementation for unit tests.
      class Mock
        def redeploy_virtual_machine(*)
          Fog::Logger.debug 'Virtual Machine fog-test-server from Resource group fog-test-rg Redeployed successfully.'
          true
        end
      end
    end
  end
end
