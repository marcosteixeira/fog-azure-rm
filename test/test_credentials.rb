require File.expand_path 'test_helper', __dir__

# Test class for Credentials Helper Class
class TestCredentials < Minitest::Test
  def setup
    @creds = credentials
  end

  def test_methods
    methods = [
      :get_credentials,
      :get_token
    ]
    methods.each do |method|
      assert Fog::AzureRM::Credentials.respond_to? method
    end
  end

  def test_get_credentials_method_with_same_client
    cred_obj_one = Fog::AzureRM::Credentials.get_credentials(@creds[:tenant_id], @creds[:client_id], @creds[:client_secret])
    cred_obj_two = Fog::AzureRM::Credentials.get_credentials(@creds[:tenant_id], @creds[:client_id], @creds[:client_secret])
    assert_equal cred_obj_one.object_id, cred_obj_two.object_id
  end

  def test_get_credentials_method_with_different_client
    cred_obj_one = Fog::AzureRM::Credentials.get_credentials(@creds[:tenant_id], @creds[:client_id], @creds[:client_secret])
    @creds[:client_id] = '<NEW-CLIENT-ID>'
    cred_obj_two = Fog::AzureRM::Credentials.get_credentials(@creds[:tenant_id], @creds[:client_id], @creds[:client_secret])
    refute_equal cred_obj_one.object_id, cred_obj_two.object_id
  end

  def test_get_token_method_with_default_environment
    Fog::AzureRM::Credentials.get_credentials(@creds[:tenant_id], @creds[:client_id], @creds[:client_secret])
    token_provider = Fog::AzureRM::Credentials.instance_variable_get(:@token_provider)
    token_provider.stub :get_authentication_header, 'Bearer <some-token>' do
      assert_equal Fog::AzureRM::Credentials.get_token(@creds[:tenant_id], @creds[:client_id], @creds[:client_secret]), 'Bearer <some-token>'
    end
  end

  def test_get_token_method_with_china_environment
    Fog::AzureRM::Credentials.get_credentials(@creds[:tenant_id], @creds[:client_id], @creds[:client_secret], ENVIRONMENT_AZURE_CHINA_CLOUD)
    token_provider = Fog::AzureRM::Credentials.instance_variable_get(:@token_provider)
    token_provider.stub :get_authentication_header, 'Bearer <some-token>' do
      assert_equal Fog::AzureRM::Credentials.get_token(@creds[:tenant_id], @creds[:client_id], @creds[:client_secret]), 'Bearer <some-token>'
    end
  end

  def test_get_token_method_with_us_government_environment
    Fog::AzureRM::Credentials.get_credentials(@creds[:tenant_id], @creds[:client_id], @creds[:client_secret], ENVIRONMENT_AZURE_US_GOVERNMENT)
    token_provider = Fog::AzureRM::Credentials.instance_variable_get(:@token_provider)
    token_provider.stub :get_authentication_header, 'Bearer <some-token>' do
      assert_equal Fog::AzureRM::Credentials.get_token(@creds[:tenant_id], @creds[:client_id], @creds[:client_secret]), 'Bearer <some-token>'
    end
  end

  def test_get_token_method_with_german_environment
    Fog::AzureRM::Credentials.get_credentials(@creds[:tenant_id], @creds[:client_id], @creds[:client_secret], ENVIRONMENT_AZURE_GERMAN_CLOUD)
    token_provider = Fog::AzureRM::Credentials.instance_variable_get(:@token_provider)
    token_provider.stub :get_authentication_header, 'Bearer <some-token>' do
      assert_equal Fog::AzureRM::Credentials.get_token(@creds[:tenant_id], @creds[:client_id], @creds[:client_secret]), 'Bearer <some-token>'
    end
  end
end
