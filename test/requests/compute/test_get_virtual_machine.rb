require File.expand_path '../../test_helper', __dir__

# Test class for Get Virtual Machine Request
class TestGetVirtualMachine < Minitest::Test
  def setup
    @service = Fog::AzureRM::Compute.new(credentials)
    @compute_client = @service.instance_variable_get(:@compute_mgmt_client)
    @virtual_machines = @compute_client.virtual_machines
  end

  def test_get_virtual_machine_success
    response = ApiStub::Requests::Compute::VirtualMachine.create_virtual_machine_response(@compute_client)
    @virtual_machines.stub :get, response do
      assert_equal @service.get_virtual_machine('fog-test-rg', 'fog-test-server', false), response
    end
  end

  def test_get_virtual_machine_failure
    response = proc { fail MsRestAzure::AzureOperationError.new(nil, nil, 'error' => { 'message' => 'mocked exception' }) }
    @virtual_machines.stub :get, response do
      assert_raises(MsRestAzure::AzureOperationError) { @service.get_virtual_machine('fog-test-rg', 'fog-test-server', false) }
    end
  end
end
