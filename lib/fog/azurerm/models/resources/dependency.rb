module Fog
  module AzureRM
    class Resources
      # Dependency model class
      class Dependency < Fog::Model
        attribute :id
        attribute :resource_name
        attribute :resource_type
        attribute :depends_on

        def self.parse(dependency)
          hash = {}
          hash['id'] = dependency.id
          hash['resource_name'] = dependency.resource_name
          hash['resource_type'] = dependency.resource_type

          hash['depends_on'] = []
          dependency.depends_on.each do |sub_dependency|
            dependency_obj = Fog::AzureRM::Resources::Dependency.new
            hash['depends_on'] << dependency_obj.merge_attributes(Fog::AzureRM::Resources::Dependency.parse(sub_dependency))
          end if dependency.respond_to?('depends_on')
          hash
        end
      end
    end
  end
end
