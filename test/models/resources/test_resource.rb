require File.expand_path '../../test_helper', __dir__

# Test class for Resource Model
class TestResource < Minitest::Test
  def setup
    @service = Fog::AzureRM::Resources.new(credentials)
    @resource = Fog::AzureRM::Resources::AzureResource.new
  end

  def test_model_attributes
    attributes = [
      :id,
      :name,
      :type,
      :location,
      :tags
    ]
    attributes.each do |attribute|
      assert_respond_to @resource, attribute
    end
  end
end
