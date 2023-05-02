locals {
  permissions = {
    certificatemanager_ro = [
      "certificatemanager.certissuanceconfigs.get",
      "certificatemanager.certissuanceconfigs.list",
      "certificatemanager.certmapentries.get",
      "certificatemanager.certmapentries.getIamPolicy",
      "certificatemanager.certmapentries.list",
      "certificatemanager.certmaps.get",
      "certificatemanager.certmaps.getIamPolicy",
      "certificatemanager.certmaps.list",
      "certificatemanager.certs.get",
      "certificatemanager.certs.getIamPolicy",
      "certificatemanager.certs.list",
      "certificatemanager.dnsauthorizations.get",
      "certificatemanager.dnsauthorizations.getIamPolicy",
      "certificatemanager.dnsauthorizations.list",
      "certificatemanager.locations.get",
      "certificatemanager.locations.list",
      "certificatemanager.operations.get",
      "certificatemanager.operations.list"
    ]
    cloudfunctions_ro = [
      "cloudfunctions.functions.get",
      "cloudfunctions.functions.getIamPolicy",
      "cloudfunctions.functions.list",
      "cloudfunctions.functions.sourceCodeGet",
      "cloudfunctions.locations.get",
      "cloudfunctions.locations.list",
      "cloudfunctions.operations.get",
      "cloudfunctions.operations.list",
      "cloudfunctions.runtimes.list"
    ]
    cloudkms_ro = [
      "cloudkms.cryptoKeyVersions.get",
      "cloudkms.cryptoKeyVersions.list",
      "cloudkms.cryptoKeys.get",
      "cloudkms.cryptoKeys.getIamPolicy",
      "cloudkms.cryptoKeys.list",
      "cloudkms.ekmConfigs.get",
      "cloudkms.ekmConfigs.getIamPolicy",
      "cloudkms.ekmConnections.get",
      "cloudkms.ekmConnections.getIamPolicy",
      "cloudkms.ekmConnections.list",
      "cloudkms.importJobs.get",
      "cloudkms.importJobs.getIamPolicy",
      "cloudkms.importJobs.list",
      "cloudkms.keyRings.get",
      "cloudkms.keyRings.getIamPolicy",
      "cloudkms.keyRings.list",
      "cloudkms.keyRings.listEffectiveTags",
      "cloudkms.keyRings.listTagBindings",
      "cloudkms.locations.generateRandomBytes",
      "cloudkms.locations.get",
      "cloudkms.locations.list",
      "cloudkms.protectedResources.search"
    ]
    compute_ro = [
      "compute.acceleratorTypes.list",
      "compute.addresses.list",
      "compute.autoscalers.list",
      "compute.backendBuckets.getIamPolicy",
      "compute.backendBuckets.list",
      "compute.backendServices.getIamPolicy",
      "compute.backendServices.list",
      "compute.commitments.list",
      "compute.diskTypes.list",
      "compute.disks.getIamPolicy",
      "compute.disks.list",
      "compute.externalVpnGateways.list",
      "compute.firewallPolicies.getIamPolicy",
      "compute.firewallPolicies.list",
      "compute.firewalls.list",
      "compute.forwardingRules.list",
      "compute.globalAddresses.list",
      "compute.globalForwardingRules.list",
      "compute.globalNetworkEndpointGroups.list",
      "compute.globalOperations.getIamPolicy",
      "compute.globalOperations.list",
      "compute.globalPublicDelegatedPrefixes.list",
      "compute.healthChecks.list",
      "compute.httpHealthChecks.list",
      "compute.httpsHealthChecks.list",
      "compute.images.getIamPolicy",
      "compute.images.list",
      "compute.instanceGroupManagers.list",
      "compute.instanceGroups.list",
      "compute.instanceTemplates.getIamPolicy",
      "compute.instanceTemplates.list",
      "compute.instances.getIamPolicy",
      "compute.instances.list",
      "compute.interconnectAttachments.list",
      "compute.interconnectLocations.list",
      "compute.interconnects.list",
      "compute.licenseCodes.getIamPolicy",
      "compute.licenseCodes.list",
      "compute.licenses.getIamPolicy",
      "compute.licenses.list",
      "compute.machineImages.getIamPolicy",
      "compute.machineImages.list",
      "compute.machineTypes.list",
      "compute.maintenancePolicies.getIamPolicy",
      "compute.maintenancePolicies.list",
      "compute.networkAttachments.list",
      "compute.networkEdgeSecurityServices.list",
      "compute.networkEndpointGroups.getIamPolicy",
      "compute.networkEndpointGroups.list",
      "compute.networks.list",
      "compute.nodeGroups.getIamPolicy",
      "compute.nodeGroups.list",
      "compute.nodeTemplates.getIamPolicy",
      "compute.nodeTemplates.list",
      "compute.nodeTypes.list",
      "compute.packetMirrorings.list",
      "compute.publicAdvertisedPrefixes.list",
      "compute.publicDelegatedPrefixes.list",
      "compute.regionBackendServices.getIamPolicy",
      "compute.regionBackendServices.list",
      "compute.regionFirewallPolicies.getIamPolicy",
      "compute.regionFirewallPolicies.list",
      "compute.regionHealthCheckServices.list",
      "compute.regionHealthChecks.list",
      "compute.regionNetworkEndpointGroups.list",
      "compute.regionNotificationEndpoints.list",
      "compute.regionOperations.getIamPolicy",
      "compute.regionOperations.list",
      "compute.regionSecurityPolicies.list",
      "compute.regionSslCertificates.list",
      "compute.regionSslPolicies.list",
      "compute.regionTargetHttpProxies.list",
      "compute.regionTargetHttpsProxies.list",
      "compute.regionTargetTcpProxies.list",
      "compute.regionUrlMaps.list",
      "compute.regions.list",
      "compute.reservations.list",
      "compute.resourcePolicies.getIamPolicy",
      "compute.resourcePolicies.list",
      "compute.routers.list",
      "compute.routes.list",
      "compute.securityPolicies.getIamPolicy",
      "compute.securityPolicies.list",
      "compute.serviceAttachments.getIamPolicy",
      "compute.serviceAttachments.list",
      "compute.snapshots.getIamPolicy",
      "compute.snapshots.list",
      "compute.sslCertificates.list",
      "compute.sslPolicies.list",
      "compute.subnetworks.getIamPolicy",
      "compute.subnetworks.list",
      "compute.targetGrpcProxies.list",
      "compute.targetHttpProxies.list",
      "compute.targetHttpsProxies.list",
      "compute.targetInstances.list",
      "compute.targetPools.list",
      "compute.targetSslProxies.list",
      "compute.targetTcpProxies.list",
      "compute.targetVpnGateways.list",
      "compute.urlMaps.list",
      "compute.vpnGateways.list",
      "compute.vpnTunnels.list",
      "compute.zoneOperations.getIamPolicy",
      "compute.zoneOperations.list",
      "compute.zones.list"
    ]
    container_ro = [
      "container.apiServices.get",
      "container.apiServices.getStatus",
      "container.apiServices.list",
      "container.customResourceDefinitions.getStatus",
      "container.customResourceDefinitions.list",
      "container.daemonSets.get",
      "container.daemonSets.getStatus",
      "container.daemonSets.list",
      "container.deployments.get",
      "container.deployments.getStatus",
      "container.deployments.list",
      "container.endpointSlices.get",
      "container.endpointSlices.list",
      "container.endpoints.get",
      "container.endpoints.list",
      "container.events.get",
      "container.events.list",
      "container.frontendConfigs.get",
      "container.frontendConfigs.list",
      "container.horizontalPodAutoscalers.get",
      "container.horizontalPodAutoscalers.getStatus",
      "container.horizontalPodAutoscalers.list",
      "container.ingresses.get",
      "container.ingresses.getStatus",
      "container.ingresses.list",
      "container.initializerConfigurations.get",
      "container.initializerConfigurations.list",
      "container.jobs.get",
      "container.jobs.getStatus",
      "container.jobs.list",
      "container.leases.get",
      "container.leases.list",
      "container.limitRanges.get",
      "container.limitRanges.list",
      "container.localSubjectAccessReviews.list",
      "container.managedCertificates.get",
      "container.managedCertificates.list",
      "container.mutatingWebhookConfigurations.get",
      "container.mutatingWebhookConfigurations.list",
      "container.namespaces.get",
      "container.namespaces.getStatus",
      "container.namespaces.list",
      "container.networkPolicies.get",
      "container.networkPolicies.list",
      "container.nodes.get",
      "container.nodes.getStatus",
      "container.nodes.list",
      "container.operations.get",
      "container.operations.list",
      "container.persistentVolumeClaims.get",
      "container.persistentVolumeClaims.getStatus",
      "container.persistentVolumeClaims.list",
      "container.persistentVolumes.get",
      "container.persistentVolumes.getStatus",
      "container.persistentVolumes.list",
      "container.petSets.get",
      "container.petSets.list",
      "container.podDisruptionBudgets.get",
      "container.podDisruptionBudgets.getStatus",
      "container.podDisruptionBudgets.list",
      "container.podPresets.get",
      "container.podPresets.list",
      "container.podSecurityPolicies.get",
      "container.podSecurityPolicies.list",
      "container.podTemplates.get",
      "container.podTemplates.list",
      "container.pods.get",
      "container.pods.getLogs",
      "container.pods.getStatus",
      "container.pods.list",
      "container.priorityClasses.get",
      "container.priorityClasses.list",
      "container.replicaSets.get",
      "container.replicaSets.getScale",
      "container.replicaSets.getStatus",
      "container.replicaSets.list",
      "container.replicationControllers.get",
      "container.replicationControllers.getScale",
      "container.replicationControllers.getStatus",
      "container.replicationControllers.list",
      "container.resourceQuotas.get",
      "container.resourceQuotas.getStatus",
      "container.resourceQuotas.list",
      "container.roleBindings.get",
      "container.roleBindings.list",
      "container.roles.get",
      "container.roles.list",
      "container.runtimeClasses.get",
      "container.runtimeClasses.list",
      "container.scheduledJobs.get",
      "container.scheduledJobs.list",
      "container.selfSubjectAccessReviews.create",
      "container.selfSubjectAccessReviews.list",
      "container.selfSubjectRulesReviews.create",
      "container.serviceAccounts.get",
      "container.serviceAccounts.list",
      "container.services.get",
      "container.services.getStatus",
      "container.services.list",
      "container.statefulSets.get",
      "container.statefulSets.getScale",
      "container.statefulSets.getStatus",
      "container.statefulSets.list",
      "container.storageClasses.get",
      "container.storageClasses.list",
      "container.storageStates.get"
    ]
    dns_ro = [
      "dns.changes.get",
      "dns.changes.list",
      "dns.dnsKeys.get",
      "dns.dnsKeys.list",
      "dns.managedZones.get",
      "dns.managedZones.getIamPolicy",
      "dns.managedZones.list",
      "dns.policies.get",
      "dns.policies.getIamPolicy",
      "dns.policies.list",
      "dns.projects.get",
      "domains.locations.get",
      "domains.locations.list"
    ]
    iam_ro = [
      "iam.denypolicies.get",
      "iam.denypolicies.list",
      "iam.googleapis.com/workforcePoolProviderKeys.list",
      "iam.googleapis.com/workforcePoolProviders.list",
      "iam.googleapis.com/workforcePools.getIamPolicy",
      "iam.googleapis.com/workforcePools.list",
      "iam.googleapis.com/workloadIdentityPoolProviderKeys.list",
      "iam.googleapis.com/workloadIdentityPoolProviders.list",
      "iam.googleapis.com/workloadIdentityPools.list",
      "iam.roles.get",
      "iam.roles.list",
      "iam.serviceAccountKeys.list",
      "iam.serviceAccounts.get",
      "iam.serviceAccounts.getIamPolicy",
      "iam.serviceAccounts.list"
    ]
    logging_ro = [
      "logging.buckets.copyLogEntries",
      "logging.buckets.get",
      "logging.buckets.list",
      "logging.exclusions.get",
      "logging.exclusions.list",
      "logging.links.get",
      "logging.links.list",
      "logging.locations.get",
      "logging.locations.list",
      "logging.logEntries.download",
      "logging.logEntries.list",
      "logging.logMetrics.get",
      "logging.logMetrics.list",
      "logging.logServiceIndexes.list",
      "logging.logServices.list",
      "logging.logs.list",
      "logging.notificationRules.get",
      "logging.notificationRules.list",
      "logging.operations.get",
      "logging.operations.list",
      "logging.queries.create",
      "logging.queries.delete",
      "logging.queries.get",
      "logging.queries.list",
      "logging.queries.listShared",
      "logging.queries.update",
      "logging.settings.get",
      "logging.sinks.get",
      "logging.sinks.list",
      "logging.usage.get",
      "logging.views.get",
      "logging.views.list",
      "logging.views.listLogs",
      "logging.views.listResourceKeys",
      "logging.views.listResourceValues",
    ]
    managedidentities_ro = [
      "managedidentities.backups.get",
      "managedidentities.backups.getIamPolicy",
      "managedidentities.backups.list",
      "managedidentities.domains.checkMigrationPermission",
      "managedidentities.domains.get",
      "managedidentities.domains.getIamPolicy",
      "managedidentities.domains.list",
      "managedidentities.domains.listEffectiveTags",
      "managedidentities.domains.listTagBindings",
      "managedidentities.domains.validateTrust",
      "managedidentities.locations.get",
      "managedidentities.locations.list",
      "managedidentities.operations.get",
      "managedidentities.operations.list",
      "managedidentities.peerings.get",
      "managedidentities.peerings.getIamPolicy",
      "managedidentities.peerings.list",
      "managedidentities.sqlintegrations.get",
      "managedidentities.sqlintegrations.list",
    ]
    monitoring_ro = [
      "monitoring.metricDescriptors.get",
      "monitoring.metricDescriptors.list",
      "monitoring.monitoredResourceDescriptors.get",
      "monitoring.monitoredResourceDescriptors.list",
      "monitoring.notificationChannelDescriptors.get",
      "monitoring.notificationChannelDescriptors.list",
      "monitoring.notificationChannels.get",
      "monitoring.notificationChannels.list",
      "monitoring.publicWidgets.get",
      "monitoring.publicWidgets.list",
      "monitoring.services.get",
      "monitoring.services.list",
      "monitoring.slos.get",
      "monitoring.slos.list",
      "monitoring.snoozes.get",
      "monitoring.snoozes.list",
      "monitoring.timeSeries.list",
      "monitoring.uptimeCheckConfigs.get",
      "monitoring.uptimeCheckConfigs.list",
    ]
    network_ro = [
      "networkconnectivity.hubs.get",
      "networkconnectivity.hubs.getIamPolicy",
      "networkconnectivity.hubs.list",
      "networkconnectivity.internalRanges.get",
      "networkconnectivity.internalRanges.getIamPolicy",
      "networkconnectivity.internalRanges.list",
      "networkconnectivity.locations.get",
      "networkconnectivity.locations.list",
      "networkconnectivity.operations.get",
      "networkconnectivity.operations.list",
      "networkconnectivity.policyBasedRoutes.get",
      "networkconnectivity.policyBasedRoutes.getIamPolicy",
      "networkconnectivity.policyBasedRoutes.list",
      "networkconnectivity.spokes.get",
      "networkconnectivity.spokes.getIamPolicy",
      "networkconnectivity.spokes.list",
      "networkmanagement.config.get",
      "networkmanagement.connectivitytests.get",
      "networkmanagement.connectivitytests.getIamPolicy",
      "networkmanagement.connectivitytests.list",
      "networkmanagement.locations.get",
      "networkmanagement.locations.list",
      "networkmanagement.operations.get",
      "networkmanagement.operations.list",
      "networkmanagement.topologygraphs.read",
      "networksecurity.authorizationPolicies.get",
      "networksecurity.authorizationPolicies.getIamPolicy",
      "networksecurity.authorizationPolicies.list",
      "networksecurity.clientTlsPolicies.get",
      "networksecurity.clientTlsPolicies.getIamPolicy",
      "networksecurity.clientTlsPolicies.list",
      "networksecurity.locations.get",
      "networksecurity.locations.list",
      "networksecurity.operations.get",
      "networksecurity.operations.list",
      "networksecurity.serverTlsPolicies.get",
      "networksecurity.serverTlsPolicies.getIamPolicy",
      "networksecurity.serverTlsPolicies.list",
      "networkservices.endpointConfigSelectors.get",
      "networkservices.endpointConfigSelectors.getIamPolicy",
      "networkservices.endpointConfigSelectors.list",
      "networkservices.endpointPolicies.get",
      "networkservices.endpointPolicies.getIamPolicy",
      "networkservices.endpointPolicies.list",
      "networkservices.gateways.get",
      "networkservices.gateways.list",
      "networkservices.grpcRoutes.get",
      "networkservices.grpcRoutes.getIamPolicy",
      "networkservices.grpcRoutes.list",
      "networkservices.httpFilters.get",
      "networkservices.httpFilters.getIamPolicy",
      "networkservices.httpFilters.list",
      "networkservices.httpRoutes.get",
      "networkservices.httpRoutes.getIamPolicy",
      "networkservices.httpRoutes.list",
      "networkservices.httpfilters.get",
      "networkservices.httpfilters.getIamPolicy",
      "networkservices.httpfilters.list",
      "networkservices.locations.get",
      "networkservices.locations.list",
      "networkservices.meshes.get",
      "networkservices.meshes.getIamPolicy",
      "networkservices.meshes.list",
      "networkservices.operations.get",
      "networkservices.operations.list",
      "networkservices.serviceBindings.get",
      "networkservices.serviceBindings.list",
      "networkservices.tcpRoutes.get",
      "networkservices.tcpRoutes.getIamPolicy",
      "vpcaccess.connectors.use",
      "vpcaccess.locations.list",
      "vpcaccess.operations.get",
      "vpcaccess.operations.list",
    ]
    orgpolicy_ro = [
      "orgpolicy.constraints.list",
      "orgpolicy.customConstraints.get",
      "orgpolicy.customConstraints.list",
      "orgpolicy.policies.list",
      "orgpolicy.policy.get",
    ]
    privateca_ro = [
      "privateca.certificateRevocationLists.get",
      "privateca.certificateRevocationLists.getIamPolicy",
      "privateca.certificateRevocationLists.list",
      "privateca.certificateTemplates.get",
      "privateca.certificateTemplates.getIamPolicy",
      "privateca.certificateTemplates.list",
      "privateca.certificateTemplates.use",
      "privateca.certificates.get",
      "privateca.certificates.getIamPolicy",
      "privateca.certificates.list",
      "privateca.locations.get",
      "privateca.locations.list",
      "privateca.operations.get",
      "privateca.operations.list",
      "privateca.reusableConfigs.get",
      "privateca.reusableConfigs.getIamPolicy",
      "privateca.reusableConfigs.list",
    ]
    pubsub_ro = [
      "pubsub.schemas.attach",
      "pubsub.schemas.get",
      "pubsub.schemas.getIamPolicy",
      "pubsub.schemas.list",
      "pubsub.schemas.listRevisions",
      "pubsub.schemas.validate",
      "pubsub.snapshots.get",
      "pubsub.snapshots.list",
      "pubsub.snapshots.seek",
      "pubsub.subscriptions.get",
      "pubsub.subscriptions.list",
      "pubsub.topics.get",
      "pubsub.topics.list",
    ]
    redis_ro = [
      "redis.instances.get",
      "redis.instances.list",
      "redis.locations.get",
      "redis.locations.list",
      "redis.operations.get",
      "redis.operations.list",
    ]
    resourcemanager_ro = [
      "resourcesettings.settings.get",
      "resourcesettings.settings.list",
      "resourcemanager.folders.get",
      "resourcemanager.folders.getIamPolicy",
      "resourcemanager.folders.list",
      "resourcemanager.hierarchyNodes.listEffectiveTags",
      "resourcemanager.hierarchyNodes.listTagBindings",
      "resourcemanager.organizations.getIamPolicy",
      "resourcemanager.projects.get",
      "resourcemanager.projects.getIamPolicy",
      "resourcemanager.projects.list",
      "resourcemanager.tagHolds.list",
      "resourcemanager.tagKeys.get",
      "resourcemanager.tagKeys.getIamPolicy",
      "resourcemanager.tagKeys.list",
      "resourcemanager.tagValues.get",
      "resourcemanager.tagValues.getIamPolicy",
      "resourcemanager.tagValues.list",
      "resourcesettings.settings.list"
    ]
    storage_ro = [
      "orgpolicy.policy.get",
      "resourcemanager.projects.get",
      "resourcemanager.projects.list",
      "storage.buckets.get",
      "storage.buckets.getIamPolicy",
      "storage.buckets.list",
      "storage.buckets.listEffectiveTags",
      "storage.buckets.listTagBindings",
      "storage.objects.get",
      "storage.objects.getIamPolicy",
      "storage.objects.list"
    ]
  }
}