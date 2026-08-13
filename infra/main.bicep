targetScope = 'resourceGroup'

@description('Lowercase prefix used for globally unique Azure resource names.')
@minLength(3)
@maxLength(20)
param namePrefix string = 'concreinnova'

@allowed([
  'demo'
])
param environmentName string = 'demo'

param location string = resourceGroup().location

@secure()
param databaseConnectionString string

@secure()
param jwtKey string

@secure()
param emailUsername string = ''

@secure()
param emailPassword string = ''

param emailHost string = 'sandbox.smtp.mailtrap.io'
param emailPort int = 2525
param emailSender string = 'no-reply@concreinnova.com'

var normalizedPrefix = toLower(replace(namePrefix, '-', ''))
var suffix = uniqueString(subscription().subscriptionId, resourceGroup().id)
var apiName = take('${normalizedPrefix}-${environmentName}-api-${suffix}', 60)
var planName = take('${normalizedPrefix}-${environmentName}-plan', 40)
var staticWebAppName = take('${normalizedPrefix}-${environmentName}-web-${suffix}', 60)
var commonTags = {
  application: 'concre-innova'
  environment: environmentName
  purpose: 'student-demo'
  managedBy: 'bicep'
}

module api 'modules/app-service.bicep' = {
  name: 'api-app-service'
  params: {
    location: location
    planName: planName
    appName: apiName
    databaseConnectionString: databaseConnectionString
    jwtKey: jwtKey
    emailHost: emailHost
    emailPort: emailPort
    emailUsername: emailUsername
    emailPassword: emailPassword
    emailSender: emailSender
    tags: commonTags
  }
}

module web 'modules/static-web-app.bicep' = {
  name: 'frontend-static-web-app'
  params: {
    location: location
    appName: staticWebAppName
    tags: commonTags
  }
}

output apiAppName string = api.outputs.appName
output apiUrl string = 'https://${api.outputs.defaultHostName}'
output staticWebAppName string = web.outputs.appName
output staticWebAppUrl string = 'https://${web.outputs.defaultHostName}'
