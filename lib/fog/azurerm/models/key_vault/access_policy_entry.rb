module Fog
  module AzureRM
    class KeyVault
      # AccessPolicyEntry Model for Storage Service
      class AccessPolicyEntry < Fog::Model
        identity  :object_id
        attribute :tenant_id
        attribute :application_id
        attribute :keys
        attribute :secrets
        attribute :certificates

        def self.parse(access_policy_entry)
          access_policy_entry_hash = get_hash_from_object(access_policy_entry)
          permissions = access_policy_entry.permissions
          unless permissions.nil?
            access_policy_entry_hash['keys'] = permissions.keys
            access_policy_entry_hash['secrets'] = permissions.secrets
            access_policy_entry_hash['certificates'] = permissions.certificates
          end

          access_policy_entry_hash
        end
      end
    end
  end
end
