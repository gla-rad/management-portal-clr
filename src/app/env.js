(function(window) {
    window["env"] = window["env"] || {};
  
    // Environment variables
    window["env"]["environment_title"] = undefined;
    window["env"]["management_portal_name"] = undefined;
    
    window["env"]["keycloak_server_url"] = undefined;
    
    window["env"]["identity_registry_url"] = undefined;
    window["env"]["identity_registry_provider"] = undefined;
    window["env"]["identity_registry_email"] = undefined;
    
    window["env"]["service_registry_url"] = undefined;
    window["env"]["service_registry_provider"] = undefined;
    window["env"]["service_registry_email"] = undefined;
    
    window["env"]["management_portal_provider"] = undefined;
    window["env"]["management_portal_email"] = undefined;
    
    window["env"]["identity_provider_mrn_namespace"] = undefined;
    window["env"]["app_base_href"] = undefined;
    window["env"]["debug"] = false;
})(this);