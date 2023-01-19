param location string
param resourceToken string
param tags object

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' existing = {
  name: 'log${resourceToken}'
}

resource containerAppsEnvironment 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: 'cae${resourceToken}'
  location: location
  tags: tags
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalyticsWorkspace.properties.customerId
        sharedKey: logAnalyticsWorkspace.listKeys().primarySharedKey
      }
    }
  }
}

module containerRegistry './containerregistry.bicep' = {
  name: 'contreg${resourceToken}'
  params:{
    location: location
    resourceToken: resourceToken
    tags: tags
  }
}

output CONTAINER_REGISTRY_ENDPOINT string = containerRegistry.outputs.CONTAINER_REGISTRY_ENDPOINT
output CONTAINER_REGISTRY_NAME string = containerRegistry.outputs.CONTAINER_REGISTRY_NAME
