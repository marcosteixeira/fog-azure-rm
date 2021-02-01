module Fog
  module AzureRM
    class Sql
      # Sql Server Collection for Server Service
      class SqlServers < Fog::Collection
        attribute :resource_group
        model Fog::AzureRM::Sql::SqlServer

        def all
          requires :resource_group

          servers = []
          service.list_sql_servers(resource_group).each do |server|
            servers << Fog::AzureRM::Sql::SqlServer.parse(server)
          end
          load(servers)
        end

        def get(resource_group, server_name)
          server = service.get_sql_server(resource_group, server_name)
          server_fog = Fog::AzureRM::Sql::SqlServer.new(service: service)
          server_fog.merge_attributes(Fog::AzureRM::Sql::SqlServer.parse(server))
        end

        def check_sql_server_exists(resource_group, server_name)
          service.check_sql_server_exists(resource_group, server_name)
        end
      end
    end
  end
end
