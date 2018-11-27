<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 */

return [
    // Global settings
    '*' => [
        'defaultWeekStartDay'  => 0,
        'enableCsrfProtection' => true,
        'omitScriptNameInUrls' => true,
        'cpTrigger'            => 'webmaster',
        'securityKey'          => getenv('SECURITY_KEY'),
        'useEmailAsUsername'   => true,
        'allowUpdates'         => false,
        'phpSessionName'       => 'cpsessid',
        'sendPoweredByHeader'  => false,
    ],

    // Dev environment settings
    'dev' => [
        // Base site URL
        'siteUrl'               => null,
        'allowUpdates'          => true,
        'devMode'               => true,
        'testToEmailAddress'    => 'REPLACE_ME',
        'enableTemplateCaching' => false
    ],

    // Staging environment settings
    'staging' => [
        // Base site URL
        'siteUrl' => null,
    ],

    // Production environment settings
    'production' => [
        // Base site URL
        'siteUrl' => null,
    ],
];