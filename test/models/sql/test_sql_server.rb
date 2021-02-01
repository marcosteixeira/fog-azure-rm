require File.expand_path '../../test_helper', __dir__

# Test class for Sql Server Model
class TestSqlServer < Minitest::Test
  def setup
    @service = Fog::AzureRM::Sql.new(credentials)
    @sql_server = sql_server(@service)
    @sql_server_client = @service.instance_variable_get(:@sql_mgmt_client)
  end

  def test_model_methods
    methods = [
      :save,
      :destroy
    ]
    methods.each do |method|
      assert_respond_to @sql_server, method
    end
  end

  def test_model_attributes
    attributes = [
      :name,
      :id,
      :type,
      :resource_group,
      :location,
      :version,
      :state,
      :administrator_login,
      :administrator_login_password,
      :fully_qualified_domain_name,
      :tags
    ]
    attributes.each do |attribute|
      assert_respond_to @sql_server, attribute
    end
  end

  def test_save_method_response
    create_response = ApiStub::Models::Sql::SqlServer.create_sql_server(@sql_server_client)
    @service.stub :create_or_update_sql_server, create_response do
      assert_instance_of Fog::AzureRM::Sql::SqlServer, @sql_server.save
    end
  end

  def test_destroy_method_true_response
    @service.stub :delete_sql_server, true do
      assert @sql_server.destroy
    end
  end

  def test_destroy_method_false_response
    @service.stub :delete_sql_server, false do
      assert !@sql_server.destroy
    end
  end
end
