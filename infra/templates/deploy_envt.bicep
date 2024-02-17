param location string = 'koreacentral' // 변경된 부분
param storageNamePrefix string
param acr_name string = 'wonsoongacr'
param asb_name string = 'wonsoongasb'
param app_name string = 'wonsoongapp'

param asp_name string = 'ASP-${app_name}'


var stg_acc_name = '${storageNamePrefix}12312'

resource storage_account 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: stg_acc_name
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource container_registry 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: acr_name
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

resource asb 'Microsoft.ServiceBus/namespaces@2021-06-01-preview' = {
  name: asb_name
  location: location
}

resource webapp 'Microsoft.Web/sites@2018-11-01' = {
  name: app_name
  location: location
  tags: null
  properties: {
		serverFarmId: asp.id
		clientAffinityEnabled: false
		httpsOnly: true
  }
}

resource asp 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: asp_name
  location: location
  kind: 'linux'
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
}

