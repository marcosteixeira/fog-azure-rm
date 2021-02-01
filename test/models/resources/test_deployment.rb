require File.expand_path '../../test_helper', __dir__

# Test class for Deployment Model
class TestDeployment < Minitest::Test
  def setup
    @service = Fog::AzureRM::Resources.new(credentials)
    client = @service.instance_variable_get(:@rmc)
    @deployment = deployment(@service)
    @response = ApiStub::Models::Resources::Deployment.create_deployment_response(client)
  end

  def test_model_methods
    methods = [
      :save,
      :destroy
    ]
    methods.each do |method|
      assert_respond_to @deployment, method
    end
  end

  def test_model_attributes
    attributes = [
      :name,
      :id,
      :resource_group,
      :correlation_id,
      :timestamp,
      :outputs,
      :providers,
      :dependencies,
      :template_link,
      :parameters_link,
      :mode,
      :debug_setting,
      :content_version,
      :provisioning_state
    ]
    attributes.each do |attribute|
      assert_respond_to @deployment, attribute
    end
  end

  def test_save_method_response
    @service.stub :create_deployment, @response do
      assert_instance_of Fog::AzureRM::Resources::Deployment, @deployment.save
    end
  end

  def test_destroy_method_response
    @service.stub :delete_deployment, @response do
      assert @deployment.destroy
    end
  end
end
