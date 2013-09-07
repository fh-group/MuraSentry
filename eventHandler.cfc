component name='eventHandler' accessors='true' extends='mura.plugin.pluginGenericEventHandler' output='false' {

  property name='$';

  this.pluginName = 'MuraSentry';

  public any function onApplicationLoad(required struct $) {
    if(structKeyExists(application, "Sentry")) {
      structDelete(application, "Sentry");
    }

    // Register all event handlers/listeners of this .cfc with Mura CMS
    variables.pluginConfig.addEventHandler(this);
    set$(arguments.$);
  }

  public any function onSiteRequestStart(required struct $) {
    // Makes any methods of the object accessible via $.yourPluginName
    //var contentRenderer = new contentRenderer(arguments.$);
    //arguments.$.setCustomMuraScopeKey(this.pluginName, contentRenderer);
    //set$(arguments.$);
  }

  // Purpose of plugin -- Capture errors from here and report them to Sentry.
  public void function onGlobalError() {
    if(!structKeyExists(application, "Sentry")) {
      var sentryConfig = new MuraSentry.config.SentryConfig(variables.pluginConfig.getSetting('SentryDSN'));

      application.SentryRavenClient = new MuraSentry.Client.Raven(argumentCollection=sentryConfig.getRavenConfiguration());
    }

    // Track Exception w/ Raven to report to Sentry
    application.SentryRavenClient.captureException(arguments.$.event('exception'));
  }
}
