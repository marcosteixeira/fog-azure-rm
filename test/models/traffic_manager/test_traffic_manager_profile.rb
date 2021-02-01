require File.expand_path '../../test_helper', __dir__

# Test class for Traffic Manager Profile Model
class TestTrafficManagerProfile < Minitest::Test
  def setup
    @service = Fog::AzureRM::TrafficManager.new(credentials)
    @traffic_manager_profile = traffic_manager_profile(@service)
    @traffic_manager_client = @service.instance_variable_get(:@traffic_mgmt_client)
    @traffic_manager_profile_response = ApiStub::Models::TrafficManager::TrafficManagerProfile.traffic_manager_profile_response(@traffic_manager_client)
  end

  def test_model_methods
    methods = [
      :save,
      :destroy,
      :update
    ]
    methods.each do |method|
      assert_respond_to @traffic_manager_profile, method
    end
  end

  def test_model_attributes
    attributes = [
      :name,
      :id,
      :resource_group,
      :location,
      :profile_status,
      :traffic_routing_method,
      :relative_name,
      :fqdn,
      :ttl,
      :profile_monitor_status,
      :protocol,
      :port,
      :path,
      :endpoints,
      :tags
    ]
    attributes.each do |attribute|
      assert_respond_to @traffic_manager_profile, attribute
    end
  end

  def test_save_method_response
    @service.stub :create_or_update_traffic_manager_profile, @traffic_manager_profile_response do
      assert_instance_of Fog::AzureRM::TrafficManager::TrafficManagerProfile, @traffic_manager_profile.save
    end
  end

  def test_update_method_response
    @service.stub :create_or_update_traffic_manager_profile, @traffic_manager_profile_response do
      assert_instance_of Fog::AzureRM::TrafficManager::TrafficManagerProfile, @traffic_manager_profile.update({})
    end
  end

  def test_destroy_method_response
    @service.stub :delete_traffic_manager_profile, true do
      assert @traffic_manager_profile.destroy
    end
  end
end
