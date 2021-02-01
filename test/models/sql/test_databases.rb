require File.expand_path '../../test_helper', __dir__

# Test class for Database Collection
class TestDatabases < Minitest::Test
  def setup
    @service = Fog::AzureRM::Sql.new(credentials)
    @databases = databases(@service)
    @database_client = @service.instance_variable_get(:@sql_mgmt_client)
    @database_response = ApiStub::Models::Sql::SqlDatabase.create_database(@database_client)
  end

  def test_collection_methods
    methods = [
      :all,
      :get
    ]
    methods.each do |method|
      assert_respond_to @databases, method
    end
  end

  def test_collection_attributes
    assert_respond_to @databases, :resource_group
    assert_respond_to @databases, :server_name
  end

  def test_all_method_response
    @service.stub :list_databases, [@database_response] do
      assert_instance_of Fog::AzureRM::Sql::SqlDatabases, @databases.all
      assert @databases.all.size >= 1
      @databases.all.each do |s|
        assert_instance_of Fog::AzureRM::Sql::SqlDatabase, s
      end
    end
  end

  def test_get_method_response
    @service.stub :get_database, @database_response do
      assert_instance_of Fog::AzureRM::Sql::SqlDatabase, @databases.get('fog-test-rg', 'fog-test-server-name', 'fog-test-database-name')
    end
  end
end
