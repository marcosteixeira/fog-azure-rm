module Fog
  module AzureRM
    class Resources
      # This class is giving implementation of create/save and
      # delete/destroy for Deployment model.
      class Deployment < Fog::Model
        identity :name
        attribute :id
        attribute :resource_group
        attribute :correlation_id
        attribute :timestamp
        attribute :outputs
        attribute :providers
        attribute :dependencies
        attribute :template_link
        attribute :parameters_link
        attribute :mode
        attribute :debug_setting
        attribute :content_version
        attribute :provisioning_state

        def self.parse(deployment)
          hash = {}
          hash['name'] = deployment.name
          hash['id'] = deployment.id
          hash['resource_group'] = get_resource_from_resource_id(deployment.id, RESOURCE_GROUP_NAME)
          hash['correlation_id'] = deployment.properties.correlation_id
          hash['timestamp'] = deployment.properties.timestamp
          hash['outputs'] = deployment.properties.outputs

          hash['providers'] = []
          deployment.properties.providers.each do |provider|
            provider_obj = Fog::AzureRM::Resources::Provider.new
            hash['providers'] << provider_obj.merge_attributes(Fog::AzureRM::Resources::Provider.parse(provider))
          end

          hash['dependencies'] = []
          deployment.properties.dependencies.each do |dependency|
            dependency_obj = Fog::AzureRM::Resources::Dependency.new
            hash['dependencies'] << dependency_obj.merge_attributes(Fog::AzureRM::Resources::Dependency.parse(dependency))
          end

          hash['template_link'] = deployment.properties.template_link.uri
          hash['parameters_link'] = deployment.properties.parameters_link.uri
          hash['content_version'] = deployment.properties.template_link.content_version
          hash['mode'] = deployment.properties.mode
          hash['debug_setting'] = deployment.properties.debug_setting.detail_level unless deployment.properties.debug_setting.nil?
          hash['provisioning_state'] = deployment.properties.provisioning_state
          hash
        end

        def save
          requires :name, :resource_group, :template_link, :parameters_link

          deployment = service.create_deployment(resource_group, name, template_link, parameters_link)
          merge_attributes(Fog::AzureRM::Resources::Deployment.parse(deployment))
        end

        def destroy
          service.delete_deployment(resource_group, name)
        end
      end
    end
  end
end
