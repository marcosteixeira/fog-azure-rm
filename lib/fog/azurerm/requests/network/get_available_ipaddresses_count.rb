module Fog
  module AzureRM
    class Network
      # Real class for Network Request
      class Real
        def get_available_ipaddresses_count(subnet_name, address_prefix, ip_configurations_ids, express_route_enabled)
          Fog::Logger.debug "Getting free IP Address count of Subnet #{subnet_name}"
          total_ipaddresses = (2**(32 - address_prefix.split('/').last.to_i)) - 2
          total_ipaddresses -= 3 if express_route_enabled
          used_ip_address = ip_configurations_ids.nil? ? 0 : ip_configurations_ids.count
          total_ipaddresses - used_ip_address
        end
      end

      # Mock class for Network Request
      class Mock
        def get_available_ipaddress_count(*)
          65_531
        end
      end
    end
  end
end
