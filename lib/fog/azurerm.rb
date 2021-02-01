require 'ms_rest_azure'
require 'azure/core/http/http_error'
require 'erb'
require 'fog/azurerm/config'
require 'fog/azurerm/constants'
require 'fog/azurerm/utilities/general'
require 'fog/azurerm/version'
require 'fog/core'
require 'fog/json'
require 'fog/azurerm/models/compute/caching_types'
require 'fog/azurerm/models/compute/disk_create_option_types'
require 'fog/azurerm/models/network/ipallocation_method'
require 'fog/azurerm/models/network/security_rule_access'
require 'fog/azurerm/models/network/security_rule_direction'
require 'fog/azurerm/models/network/security_rule_protocol'
require 'fog/azurerm/models/storage/sku_name'
require 'fog/azurerm/models/storage/sku_tier'
require 'fog/azurerm/models/storage/kind'

module Fog
  module AzureRM
    extend Fog::Provider

    autoload :Credentials, File.expand_path('azurerm/credentials', __dir__)
    autoload :Compute, File.expand_path('azurerm/compute', __dir__)
    autoload :DNS, File.expand_path('azurerm/dns', __dir__)
    autoload :Network, File.expand_path('azurerm/network', __dir__)
    autoload :Resources, File.expand_path('azurerm/resources', __dir__)
    autoload :TrafficManager, File.expand_path('azurerm/traffic_manager', __dir__)
    autoload :Storage, File.expand_path('../azurerm/storage', __FILE__)
    autoload :ApplicationGateway, File.expand_path('azurerm/application_gateway', __dir__)
    autoload :Sql, File.expand_path('azurerm/sql', __dir__)
    autoload :KeyVault, File.expand_path('azurerm/key_vault', __dir__)
    autoload :AsyncResponse, File.expand_path('azurerm/async_response', __dir__)

    service(:resources, 'Resources')
    service(:dns, 'DNS')
    service(:storage, 'Storage')
    service(:network, 'Network')
    service(:compute, 'Compute')
    service(:application_gateway, 'ApplicationGateway')
    service(:traffic_manager, 'TrafficManager')
    service(:sql, 'Sql')
    service(:key_vault, 'KeyVault')
  end
end
