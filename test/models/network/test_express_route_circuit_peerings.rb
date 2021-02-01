require File.expand_path '../../test_helper', __dir__

# Test class for ExpressRouteCircuitPeering Collection
class TestExpressRouteCircuitPeerings < Minitest::Test
  def setup
    @service = Fog::AzureRM::Network.new(credentials)
    @circuit_peerings = Fog::AzureRM::Network::ExpressRouteCircuitPeerings.new(resource_group: 'fog-test-rg', circuit_name: 'testCircuit', service: @service)
    @network_client = @service.instance_variable_get(:@network_client)
  end

  def test_collection_methods
    methods = [
      :all,
      :get
    ]
    methods.each do |method|
      assert_respond_to @circuit_peerings, method
    end
  end

  def test_collection_attributes
    assert_respond_to @circuit_peerings, :resource_group
    assert_respond_to @circuit_peerings, :circuit_name
  end

  def test_all_method_response
    response = [ApiStub::Models::Network::ExpressRouteCircuitPeering.create_express_route_circuit_peering_response(@network_client)]
    @service.stub :list_express_route_circuit_peerings, response do
      assert_instance_of Fog::AzureRM::Network::ExpressRouteCircuitPeerings, @circuit_peerings.all
      assert @circuit_peerings.all.size >= 1
      @circuit_peerings.all.each do |circuit_peering|
        assert_instance_of Fog::AzureRM::Network::ExpressRouteCircuitPeering, circuit_peering
      end
    end
  end

  def test_get_method_response
    response = ApiStub::Models::Network::ExpressRouteCircuitPeering.create_express_route_circuit_peering_response(@network_client)
    @service.stub :get_express_route_circuit_peering, response do
      assert_instance_of Fog::AzureRM::Network::ExpressRouteCircuitPeering, @circuit_peerings.get('HaiderRG', 'AzurePrivatePeering', 'testCircuit')
    end
  end
end
