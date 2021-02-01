require File.expand_path '../../test_helper', __dir__

# Test class for Create Subnet Request
class TestCreateSubnet < Minitest::Test
  def setup
    @service = Fog::AzureRM::Network.new(credentials)
    @network_client = @service.instance_variable_get(:@network_client)
    @subnets = @network_client.subnets
  end

  def test_create_subnet_success
    mocked_response = ApiStub::Requests::Network::Subnet.create_subnet_response(@network_client)
    @subnets.stub :create_or_update, mocked_response do
      assert_equal @service.create_subnet('fog-test-rg', 'fog-test-subnet', 'fog-test-virtual-network', '10.1.0.0/24', 'nsg-id', 'table-id'), mocked_response
    end
  end

  def test_create_subnet_argument_error_failure
    response = ApiStub::Requests::Network::Subnet.create_subnet_response(@network_client)
    @subnets.stub :create_or_update, response do
      assert_raises ArgumentError do
        @service.create_subnet('fog-test-rg', 'fog-test-subnet', 'fog-test-virtual-network')
      end
    end
  end

  def test_create_subnet_exception_failure
    response = proc { raise MsRestAzure::AzureOperationError.new(nil, nil, 'error' => { 'message' => 'mocked exception' }) }
    @subnets.stub :create_or_update, response do
      assert_raises MsRestAzure::AzureOperationError do
        @service.create_subnet('fog-test-rg', 'fog-test-subnet', 'fog-test-virtual-network', '10.1.0.0/24', 'nsg-id', 'table-id')
      end
    end
  end
end
