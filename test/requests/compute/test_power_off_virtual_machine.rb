require File.expand_path '../../test_helper', __dir__

# Test class for PowerOff Virtual Machine Request
class TestPowerOffVirtualMachine < Minitest::Test
  def setup
    @service = Fog::AzureRM::Compute.new(credentials)
    compute_client = @service.instance_variable_get(:@compute_mgmt_client)
    @virtual_machines = compute_client.virtual_machines
  end

  def test_power_off_virtual_machine_success
    @virtual_machines.stub :power_off, true do
      assert @service.power_off_virtual_machine('fog-test-rg', 'fog-test-server' ,false)
    end

    async_response = Concurrent::Promise.execute { 10 }
    @virtual_machines.stub :power_off_async, async_response do
      assert @service.power_off_virtual_machine('fog-test-rg', 'fog-test-server', true), async_response
    end
  end

  def test_power_off_virtual_machine_failure
    response = proc { fail MsRestAzure::AzureOperationError.new(nil, nil, 'error' => { 'message' => 'mocked exception' }) }
    @virtual_machines.stub :power_off, response do
      assert_raises(MsRestAzure::AzureOperationError) { @service.power_off_virtual_machine('fog-test-rg', 'fog-test-server', false) }
    end

    @virtual_machines.stub :power_off_async, response do
      assert_raises(MsRestAzure::AzureOperationError) { @service.power_off_virtual_machine('fog-test-rg', 'fog-test-server', true) }
    end
  end
end
