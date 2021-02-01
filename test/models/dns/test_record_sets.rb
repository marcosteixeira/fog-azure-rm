require File.expand_path '../../test_helper', __dir__

# Test class for Record Set Collection
class TestRecordSets < Minitest::Test
  def setup
    @service = Fog::AzureRM::DNS.new(credentials)
    @record_sets = Fog::AzureRM::DNS::RecordSets.new(resource_group: 'fog-test-rg', zone_name: 'fog-test-zone.com', type: 'A', service: @service)
    @dns_client1 = @service.instance_variable_get(:@dns_client)
    @response = [ApiStub::Models::DNS::RecordSet.create_record_set_obj(@dns_client1)]
  end

  def test_collection_methods
    methods = [
      :all,
      :get,
      :check_record_set_exists
    ]
    methods.each do |method|
      assert_respond_to @record_sets, method
    end
  end

  def test_collection_attributes
    assert_respond_to @record_sets, :resource_group
    assert_respond_to @record_sets, :zone_name
    assert_respond_to @record_sets, :type
  end

  def test_all_method_response
    @service.stub :list_record_sets, @response do
      assert_instance_of Fog::AzureRM::DNS::RecordSets, @record_sets.all
      assert @record_sets.all.size >= 1
      @record_sets.all.each do |s|
        assert_instance_of Fog::AzureRM::DNS::RecordSet, s
      end
    end
  end

  def test_all_method_name_response
    name_response = ApiStub::Models::DNS::RecordSet.create_record_set_obj(@dns_client1)
    name_response.name = '@'
    response = [name_response]
    @service.stub :list_record_sets, response do
      assert_instance_of Fog::AzureRM::DNS::RecordSets, @record_sets.all
    end
  end

  def test_get_method_response
    response = ApiStub::Models::DNS::RecordSet.create_record_set_obj(@dns_client1)
    @service.stub :get_record_set, response do
      assert_instance_of Fog::AzureRM::DNS::RecordSet, @record_sets.get('fog-test-rg', 'fog-test-record-set', 'fog-test-zone', 'A')
    end
  end

  def test_check_record_set_exists_true_case
    @service.stub :check_record_set_exists, true do
      assert @record_sets.check_record_set_exists('fog-test-rg', 'fog-test-record-set', 'fog-test-zone', 'A')
    end
  end

  def test_check_record_set_exists_false_case
    @service.stub :check_record_set_exists, false do
      assert !@record_sets.check_record_set_exists('fog-test-rg', 'fog-test-record-set', 'fog-test-zone', 'A')
    end
  end
end
