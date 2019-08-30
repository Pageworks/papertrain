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
    public function buildCriticalCss(array $fileNames)
    {
        $script =  '<script defer="defer">';
        foreach ($fileNames as $file)
        {
            $script = $script . 'window.criticalCss.push("' . $file . '.css");';
        }
        $script = $script . '</script>';
        return $script;
    }
    
    public function buildStylesheets(array $fileNames)
    {
        $script =  '<script defer="defer">';
        foreach ($fileNames as $file)
        {
            $script = $script . 'window.stylesheets.push("' . $file . '.css");';
        }
        $script = $script . '</script>';
        return $script;
    }

    public function buildPackages(array $fileNames)
    {
        $script = '<script defer="defer">';
        foreach ($fileNames as $file)
        {
            $script = $script . 'window.packages.push("' . $file . '.js");';
        }
        $script = $script . '</script>';
        return $script;
    }

    public function buildComponents(array $fileNames)
    {
        $script = '<script type="module">';
        foreach ($fileNames as $file)
        {
            $script = $script . 'window.components.push("' . $file . '.js");';
        }
        $script = $script . '</script>';
        return $script;
    }

    public function buildModules(array $fileNames)
    {
        $script = '<script type="module">';
        foreach ($fileNames as $file)
        {
            $script = $script . 'window.modules.push("' . $file . '.js");';
        }
        $script = $script . '</script>';
        return $script;
    }

    public function buildLibraries(array $fileNames)
    {
        $script = '<script defer="defer">';
        foreach ($fileNames as $file)
        {
            $script = $script . 'window.libraries.push("' . $file . '.js");';
        }
        $script = $script . '</script>';
        return $script;
    }
}
