require File.expand_path '../../test_helper', __dir__

# Test class for Attach Route Table to Subnet Request
class TestAttachRouteTableToSubnet < Minitest::Test
  def setup
    @service = Fog::AzureRM::Network.new(credentials)
    @network_client = @service.instance_variable_get(:@network_client)
    @subnets = @network_client.subnets
  end

  def test_attach_route_table_to_subnet_success
    mocked_response = ApiStub::Requests::Network::Subnet.create_subnet_response(@network_client)
    @subnets.stub :create_or_update, mocked_response do
      assert_equal @service.attach_route_table_to_subnet('fog-test-rg', 'fog-test-subnet', 'fog-test-virtual-network', '10.1.0.0/24', 'myNSG1', 'myRT1'), mocked_response
    end
  end

  def test_attach_route_table_to_subnet_failure
    response = proc { raise MsRestAzure::AzureOperationError.new(nil, nil, 'error' => { 'message' => 'mocked exception' }) }
    @subnets.stub :create_or_update, response do
      assert_raises MsRestAzure::AzureOperationError do
        @service.attach_route_table_to_subnet('fog-test-rg', 'fog-test-subnet', 'fog-test-virtual-network', '10.1.0.0/24', 'myNSG1', 'myRT1')
      end
    end
  end
end
