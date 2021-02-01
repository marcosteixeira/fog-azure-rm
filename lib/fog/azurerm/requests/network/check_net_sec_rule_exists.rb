module Fog
  module AzureRM
    class Network
      # This class provides the actual implementation for service calls.
      class Real
        def check_net_sec_rule_exists(resource_group_name, network_security_group_name, security_rule_name)
          msg = "Checking Network Security Rule #{security_rule_name}"
          Fog::Logger.debug msg
          begin
            @network_client.security_rules.get(resource_group_name, network_security_group_name, security_rule_name)
            Fog::Logger.debug "Network Security Rule #{security_rule_name} exists."
            true
          rescue MsRestAzure::AzureOperationError => e
            if resource_not_found?(e)
              Fog::Logger.debug "Network Security Rule #{security_rule_name} doesn't exist."
              false
            else
              raise_azure_exception(e, msg)
            end
          end
        end
      end
      # This class provides the mock implementation for unit tests.
      class Mock
        def check_net_sec_rule_exists(*)
          true
        end
      end
    end
  end
end
