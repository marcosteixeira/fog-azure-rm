module Fog
  module AzureRM
    class ApplicationGateway
      # Application Gateway collection class for Application Gateway Service
      class Gateways < Fog::Collection
        model Fog::AzureRM::ApplicationGateway::Gateway
        attribute :resource_group

        def all
          requires :resource_group
          application_gateways = []
          service.list_application_gateways(resource_group).each do |gateway|
            application_gateways << Fog::AzureRM::ApplicationGateway::Gateway.parse(gateway)
          end
          load(application_gateways)
        end

        def get(resource_group_name, application_gateway_name)
          gateway = service.get_application_gateway(resource_group_name, application_gateway_name)
          application_gateway = Fog::AzureRM::ApplicationGateway::Gateway.new(service: service)
          application_gateway.merge_attributes(Fog::AzureRM::ApplicationGateway::Gateway.parse(gateway))
        end

        def check_application_gateway_exists(resource_group_name, application_gateway_name)
          service.check_ag_exists(resource_group_name, application_gateway_name)
        end
      end
    end
  end
end
