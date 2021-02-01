module Fog
  module AzureRM
    class Compute
      # This class provides the actual implementation for service calls.
      class Real
        def check_vm_extension_exists(resource_group_name, virtual_machine_name, vm_extension_name)
          msg = "Checking Virtual Machine Extension #{vm_extension_name}"
          Fog::Logger.debug msg
          begin
            @compute_mgmt_client.virtual_machine_extensions.get(resource_group_name, virtual_machine_name, vm_extension_name)
            Fog::Logger.debug "Virtual Machine Extension #{vm_extension_name} exists."
            true
          rescue MsRestAzure::AzureOperationError => e
            if resource_not_found?(e)
              Fog::Logger.debug "Virtual Machine Extension #{vm_extension_name} doesn't exist."
              false
            else
              raise_azure_exception(e, msg)
            end
          end
        end
      end
      # This class provides the mock implementation for unit tests.
      class Mock
        def check_vm_extension_exists(*)
          true
        end
      end
    end
  end
end
