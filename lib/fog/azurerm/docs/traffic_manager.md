# Traffic Manager

This document explains how to get started using Azure Traffic Manager Service with Fog. With this gem you can create, update, list or delete Traffic Manager Profiles and End Points.

## Usage

First of all, you need to require the Fog library by executing:

```ruby
require 'fog/azurerm'
```
## Create Connection

Next, create a connection to the Traffic Manager Service:

```ruby
fog_traffic_manager_service = Fog::AzureRM::TrafficManager.new(
      tenant_id:        '<Tenant Id>',                                                          # Tenant Id of Azure Active Directory Application
      client_id:        '<Client Id>',                                                          # Client Id of Azure Active Directory Application
      client_secret:    '<Client Secret>',                                                      # Client Secret of Azure Active Directory Application
      subscription_id:  '<Subscription Id>',                                                    # Subscription Id of an Azure Account
      environment:      '<AzureCloud/AzureChinaCloud/AzureUSGovernment/AzureGermanCloud>'       # Azure cloud environment. Default is AzureCloud.
)
```

## Check Traffic Manager Profile Existence

```ruby
fog_traffic_manager_service.traffic_manager_profiles.check_traffic_manager_profile_exists('<Resource Group Name>', '<Profile Name>')
```

## Create Traffic Manager Profile

Create a new Traffic Manager Profile. The parameter 'traffic_routing_method' can be 'Performance', 'Weighted' or 'Priority'.

```ruby
profile = fog_traffic_manager_service.traffic_manager_profiles.create(
        name: '<Profile Name>',
        resource_group: '<Resource Group Name>',
        traffic_routing_method: '<Routing Method Name>',
        relative_name: '<Profile Relative Name>',
        ttl: '<TTL>',
        protocol: '<Protocol Name>',
        port: '<Port Number>',
        path: '<Path>',
        tags: { key1: 'value1', key2: 'value2', keyN: 'valueN' }                          # [Optional]
)
```

## List Traffic Manager Profiles

List Traffic Manager Profiles in a resource group

```ruby
profiles  = fog_traffic_manager_service.traffic_manager_profiles(resource_group: '<Resource Group Name>')
profiles.each do |profile|
    puts "#{profile.name}"
end
```

## Retrieve a single Traffic Manager Profile

Get a single record of Traffic Manager Profile

```ruby
profile = fog_traffic_manager_service
             .traffic_manager_profiles
             .get('<Resource Group Name>', '<Profile Name>')
puts "#{profile.name}"
```

## Update a Traffic Manager Profile

Get a Traffic Manager Profile object from the get method and then update that Traffic Manager Profile. You can update the Traffic Manager Profile by passing the modifiable attributes in the form of a hash.

```ruby
profile.update(
              traffic_routing_method: '<Routing Method Name>',
              ttl: '<TTL>',
              protocol: '<Protocol Name>',
              port: '<Port Number>',
              path: '<Path>'
)
```

## Destroy a single Traffic Manager Profile

Get a Traffic Manager Profile object from the get method and then destroy that Traffic Manager Profile.

```ruby
profile.destroy
```

## Check Traffic Manager Endpoint Existence

```ruby
azure_network_service.traffic_manager_end_points.check_traffic_manager_endpoint_exists(
        '<Resource Group Name>',
        '<Profile Name>',
        '<Endpoint Name>',
        '<Type(<Endpoint Type>)>'
)
```

## Create Traffic Manager Endpoint

Traffic Manager Profile is pre-requisite of Traffic Manager Endpoint. Create a new Traffic Manager Endpoint. The parameter 'type' can be 'externalEndpoints, 'azureEndpoints' or 'nestedEndpoints'.

```ruby
endpoint = azure_network_service.traffic_manager_end_points.create(
        name: '<Endpoint Name>',
        traffic_manager_profile_name: '<Profile Name>',
        resource_group: '<Resource Group Name>',
        type: '<Endpoint Type>',
        target: '<Target URL>',
        endpoint_location: '<Location>'
)
```

## List Traffic Manager Endpoints

List Traffic Manager Endpoints in a resource group.

```ruby
endpoints  = fog_traffic_manager_service.traffic_manager_end_points(resource_group: '<Resource Group Name>', traffic_manager_profile_name: '<Profile Name>')
endpoints.each do |endpoint|
   puts "#{endpoint.name}"
end
```

## Retrieve a single Traffic Manager Endpoint

Get a single Traffic Manager Endpoint.

```ruby
endpoint = fog_traffic_manager_service
                 .traffic_manager_end_points
                 .get('<Resource Group Name>', '<Profile Name>', '<Endpoint name>', '<Endpoint Type>')
puts "#{endpoint.name}"
```
## Update a Traffic Manager Endpoint

Get a Traffic Manager Endpoint object from the get method and then update that Traffic Manager Endpoint. You can update the Traffic Manager Endpoint by passing the modifiable attributes in the form of a hash.

```ruby
endpoint.update(type: '<Endpoint Type>',
                target: '<Target URL>',
                endpoint_location: '<Location>'
)
```

## Destroy a single Traffic Manager Endpoint

Get a Traffic Manager Endpoint object from the get method and then destroy that Traffic Manager Endpoint.

```ruby
endpoint.destroy
```

## Support and Feedback
Your feedback is highly appreciated! If you have specific issues with the fog ARM, you should file an issue via Github.
