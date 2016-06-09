module Fog
  module Network
    class AzureRM
      # Application Gateway model class for Network Service
      class ApplicationGateway < Fog::Model
        identity :name
        attribute :id
        attribute :location
        attribute :resource_group
        attribute :provisioningState
        attribute :skuName
        attribute :skuTier
        attribute :skuCapacity
        attribute :operationalState
        attribute :gatewayIpConfigurations
        attribute :sslCertificates
        attribute :frontendIpConfigurations
        attribute :frontendPorts
        attribute :probes
        attribute :backendAddressPools
        attribute :backendHttpSettingsList
        attribute :httpListeners
        attribute :urlPathMaps
        attribute :requestRoutingRules

        def self.parse(gateway)
          gateway_properties = gateway['properties']

          hash = {}
          hash['name'] = gateway['name']
          hash['id'] = gateway['id']
          hash['location'] = gateway['location']
          hash['resource_group'] = gateway['id'].split('/')[4]
          unless gateway_properties.nil?
            hash['provisioningState'] = gateway_properties['provisioningState']
            unless gateway_properties['sku'].nil?
              hash['skuName'] = gateway_properties['sku']['name']
              hash['skuTier'] = gateway_properties['sku']['tier']
              hash['skuCapacity'] = gateway_properties['sku']['capacity']
            end
            hash['operationalState'] = gateway_properties['operationalState']

            hash['gatewayIpConfigurations'] = []
            gateway_properties['gatewayIpConfigurations'].each do |ip_configuration|
              gateway_ip_configuration = Fog::Network::AzureRM::GatewayIPConfiguration.new
              hash['gatewayIpConfigurations'] << gateway_ip_configuration.merge_attributes(Fog::Network::AzureRM::GatewayIPConfiguration.parse(ip_configuration))
            end unless gateway_properties['gatewayIpConfigurations'].nil?

            hash['sslCertificates'] = []
            gateway_properties['sslCertificates'].each do |certificate|
              ssl_certificate = Fog::Network::AzureRM::SslCertificate.new
              hash['sslCertificates'] << ssl_certificate.merge_attributes(Fog::Network::AzureRM::SslCertificate.parse(certificate))
            end unless gateway_properties['sslCertificates'].nil?

            hash['frontendIpConfigurations'] = []
            gateway_properties['frontendIpConfigurations'].each do |frontend_ip_config|
              frontend_ip_configuration = Fog::Network::AzureRM::FrontendIPConfiguration.new
              hash['frontendIpConfigurations'] << frontend_ip_configuration.merge_attributes(Fog::Network::AzureRM::FrontendIPConfiguration.parse(frontend_ip_config))
            end unless gateway_properties['frontendIpConfigurations'].nil?

            hash['frontendPorts'] = []
            gateway_properties['frontendPorts'].each do |port|
              frontend_port = Fog::Network::AzureRM::FrontendPort.new
              hash['frontendPorts'] << frontend_port.merge_attributes(Fog::Network::AzureRM::FrontendPort.parse(port))
            end unless gateway_properties['frontendPorts'].nil?

            hash['probes'] = []
            gateway_properties['probes'].each do |probe|
              gateway_probe = Fog::Network::AzureRM::Probe.new
              hash['probes'] << gateway_probe.merge_attributes(Fog::Network::AzureRM::Probe.parse(probe))
            end unless gateway_properties['probes'].nil?

            hash['backendAddressPools'] = []
            gateway_properties['backendAddressPools'].each do |address|
              backend_address_pool = Fog::Network::AzureRM::BackendAddressPool.new
              hash['backendAddressPools'] << backend_address_pool.merge_attributes(Fog::Network::AzureRM::BackendAddressPool.parse(address))
            end unless gateway_properties['backendAddressPools'].nil?

            hash['backendHttpSettingsList'] = []
            gateway_properties['backendHttpSettingsCollection'].each do |http_setting|
              backend_http_setting = Fog::Network::AzureRM::BackendHttpSetting.new
              hash['backendHttpSettingsList'] << backend_http_setting.merge_attributes(Fog::Network::AzureRM::BackendHttpSetting.parse(http_setting))
            end unless gateway_properties['backendHttpSettingsCollection'].nil?

            hash['httpListeners'] = []
            gateway_properties['httpListeners'].each do |listener|
              http_listener = Fog::Network::AzureRM::HttpListener.new
              hash['httpListeners'] << http_listener.merge_attributes(Fog::Network::AzureRM::HttpListener.parse(listener))
            end unless gateway_properties['httpListeners'].nil?

            hash['urlPathMaps'] = []
            gateway_properties['urlPathMaps'].each do |map|
              url_path_map = Fog::Network::AzureRM::UrlPathMap.new
              hash['urlPathMaps'] << url_path_map.merge_attributes(Fog::Network::AzureRM::UrlPathMap.parse(map))
            end unless gateway_properties['urlPathMaps'].nil?

            hash['requestRoutingRules'] = []
            gateway_properties['requestRoutingRules'].each do |rule|
              request_routing_rule = Fog::Network::AzureRM::RequestRoutingRule.new
              hash['requestRoutingRules'] << request_routing_rule.merge_attributes(Fog::Network::AzureRM::RequestRoutingRule.parse(rule))
            end unless gateway_properties['requestRoutingRules'].nil?
          end
          hash
        end

        def save
          requires :name, :location, :resource_group, :skuName, :skuTier, :skuCapacity, :gatewayIpConfigurations, :frontendIpConfigurations, :frontendPorts, :backendAddressPools, :backendHttpSettingsList, :httpListeners, :requestRoutingRules
          gateway = service.create_application_gateway(name, location, resource_group, skuName, skuTier, skuCapacity, gatewayIpConfigurations, frontendIpConfigurations, frontendPorts, backendAddressPools, backendHttpSettingsList, httpListeners, requestRoutingRules)
          merge_attributes(Fog::Network::AzureRM::ApplicationGateway.parse(gateway))
        end

        def destroy
          service.delete_application_gateway(resource_group, name)
        end
      end
    end
  end
end
