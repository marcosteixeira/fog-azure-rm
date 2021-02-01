module Fog
  module AzureRM
    class DNS
      # This class provides the actual implementation for service calls.
      class Real
        def check_record_set_exists(resource_group, name, zone_name, record_type)
          msg = "Checking Record set #{name}"
          Fog::Logger.debug msg
          begin
            @dns_client.record_sets.get(resource_group, zone_name, name, record_type)
            Fog::Logger.debug "Record set #{name} exists."
            true
          rescue MsRestAzure::AzureOperationError => e
            if resource_not_found?(e)
              Fog::Logger.debug "Record set #{name} doesn't exist."
              false
            else
              raise_azure_exception(e, msg)
            end
          end
        end
      end
      # This class provides the mock implementation for unit tests.
      class Mock
        def check_record_set_exists(_resource_group, _name)
          true
        end
      end
    end
  end
end
