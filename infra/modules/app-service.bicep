param location string
param planName string
param appName string
param sqlServerFqdn string
param databaseName string
param sqlAdministratorLogin string

@secure()
param sqlAdministratorPassword string

@secure()
param jwtKey string

param emailHost string
param emailPort int

@secure()
param emailUsername string

@secure()
param emailPassword string

param emailSender string
param tags object

var databaseConnectionString = 'Server=tcp:${sqlServerFqdn},1433;Initial Catalog=${databaseName};Persist Security Info=False;User ID=${sqlAdministratorLogin};Password=${sqlAdministratorPassword};MultipleActiveResultSets=True;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'

resource plan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: planName
  location: location
  tags: tags
  kind: 'linux'
  sku: {
    name: 'F1'
    tier: 'Free'
    capacity: 1
  }
  properties: {
    reserved: true
  }
}

resource app 'Microsoft.Web/sites@2024-04-01' = {
  name: appName
  location: location
  tags: tags
  kind: 'app,linux'
  properties: {
    serverFarmId: plan.id
    httpsOnly: true
    clientAffinityEnabled: false
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|10.0'
      alwaysOn: false
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      http20Enabled: true
      appSettings: [
        {
          name: 'ASPNETCORE_ENVIRONMENT'
          value: 'Production'
        }
        {
          name: 'Jwt__Key'
          value: jwtKey
        }
        {
          name: 'Jwt__Issuer'
          value: 'ConcreInnovaAPI'
        }
        {
          name: 'Jwt__Audience'
          value: 'ConcreInnovaWeb'
        }
        {
          name: 'EmailSettings__Host'
          value: emailHost
        }
        {
          name: 'EmailSettings__Port'
          value: string(emailPort)
        }
        {
          name: 'EmailSettings__Username'
          value: emailUsername
        }
        {
          name: 'EmailSettings__Password'
          value: emailPassword
        }
        {
          name: 'EmailSettings__SenderEmail'
          value: emailSender
        }
        {
          name: 'EmailSettings__SenderName'
          value: 'Concre Innova'
        }
        {
          name: 'EmailSettings__UseSsl'
          value: 'true'
        }
      ]
      connectionStrings: [
        {
          name: 'DefaultConnection'
          connectionString: databaseConnectionString
          type: 'SQLAzure'
        }
      ]
    }
  }
}

output appName string = app.name
output defaultHostName string = app.properties.defaultHostName
