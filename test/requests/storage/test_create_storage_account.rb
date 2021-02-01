require File.expand_path '../../test_helper', __dir__

# Test Class for Create Storage Account Request
class TestCreateStorageAccount < Minitest::Test
  # This class posesses the test cases for the requests of storage account service.
  def setup
    @azure_credentials = Fog::AzureRM::Storage.new(credentials)
    @storage_mgmt_client = @azure_credentials.instance_variable_get(:@storage_mgmt_client)
    @storage_accounts = @storage_mgmt_client.storage_accounts
    @storage_account_arguments = ApiStub::Requests::Storage::StorageAccount.storage_account_arguments
    @storage_acc_obj = ApiStub::Requests::Storage::StorageAccount.storage_account_request(@storage_mgmt_client)
  end

  def test_create_storage_account_success
    @storage_accounts.stub :create, @storage_acc_obj do
      assert_equal @azure_credentials.create_storage_account(@storage_account_arguments), @storage_acc_obj
    end
  end

  def test_create_storage_account_failure
    @storage_accounts.stub :create, @storage_acc_obj do
      assert_raises ArgumentError do
        @azure_credentials.create_storage_account
      end
    end
  end

  def test_create_storage_account_exception
    raise_exception = proc { fail MsRestAzure::AzureOperationError.new(nil, nil, 'error' => { 'message' => 'mocked exception' }) }
    @storage_accounts.stub :create, raise_exception do
      assert_raises(MsRestAzure::AzureOperationError) { @azure_credentials.create_storage_account(@storage_account_arguments) }
    end
  end
end
