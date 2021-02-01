require File.expand_path '../../test_helper', __dir__

# Test class for Delete Deployment Request
class TestDeleteDeployment < Minitest::Test
  def setup
    @service = Fog::AzureRM::Resources.new(credentials)
    client = @service.instance_variable_get(:@rmc)
    @deployments = client.deployments
    @resource_group = 'fog-test-rg'
    @deployment_name = 'fog-test-deployment'
  end

  def test_delete_deployment_success
    @deployments.stub :delete, true do
      assert @service.delete_deployment(@resource_group, @deployment_name)
    end
  end

  def test_list_deployment_failure
    response = proc { raise MsRestAzure::AzureOperationError.new(nil, nil, 'error' => { 'message' => 'mocked exception' }) }
    @deployments.stub :delete, response do
      assert_raises(MsRestAzure::AzureOperationError) { @service.delete_deployment(@resource_group, @deployment_name) }
    end
  end
end
