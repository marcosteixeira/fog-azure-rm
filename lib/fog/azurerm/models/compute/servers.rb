module Fog
  module AzureRM
    class Compute
      # This class is giving implementation of all/list, and get
      # for Server.
      class Servers < Fog::Collection
        attribute :resource_group
        model Fog::AzureRM::Compute::Server

        def all
          requires :resource_group
          virtual_machines = []
          service.list_virtual_machines(resource_group).each do |vm|
            virtual_machines << Fog::AzureRM::Compute::Server.parse(vm)
          end
          load(virtual_machines)
        end

        def create_async(attributes = {})
          server = new(attributes)
          promise = server.save(true)
          Fog::AzureRM::AsyncResponse.new(server, promise, true, 'update_attributes')
        end

        def get(resource_group_name, virtual_machine_name, async = false)
          response = service.get_virtual_machine(resource_group_name, virtual_machine_name, async)
          virtual_machine = Fog::AzureRM::Compute::Server.new(service: service)
          if async
            Fog::AzureRM::AsyncResponse.new(virtual_machine, response)
          else
            virtual_machine.merge_attributes(Fog::AzureRM::Compute::Server.parse(response))
          end
        end

        def check_vm_exists(resource_group, name, async = false)
          response = service.check_vm_exists(resource_group, name, async)
          if async
            server = Fog::AzureRM::Compute::Server.new(service: service)
            Fog::AzureRM::AsyncResponse.new(server, response)
          else
            response
          end
        end
      end
    end
  end
end
