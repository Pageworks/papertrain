<?php
/**
 * Papertrain module for Craft CMS 3.x
 *
 * A module that provides unique and custom tooling to the Papertrain framework.
 *
 * @link      https://page.works/
 * @copyright Copyright (c) 2019 Kyle Andrews
 */

namespace modules\papertrainmodule\variables;

use modules\papertrainmodule\PapertrainModule;

use Craft;

/**
 * @author    Kyle Andrews
 * @package   PapertrainModule
 * @since     0.1.0
 */
class PapertrainModuleVariable
{
    // Public Methods
    // =========================================================================

    public function getAssetPaths(array $twigNames)
    {
        return PapertrainModule::getInstance()->papertrainModuleService->buildAssetPaths($twigNames);
    }

    public function getCssCachebust()
    {
        return Craft::$app->config->general->cssCacheBustTimestamp;
    }

    public function getJsCachebust()
    {
        return Craft::$app->config->general->jsCacheBustTimestamp;
    }

    public function stylesheets(array $fileNames)
    {
        PapertrainModule::getInstance()->papertrainModuleService->buildStylesheets($fileNames);
    }

    public function packages(array $fileNames)
    {
        PapertrainModule::getInstance()->papertrainModuleService->buildPackages($fileNames);
    }

    public function components(array $fileNames)
    {
        PapertrainModule::getInstance()->papertrainModuleService->buildComponents($fileNames);
    }
}
