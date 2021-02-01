module Fog
  module AzureRM
    class Network
      # ExpressRouteCircuit collection class for Network Service
      class ExpressRouteCircuits < Fog::Collection
        model Fog::AzureRM::Network::ExpressRouteCircuit
        attribute :resource_group

        def all
          requires :resource_group
          express_route_circuits = []
          service.list_express_route_circuits(resource_group).each do |circuit|
            express_route_circuits << Fog::AzureRM::Network::ExpressRouteCircuit.parse(circuit)
          end
          load(express_route_circuits)
        end

        def get(resource_group_name, name)
          circuit = service.get_express_route_circuit(resource_group_name, name)
          express_route_circuit = Fog::AzureRM::Network::ExpressRouteCircuit.new(service: service)
          express_route_circuit.merge_attributes(Fog::AzureRM::Network::ExpressRouteCircuit.parse(circuit))
        end

        def check_express_route_circuit_exists(resource_group_name, name)
          service.check_express_route_circuit_exists(resource_group_name, name)
        end
      end
    end
  end
end
