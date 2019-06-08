<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 */

$customConfig =  [
    // Global settings
    '*' => [
        'defaultWeekStartDay'           => 0,
        'enableCsrfProtection'          => true,
        'omitScriptNameInUrls'          => true,
        'cpTrigger'                     => 'webmaster',
        'securityKey'                   => getenv('SECURITY_KEY'),
        'useEmailAsUsername'            => true,
        'useCompressedJs'               => true,
        'phpSessionName'                => 'cpsessid',
        'sendPoweredByHeader'           => false,
        'loginPath'                     => 'user/login',
        'activateAccountSuccessPath'    => 'user/welcome',
        'invalidUserTokenPath'          => 'user/registration-error',
        'setPasswordSuccessPath'        => 'user/login',
        'purgePendingUsersDuration'     => 'P1M',
        'useProjectConfigFile'          => true,

    ],

    // Dev environment settings
    'dev' => [
        // Base site URL
        'siteUrl'               => getenv('DEV_URL'),
        'allowUpdates'          => true,
        'devMode'               => true,
        'testToEmailAddress'    => getenv('TEST_EMAIL_ADDRESS'),
        'enableTemplateCaching' => false,
        'aliases' => [
            '@rootUrl' => getenv('DEV_URL'),
        ],
    ],

    // Staging environment settings
    'staging' => [
        // Base site URL
        'siteUrl'       => getenv('STAGING_URL'),
        'allowUpdates'  => false,
        'aliases' => [
            '@rootUrl' => getenv('STAGING_URL'),
        ],
    ],

    // Production environment settings
    'production' => [
        // Base site URL
        'siteUrl'           => getenv('PRODUCTION_URL'),
        'allowAdminChanges' => false,
        'aliases' => [
            '@rootUrl' => getenv('PRODUCTION_URL'),
        ],
    ],
];

// If a local config file exists, merge any local config settings

if (is_array($customLocalConfig = include('papertrain/automation.php'))) {
    $customGlobalConfig = array_merge($customConfig['*'], $customLocalConfig);
    $customConfig['*'] = $customGlobalConfig;
}

return $customConfig;
