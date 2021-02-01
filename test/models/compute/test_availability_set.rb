require File.expand_path '../../test_helper', __dir__

# Test class for Availability Set Model
class TestAvailabilitySet < Minitest::Test
  def setup
    @service = Fog::AzureRM::Compute.new(credentials)
    @availability_set = availability_set(@service)
    compute_client = @service.instance_variable_get(:@compute_mgmt_client)
    @response = ApiStub::Models::Compute::AvailabilitySet.create_unmanaged_availability_set_response(compute_client)
  end

  def test_model_methods
    methods = [
      :save,
      :destroy
    ]
    methods.each do |method|
      assert_respond_to @availability_set, method
    end
  end

  def test_model_attributes
    attributes = [
      :id,
      :name,
      :type,
      :location,
      :resource_group,
      :platform_update_domain_count,
      :platform_fault_domain_count,
      :use_managed_disk,
      :sku_name,
      :tags
    ]
    attributes.each do |attribute|
      assert_respond_to @availability_set, attribute
    end
  end

  def test_save_method_response
    @service.stub :create_availability_set, @response do
      assert_instance_of Fog::AzureRM::Compute::AvailabilitySet, @availability_set.save
    end
  end

  def test_destroy_method_true_response
    @service.stub :delete_availability_set, true do
      assert @availability_set.destroy
    end
  end

  def test_destroy_method_false_response
    @service.stub :delete_availability_set, false do
      assert !@availability_set.destroy
    end
  end
end
