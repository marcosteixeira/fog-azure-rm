require File.expand_path '../../test_helper', __dir__

# Test class for Availability Set Collection
class TestStorageAccounts < Minitest::Test
  def setup
    @service = Fog::AzureRM::Storage.new(credentials)
    @storage_mgmt_client = @service.instance_variable_get(:@storage_mgmt_client)
    @storage_accounts = Fog::AzureRM::Storage::StorageAccounts.new(resource_group: 'fog-test-rg', service: @service)
    @list_storage_account_response = [ApiStub::Models::Storage::StorageAccount.create_storage_account(@storage_mgmt_client)]
  end

  def test_collection_methods
    methods = [
      :all,
      :get,
      :check_storage_account_exists
    ]
    methods.each do |method|
      assert_respond_to @storage_accounts, method
    end
  end

  def test_collection_attributes
    assert_respond_to @storage_accounts, :resource_group
  end

  def test_all_method_response_for_rg
    @service.stub :list_storage_account_for_rg, @list_storage_account_response do
      assert_instance_of Fog::AzureRM::Storage::StorageAccounts, @storage_accounts.all
      assert @storage_accounts.all.size >= 1
      @storage_accounts.all.each do |s|
        assert_instance_of Fog::AzureRM::Storage::StorageAccount, s
      end
    end
  end

  def test_all_method_response
    storage_accounts = Fog::AzureRM::Storage::StorageAccounts.new(service: @service)
    @service.stub :list_storage_accounts, @list_storage_account_response do
      assert_instance_of Fog::AzureRM::Storage::StorageAccounts, storage_accounts.all
      assert storage_accounts.all.size >= 1
      storage_accounts.all.each do |s|
        assert_instance_of Fog::AzureRM::Storage::StorageAccount, s
      end
    end
  end

  def test_get_method_response
    response = ApiStub::Models::Storage::StorageAccount.create_storage_account(@storage_mgmt_client)
    @service.stub :get_storage_account, response do
      assert_instance_of Fog::AzureRM::Storage::StorageAccount, @storage_accounts.get('fog-test-rg', 'fog-test-storage-account')
    end
  end

  def test_check_name_availability_true_case
    @service.stub :check_storage_account_name_availability, true do
      assert @storage_accounts.check_name_availability('fog-test-storage-account')
    end
  end

  def test_check_name_availability_false_case
    @service.stub :check_storage_account_name_availability, false do
      assert !@storage_accounts.check_name_availability('fog-test-storage-account')
    end
  end

  def test_check_storage_account_exists_true_response
    @service.stub :check_storage_account_exists, true do
      assert @storage_accounts.check_storage_account_exists('fog-test-rg', 'fog-test-storage-account')
    end
  end

  def test_check_storage_account_exists_false_response
    @service.stub :check_storage_account_exists, false do
      assert !@storage_accounts.check_storage_account_exists('fog-test-rg', 'fog-test-storage-account')
    end
  end
end
