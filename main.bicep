param webAppName string = uniqueString(resourceGroup().id)
param location string = resourceGroup().location
param sku string = 'B2'
var appServicePlanName = toLower('AppServicePlan-${webAppName}')

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
  }
  kind: 'linux'
}

param linuxFxVersion string = 'node|14-lts'
var webSiteName = toLower('wapp-${webAppName}')


resource appService 'Microsoft.Web/sites@2020-06-01'={
  name: webSiteName
  location: location
  properties:{
    serverFarmId: appServicePlan.id
  }
}

param branch string = 'master'
param repositoryURI string = 'https://github.com/Azure-Samples/nodejs-docs-hello-world' 

resource srcControls 'Microsoft.Web/sites/sourcecontrols@2021-01-01'={
   name: '${appService.name}/web'
   properties:{
      branch: branch
      isManualIntegration: true
      repoUrl: repositoryURI
   }
}


