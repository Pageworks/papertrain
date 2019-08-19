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
use craft\helpers\StringHelper;

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
        $modulesBasePath = \Craft::getAlias('@rootUrl').'/automation/modules-' . Craft::$app->config->general->cacheBustTimestamp . '/';
        $packagesBasePath = \Craft::getAlias('@rootUrl').'/automation/packages-' . Craft::$app->config->general->cacheBustTimestamp . '/';
        $stylesBasePath = \Craft::getAlias('@rootUrl').'/automation/styles-' . Craft::$app->config->general->cacheBustTimestamp . '/';
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

    public function buildStylesheets(array $fileNames)
    {
        echo '<script type="module">';
        foreach ($fileNames as $file)
        {
            echo 'window.stylesheets.push("' . $file . '.css");';
        }
        echo '</script>';
    }

    public function buildPackages(array $fileNames)
    {
        echo '<script type="module">';
        foreach ($fileNames as $file)
        {
            echo 'window.packages.push("' . $file . '.js");';
        }
        echo '</script>';
    }

    public function buildComponents(array $fileNames)
    {
        echo '<script type="module">';
        foreach ($fileNames as $file)
        {
            echo 'window.components.push("' . $file . '.js");';
        }
        echo '</script>';
    }
}
