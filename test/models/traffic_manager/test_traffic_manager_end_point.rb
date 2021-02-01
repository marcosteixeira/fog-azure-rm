require File.expand_path '../../test_helper', __dir__

# Test class for Traffic Manager End Point Model
class TestTrafficManagerEndPoint < Minitest::Test
  def setup
    @service = Fog::AzureRM::TrafficManager.new(credentials)
    @traffic_manager_end_point = traffic_manager_end_point(@service)
    @traffic_manager_client = @service.instance_variable_get(:@traffic_mgmt_client)
  end

  def test_model_methods
    methods = [
      :save,
      :destroy
    ]
    methods.each do |method|
      assert_respond_to @traffic_manager_end_point, method
    end
  end

  def test_model_attributes
    attributes = [
      :name,
      :traffic_manager_profile_name,
      :id,
      :resource_group,
      :type,
      :target_resource_id,
      :target,
      :endpoint_status,
      :endpoint_monitor_status,
      :weight,
      :priority,
      :endpoint_location,
      :min_child_endpoints
    ]
    attributes.each do |attribute|
      assert_respond_to @traffic_manager_end_point, attribute
    end
  end

  def test_save_method_response
    response = ApiStub::Models::TrafficManager::TrafficManagerEndPoint.create_traffic_manager_end_point_response(@traffic_manager_client)
    @service.stub :create_or_update_traffic_manager_endpoint, response do
      assert_instance_of Fog::AzureRM::TrafficManager::TrafficManagerEndPoint, @traffic_manager_end_point.save
    end
  end

  def test_destroy_method_response
    @service.stub :delete_traffic_manager_endpoint, true do
      assert @traffic_manager_end_point.destroy
    end
  end
end
