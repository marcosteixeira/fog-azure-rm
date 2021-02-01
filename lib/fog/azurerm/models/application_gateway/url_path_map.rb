module Fog
  module AzureRM
    class ApplicationGateway
      # URL Path Map model class for Application Gateway Service
      class UrlPathMap < Fog::Model
        identity :name
        attribute :id
        attribute :default_backend_address_pool_id
        attribute :default_backend_http_settings_id
        attribute :path_rules

        def self.parse(url_path_map)
          hash = {}
          hash['id'] = url_path_map.id
          hash['name'] = url_path_map.name
          hash['default_backend_address_pool_id'] = url_path_map.default_backend_address_pool.id unless url_path_map.default_backend_address_pool.nil?
          hash['default_backend_http_settings_id'] = url_path_map.default_backend_http_settings.id unless url_path_map.default_backend_http_settings.nil?

          path_rules = url_path_map.path_rules
          hash['path_rules'] = []
          path_rules.each do |rule|
            path_rule = Fog::AzureRM::Network::PathRule.new
            hash['path_rules'] << path_rule.merge_attributes(Fog::AzureRM::Network::PathRule.parse(rule))
          end unless path_rules.nil?
          hash
        end
      end
    end
  end
end
