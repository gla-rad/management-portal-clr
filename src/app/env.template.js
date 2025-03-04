(function(window) {
    window["env"] = window["env"] || {};
  
    // Environment variables
    window["env"]["environment_title"] = "${ENVIRONMENT_TITLE}";
    window["env"]["management_portal_name"] = "${MANAGEMENT_PORTAL_NAME}";
    
    window["env"]["keycloak_server_url"] = "${KEYCLOAK_SERVER_URL}";
    
    window["env"]["identity_registry_url"] = "${IDENTITY_REGISTRY_URL}";
    window["env"]["identity_registry_provider"] = "${IDENTITY_REGISTRY_PROVIDER}";
    window["env"]["identity_registry_email"] = "${IDENTITY_REGISTRY_EMAIL}";
    
    window["env"]["service_registry_url"] = "${SERVICE_REGISTRY_URL}";
    window["env"]["service_registry_provider"] = "${SERVICE_REGISTRY_PROVIDER}";
    window["env"]["service_registry_email"] = "${SERVICE_REGISTRY_EMAIL}";
    
    window["env"]["management_portal_provider"] = "${MANAGEMENT_PORTAL_PROVIDER}";
    window["env"]["management_portal_email"] = "${MANAGEMENT_PORTAL_EMAIL}";
    
    window["env"]["identity_provider_mrn_namespace"] = "${IDENTITY_PROVIDER_MRN_NAMESPACE}";
    window["env"]["app_base_href"] = "${APP_BASE_HREF}";
    window["env"]["debug"] = false;
})(this);