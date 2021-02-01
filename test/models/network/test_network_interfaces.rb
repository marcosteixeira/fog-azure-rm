require File.expand_path '../../test_helper', __dir__

# Test class for NetworkInterface Collection
class TestNetworkInterfaces < Minitest::Test
  def setup
    @service = Fog::AzureRM::Network.new(credentials)
    @network_interfaces = Fog::AzureRM::Network::NetworkInterfaces.new(resource_group: 'fog-test-rg', service: @service)
    @network_client = @service.instance_variable_get(:@network_client)
  end

  def test_collection_methods
    methods = [
      :all,
      :get,
      :check_network_interface_exists
    ]
    methods.each do |method|
      assert_respond_to @network_interfaces, method
    end
  end

  def test_collection_attributes
    assert_respond_to @network_interfaces, :resource_group
  end

  def test_all_method_response
    response = [ApiStub::Models::Network::NetworkInterface.create_network_interface_response(@network_client)]
    @service.stub :list_network_interfaces, response do
      assert_instance_of Fog::AzureRM::Network::NetworkInterfaces, @network_interfaces.all
      assert @network_interfaces.all.size >= 1
      @network_interfaces.all.each do |nic|
        assert_instance_of Fog::AzureRM::Network::NetworkInterface, nic
      end
    end
  end

  def test_get_method_response
    response = ApiStub::Models::Network::NetworkInterface.create_network_interface_response(@network_client)
    @service.stub :get_network_interface, response do
      assert_instance_of Fog::AzureRM::Network::NetworkInterface, @network_interfaces.get('fog-test-rg', 'fog-test-network-interface')
    end
  end

  def test_check_network_interface_exists_true_response
    @service.stub :check_network_interface_exists, true do
      assert @network_interfaces.check_network_interface_exists('fog-test-rg', 'fog-test-network-interface')
    end
  end

  def test_check_network_interface_exists_false_response
    @service.stub :check_network_interface_exists, false do
      assert !@network_interfaces.check_network_interface_exists('fog-test-rg', 'fog-test-network-interface')
    end
  end
end
