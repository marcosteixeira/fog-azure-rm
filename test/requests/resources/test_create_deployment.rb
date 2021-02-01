require File.expand_path '../../test_helper', __dir__

# Test class for Create Deployment Request
class TestCreateDeployment < Minitest::Test
  def setup
    @service = Fog::AzureRM::Resources.new(credentials)
    @client = @service.instance_variable_get(:@rmc)
    @deployments = @client.deployments
    @resource_group = 'fog-test-rg'
    @deployment_name = 'fog-test-deployment'
    @template_link = 'https://test.com/template.json'
    @parameters_link = 'https://test.com/parameters.json'
  end

  def test_create_deployment_success
    mocked_response = ApiStub::Requests::Resources::Deployment.create_deployment_response(@client)
    @deployments.stub :validate, true do
      @deployments.stub :create_or_update, mocked_response do
        assert_equal @service.create_deployment(@resource_group, @deployment_name, @template_link, @parameters_link), mocked_response
      end
    end
  end

  def test_create_deployment_failure
    response = proc { raise MsRestAzure::AzureOperationError.new(nil, nil, 'error' => { 'message' => 'mocked exception' }) }
    @deployments.stub :validate, true do
      @deployments.stub :create_or_update, response do
        assert_raises(MsRestAzure::AzureOperationError) { @service.create_deployment(@resource_group, @deployment_name, @template_link, @parameters_link) }
      end
    end
  end
end
