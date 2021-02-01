require File.expand_path '../../test_helper', __dir__

# Test class for Get VM Extension request
class TestGetVMExtension < Minitest::Test
  def setup
    @service = Fog::AzureRM::Compute.new(credentials)
    @compute_client = @service.instance_variable_get(:@compute_mgmt_client)
    @vm_extension = @compute_client.virtual_machine_extensions
  end

  def test_get_vm_extension_success
    response = ApiStub::Requests::Compute::VirtualMachineExtension.create_vm_extension_response(@compute_client)
    @vm_extension.stub :get, response do
      assert_equal @service.get_vm_extension('fog-test-rg', 'fog-test-vm', 'fog-test-extension'), response
    end
  end

  def test_update_vm_extension_failure
    response = proc { raise MsRestAzure::AzureOperationError.new(nil, nil, 'error' => { 'message' => 'mocked exception' }) }
    @vm_extension.stub :get, response do
      assert_raises MsRestAzure::AzureOperationError do
        @service.get_vm_extension('fog-test-rg', 'fog-test-vm', 'fog-test-extension')
      end
    end
  end
end
