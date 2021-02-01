require File.expand_path '../../test_helper', __dir__

# Test class for List Virtual Networks Request
class TestListVirtualNetworks < Minitest::Test
  def setup
    @service = Fog::AzureRM::Network.new(credentials)
    @network_client = @service.instance_variable_get(:@network_client)
    @virtual_networks = @network_client.virtual_networks
  end

  def test_list_virtual_networks_success
    mocked_response = ApiStub::Requests::Network::VirtualNetwork.list_virtual_networks_response(@network_client)
    @virtual_networks.stub :list_as_lazy, mocked_response do
      assert_equal @service.list_virtual_networks('fog-test-rg'), mocked_response.value
    end
  end

  def test_list_virtual_networks_failure
    response = proc { raise MsRestAzure::AzureOperationError.new(nil, nil, 'error' => { 'message' => 'mocked exception' }) }
    @virtual_networks.stub :list_as_lazy, response do
      assert_raises(MsRestAzure::AzureOperationError) { @service.list_virtual_networks('fog-test-rg') }
    end
  end
end
