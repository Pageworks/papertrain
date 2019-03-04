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
        'defaultWeekStartDay'           => 0,
        'enableCsrfProtection'          => true,
        'omitScriptNameInUrls'          => true,
        'cpTrigger'                     => 'webmaster',
        'securityKey'                   => getenv('SECURITY_KEY'),
        'useEmailAsUsername'            => true,
        'useCompressedJs'               => true,
        'phpSessionName'                => 'cpsessid',
        'sendPoweredByHeader'           => false,
        'loginPath'                     => 'users/login',
        'activateAccountSuccessPath'    => 'users/profile',
        'invalidUserTokenPath'          => 'users/invalid',
        'setPasswordPath'               => 'users/password',
        'purgePendingUsersDuration'     => 'P1M'
    ],

    // Dev environment settings
    'dev' => [
        // Base site URL
        'siteUrl'               => getenv('DEV_URL'),
        'allowUpdates'          => true,
        'devMode'               => true,
        'testToEmailAddress'    => 'REPLACE_ME',
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
