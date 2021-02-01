require File.expand_path '../../test_helper', __dir__

# Test class for Traffic Manager End Point Collection
class TestTrafficManagerEndPoints < Minitest::Test
  def setup
    @service = Fog::AzureRM::TrafficManager.new(credentials)
    @traffic_manager_end_points = Fog::AzureRM::TrafficManager::TrafficManagerEndPoints.new(resource_group: 'fog-test-rg', traffic_manager_profile_name: 'fog-test-profile', service: @service)
    traffic_manager_client = @service.instance_variable_get(:@traffic_mgmt_client)
    @response_endpoint = ApiStub::Models::TrafficManager::TrafficManagerEndPoint.create_traffic_manager_end_point_response(traffic_manager_client)
    @response_endpoints = ApiStub::Models::TrafficManager::TrafficManagerProfile.traffic_manager_profile_response(traffic_manager_client)
  end

  def test_collection_methods
    methods = [
      :all,
      :get,
      :check_traffic_manager_endpoint_exists
    ]
    methods.each do |method|
      assert_respond_to @traffic_manager_end_points, method
    end
  end

  def test_collection_attributes
    assert_respond_to @traffic_manager_end_points, :resource_group
    assert_respond_to @traffic_manager_end_points, :traffic_manager_profile_name
  end

  def test_all_method_response
    @service.stub :get_traffic_manager_profile, @response_endpoints do
      assert_instance_of Fog::AzureRM::TrafficManager::TrafficManagerEndPoints, @traffic_manager_end_points.all
      assert @traffic_manager_end_points.all.size >= 1
      @traffic_manager_end_points.all.each do |endpoint|
        assert_instance_of Fog::AzureRM::TrafficManager::TrafficManagerEndPoint, endpoint
      end
    end
  end

  def test_get_method_response
    @service.stub :get_traffic_manager_end_point, @response_endpoint do
      assert_instance_of Fog::AzureRM::TrafficManager::TrafficManagerEndPoint, @traffic_manager_end_points.get('resource-group-name', 'profile-name', 'endpoint-name1', 'endpoint-type')
    end
  end

  def test_check_traffic_manager_endpoint_exists_true_response
    @service.stub :check_traffic_manager_endpoint_exists, true do
      assert @traffic_manager_end_points.check_traffic_manager_endpoint_exists('resource-group-name', 'profile-name', 'endpoint-name1', 'endpoint-type')
    end
  end

  def test_check_traffic_manager_endpoint_exists_false_response
    @service.stub :check_traffic_manager_endpoint_exists, false do
      assert !@traffic_manager_end_points.check_traffic_manager_endpoint_exists('resource-group-name', 'profile-name', 'endpoint-name1', 'endpoint-type')
    end
  end
end
