<cfoutput>
	<plugin>
		<name>MuraSentry</name>
		<package>MuraSentry</package>
		<directoryFormat>packageOnly</directoryFormat>
		<loadPriority>5</loadPriority>
		<version>1.0.0</version>
		<provider>fh group</provider>
		<providerURL>http://www.fh-group.com</providerURL>
		<category>Utility</category>
		<mappings>
			<!--
			<mapping
				name="myMapping"
				directory="someDirectory/anotherDirectory" />
			-->
			<!--
				Mappings will automatically be bound to the directory
				your plugin is installed, so the above example would
				refer to: {context}/plugins/{packageName}/someDirectory/anotherDirectory/
			-->
			<mapping name="Sentry" directory="" />
		</mappings>

		<!--
			AutoDeploy :
			Works with Mura's plugin auto-discovery feature. If true,
			every time Mura loads, it will look in the /plugins directory
			for new plugins and install them. If false, or not defined,
			Mura will register the plugin with the default setting values,
			but a Super Admin will need to login and manually complete
			the deployment.
		-->
		<!-- <autoDeploy>false|true</autoDeploy> -->

		<!--
			SiteID :
			Works in conjunction with the autoDeploy attribute.
			May contain a comma-delimited list of SiteIDs that you would
			like to assign the plugin to during the autoDeploy process.
		-->
		<!-- <siteID></siteID> -->

		<!-- 
				Plugin Settings :
				The settings contain individual settings that the plugin
				requires to function.
		-->
		<settings>
			<!--
			<setting
				name="yourNameAttribute"
				label="Your Label"
				hint="Your hint"
				type="text|radioGroup|textArea|select|multiSelectBox"
				required="false|true"
				validation="none|email|date|numeric|regex"
				regex="your javascript regex goes here (if validation=regex)"
				message="Your message if validation fails"
				defaultvalue=""
				optionlist="1^2^3"
				optionlabellist="One^Two^Three" />
			-->
			<setting>
				<name>SentryDSN</name>
				<label>Sentry DSN</label>
				<hint></hint>
				<type>TextBox</type>
				<required>true</required>
				<validation></validation>
				<regex></regex>
				<message></message>
				<defaultvalue></defaultvalue>
			</setting>
		</settings>
		<eventHandlers>
			<eventHandler 
				event="onApplicationLoad" 
				component="eventHandler" 
				persist="false" />
		</eventHandlers>

		<!--
			Display Objects :
			Allows developers to provide widgets that end users can apply to a
			content node's display region(s) when editing a page. They'll be
			listed under the Layout & Objects tab. The 'persist' attribute
			for CFC-based objects determine whether they are cached or instantiated
			on a per-request basis.
		-->
		<displayobjects location="global">
		</displayobjects>

		<!-- 
			Extensions :
			Allows you to create custom Class Extensions of any type.
			See /default/includes/themes/MuraBootstrap/config.xml.cfm
			for examples.
		-->
		<!-- <extensions></extensions> -->

	</plugin>
</cfoutput>
