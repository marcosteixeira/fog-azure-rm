module Fog
  module AzureRM
    class Resources
      # Provider model class
      class Provider < Fog::Model
        attribute :id
        attribute :namespace
        attribute :registration_state
        attribute :resource_types

        def self.parse(provider)
          hash = {}
          hash['id'] = provider.id
          hash['namespace'] = provider.namespace
          hash['registration_state'] = provider.registration_state if provider.respond_to?('registration_state')

          hash['resource_types'] = []
          provider.resource_types.each do |provider_resource_type|
            provider_resource_type_obj = Fog::AzureRM::Resources::ProviderResourceType.new
            hash['resource_types'] << provider_resource_type_obj.merge_attributes(Fog::AzureRM::Resources::ProviderResourceType.parse(provider_resource_type))
          end
          hash
        end
      end
    end
  end
end
