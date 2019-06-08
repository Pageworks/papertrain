<?php
/**
 * Papertrain module for Craft CMS 3.x
 *
 * A module that provides unique and custom tooling to the Papertrain framework.
 *
 * @link      https://page.works/
 * @copyright Copyright (c) 2019 Kyle Andrews
 */

namespace modules\papertrainmodule\services;

use modules\papertrainmodule\PapertrainModule;

use Craft;
use craft\base\Component;

/**
 * @author    Kyle Andrews
 * @package   PapertrainModule
 * @since     0.1.0
 */
class PapertrainModuleService extends Component
{
    // Public Methods
    // =========================================================================

    public function buildAssetPaths(array $twigNames)
    {
        $ret = array();
        $modulesBasePath = \Craft::getAlias('@rootUrl').'/assets/modules-' . Craft::$app->config->general->jsCacheBustTimestamp . '/';
        $packagesBasePath = \Craft::getAlias('@rootUrl').'/assets/packages-' . Craft::$app->config->general->jsCacheBustTimestamp . '/';
        $stylesBasePath = \Craft::getAlias('@rootUrl').'/assets/styles-' . Craft::$app->config->general->cssCacheBustTimestamp . '/';
        foreach ($twigNames as $twigName){
            $kebabCaseName = StringHelper::toKebabCase($twigName);
            $finalName = StringHelper::toLowerCase($kebabCaseName);
            $ret[$finalName] = [
                'module' => $modulesBasePath.$finalName.'.js',
                'package' => $packagesBasePath.'npm.'.$finalName.'.js',
                'css' => $stylesBasePath.$finalName.'.css',
            ];
        }

        return $ret;
    }
}
