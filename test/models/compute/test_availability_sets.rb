require File.expand_path '../../test_helper', __dir__

# Test class for Availability Set Collection
class TestAvailabilitySets < Minitest::Test
  def setup
    @service = Fog::AzureRM::Compute.new(credentials)
    @availability_sets = Fog::AzureRM::Compute::AvailabilitySets.new(resource_group: 'fog-test-rg', service: @service)
    client = @service.instance_variable_get(:@compute_mgmt_client)
    @availability_set_list = [ApiStub::Models::Compute::AvailabilitySet.list_availability_set_response(client)]
    @availability_set = ApiStub::Models::Compute::AvailabilitySet.get_availability_set_response(client)
  end

  def test_collection_methods
    methods = [
      :all,
      :get,
      :check_availability_set_exists
    ]
    methods.each do |method|
      assert_respond_to @availability_sets, method
    end
  end

  def test_collection_attributes
    assert_respond_to @availability_sets, :resource_group
  end

  def test_all_method_response
    @service.stub :list_availability_sets, @availability_set_list do
      assert_instance_of Fog::AzureRM::Compute::AvailabilitySets, @availability_sets.all
      assert @availability_sets.all.size >= 1
      @availability_sets.all.each do |s|
        assert_instance_of Fog::AzureRM::Compute::AvailabilitySet, s
      end
    end
  end

  def test_get_method_response
    @service.stub :get_availability_set, @availability_set do
      assert_instance_of Fog::AzureRM::Compute::AvailabilitySet, @availability_sets.get('fog-test-rg', 'fog-test-availability-set')
    end
  end

  def test_check_availability_set_exists_true_case
    @service.stub :check_availability_set_exists, true do
      assert @availability_sets.check_availability_set_exists('fog-test-rg', 'fog-test-availability-set')
    end
  end

  def test_check_availability_set_exists_false_case
    @service.stub :check_availability_set_exists, false do
      assert !@availability_sets.check_availability_set_exists('fog-test-rg', 'fog-test-availability-set')
    end
  end
end
