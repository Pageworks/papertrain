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
use craft\helpers\Template as TemplateHelper;

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
    public function getCachebustTimestamp() : string
    {
        return Craft::$app->config->general->cacheBustTimestamp;
    }

    public function stylesheets(array $fileNames)
    {
        return TemplateHelper::raw(PapertrainModule::getInstance()->papertrainModuleService->buildStylesheets($fileNames));
    }

    public function packages(array $fileNames)
    {
        return TemplateHelper::raw(PapertrainModule::getInstance()->papertrainModuleService->buildPackages($fileNames));
    }

    public function components(array $fileNames)
    {
        return TemplateHelper::raw(PapertrainModule::getInstance()->papertrainModuleService->buildComponents($fileNames));
    }

    public function modules(array $fileNames)
    {
        return TemplateHelper::raw(PapertrainModule::getInstance()->papertrainModuleService->buildModules($fileNames));
    }
}
