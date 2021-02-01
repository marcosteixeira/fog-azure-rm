module Fog
  module AzureRM
    class Storage
      # This class is giving implementation of all/list, get and
      # check name availability for storage account.
      class StorageAccounts < Fog::Collection
        model Fog::AzureRM::Storage::StorageAccount
        attribute :resource_group

        def all
          accounts = []
          if !resource_group.nil?
            requires :resource_group
            hash_of_storage_accounts = service.list_storage_account_for_rg(resource_group)
          else
            hash_of_storage_accounts = service.list_storage_accounts
          end
          hash_of_storage_accounts.each do |account|
            accounts << Fog::AzureRM::Storage::StorageAccount.parse(account)
          end
          load(accounts)
        end

        def get(resource_group_name, storage_account_name)
          storage_account = service.get_storage_account(resource_group_name, storage_account_name)
          storage_account_fog = Fog::AzureRM::Storage::StorageAccount.new(service: service)
          storage_account_fog.merge_attributes(Fog::AzureRM::Storage::StorageAccount.parse(storage_account))
        end

        def check_name_availability(name, type = 'Microsoft.Storage/storageAccounts')
          service.check_storage_account_name_availability(name, type)
        end

        def delete_storage_account_from_tag(resource_group_name, tag_key, tag_value)
          storage_accounts = service.storage_accounts(resource_group: resource_group_name)
          storage_accounts.each do |account|
            account.destroy if account.tags[tag_key].eql? tag_value
          end
        end

        def check_storage_account_exists(resource_group_name, storage_account_name)
          service.check_storage_account_exists(resource_group_name, storage_account_name)
        end
      end
    end
  end
end
