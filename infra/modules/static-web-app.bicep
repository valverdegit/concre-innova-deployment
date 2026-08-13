param location string
param appName string
param tags object

resource app 'Microsoft.Web/staticSites@2023-12-01' = {
  name: appName
  location: location
  tags: tags
  sku: {
    name: 'Free'
    tier: 'Free'
  }
  properties: {
    allowConfigFileUpdates: true
  }
}

output appName string = app.name
output defaultHostName string = app.properties.defaultHostname
