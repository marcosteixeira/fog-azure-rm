require File.expand_path '../../test_helper', __dir__

# Test class for Create Resource Group Request
class TestCreateResourceGroup < Minitest::Test
  def setup
    @service = Fog::AzureRM::Resources.new(credentials)
    @client = @service.instance_variable_get(:@rmc)
    @resource_groups = @client.resource_groups
    @tags = { tagkey1: 'tagvalue1' }
  end

  def test_create_resource_group_success
    mocked_response = ApiStub::Requests::Resources::ResourceGroup.create_resource_group_response(@client)
    @resource_groups.stub :create_or_update, mocked_response do
      assert_equal @service.create_resource_group('fog-test-rg', 'west us', @tags), mocked_response
    end
  end

  def test_create_resource_group_failure
    response = proc { raise MsRestAzure::AzureOperationError.new(nil, nil, 'error' => { 'message' => 'mocked exception' }) }
    @resource_groups.stub :create_or_update, response do
      assert_raises(MsRestAzure::AzureOperationError) { @service.create_resource_group('fog-test-rg', 'west us', @tags) }
    end
  end
end
