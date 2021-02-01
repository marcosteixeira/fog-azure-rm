require File.expand_path '../../test_helper', __dir__

# Test class for Set Connection Shared Key Request
class TestResetConnectionSharedKey < Minitest::Test
  def setup
    @service = Fog::AzureRM::Network.new(credentials)
    @network_client = @service.instance_variable_get(:@network_client)
    @gateway_connections = @network_client.virtual_network_gateway_connections
  end

  def test_reset_connection_shared_key_success
    @gateway_connections.stub :reset_shared_key, nil do
      assert_equal @service.reset_connection_shared_key('fog-test-rg', 'fog-test-gateway-connection', '20'), true
    end
  end

  def test_reset_connection_shared_key_failure
    response = proc { raise MsRestAzure::AzureOperationError.new(nil, nil, 'error' => { 'message' => 'mocked exception' }) }
    @gateway_connections.stub :reset_shared_key, response do
      assert_raises(MsRestAzure::AzureOperationError) { @service.reset_connection_shared_key('fog-test-rg', 'fog-test-gateway-connection', '20') }
    end
  end
end
