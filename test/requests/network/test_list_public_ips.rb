require File.expand_path '../../test_helper', __dir__

# Test class for List Public Ips Request
class TestListPublicIps < Minitest::Test
  def setup
    @service = Fog::AzureRM::Network.new(credentials)
    @network_client = @service.instance_variable_get(:@network_client)
    @public_ips = @network_client.public_ipaddresses
  end

  def test_list_public_ips_success
    mocked_response = ApiStub::Requests::Network::PublicIp.list_public_ips_response(@network_client)
    @public_ips.stub :list_as_lazy, mocked_response do
      assert_equal @service.list_public_ips('fog-test-rg'), mocked_response.value
    end
  end

  def test_list_public_ips_failure
    response = proc { raise MsRestAzure::AzureOperationError.new(nil, nil, 'error' => { 'message' => 'mocked exception' }) }
    @public_ips.stub :list_as_lazy, response do
      assert_raises(MsRestAzure::AzureOperationError) { @service.list_public_ips('fog-test-rg') }
    end
  end
end
