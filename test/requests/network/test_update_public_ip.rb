require File.expand_path '../../test_helper', __dir__

# Test Class for Update Public IP Request
class TestUpdatePublicIp < Minitest::Test
  def setup
    @service = Fog::AzureRM::Network.new(credentials)
    network_client = @service.instance_variable_get(:@network_client)
    @public_ips = network_client.public_ipaddresses
    @response = ApiStub::Requests::Network::PublicIp.create_public_ip_response(network_client)
    @tags = { key: 'value' }
  end

  def test_update_public_ip_success
    @public_ips.stub :create_or_update, @response do
      assert_equal @service.create_or_update_public_ip('TestRG', 'testPubIp432', 'West US', 'Dynamic', '4', 'mylabel', @tags), @response
    end
  end

  def test_update_public_ip_argument_error_failure
    @public_ips.stub :create_or_update, @response do
      assert_raises ArgumentError do
        @service.create_or_update_public_ip('fog-test-rg', 'fog-test-public-ip', 'West US')
      end
    end
  end

  def test_update_public_ip_exception_failure
    response = proc { raise MsRestAzure::AzureOperationError.new(nil, nil, 'error' => { 'message' => 'mocked exception' }) }
    @public_ips.stub :create_or_update, response do
      assert_raises MsRestAzure::AzureOperationError do
        @service.create_or_update_public_ip('fog-test-rg', 'fog-test-public-ip', 'West US', 'Dynamic', '4', 'mylabel', @tags)
      end
    end
  end
end
