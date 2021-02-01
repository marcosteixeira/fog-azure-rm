require File.expand_path '../../test_helper', __dir__

# Test class for ExpressRouteCircuitAuthorization Model
class TestExpressRouteCircuitAuthorization < Minitest::Test
  def setup
    @service = Fog::AzureRM::Network.new(credentials)
    @circuit_authorization = express_route_circuit_authorization(@service)
    @network_client = @service.instance_variable_get(:@network_client)
  end

  def test_model_methods
    methods = [
      :save,
      :destroy
    ]
    methods.each do |method|
      assert_respond_to @circuit_authorization, method
    end
  end

  def test_model_attributes
    attributes = [
      :name,
      :id,
      :resource_group,
      :authorization_name,
      :authorization_key,
      :authorization_use_status,
      :provisioning_state,
      :etag,
      :circuit_name
    ]
    attributes.each do |attribute|
      assert_respond_to @circuit_authorization, attribute
    end
  end

  def test_save_method_response
    response = ApiStub::Models::Network::ExpressRouteCircuitAuthorization.create_express_route_circuit_authorization_response(@network_client)
    @service.stub :create_or_update_express_route_circuit_authorization, response do
      assert_instance_of Fog::AzureRM::Network::ExpressRouteCircuitAuthorization, @circuit_authorization.save
    end
  end

  def test_destroy_method_response
    @service.stub :delete_express_route_circuit_authorization, true do
      assert @circuit_authorization.destroy
    end
  end
end
