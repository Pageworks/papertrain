<?php
/**
 * Papertrain module for Craft CMS 3.x
 *
 * A module that provides unique and custom tooling to the Papertrain framework.
 *
 * @link      https://page.works/
 * @copyright Copyright (c) 2019 Kyle Andrews
 */

namespace modules\papertrainmodule\assetbundles\PapertrainModule;

use Craft;
use craft\web\AssetBundle;
use craft\web\assets\cp\CpAsset;

/**
 * @author    Kyle Andrews
 * @package   PapertrainModule
 * @since     0.1.0
 */
class PapertrainModuleAsset extends AssetBundle
{
    // Public Methods
    // =========================================================================

    /**
     * @inheritdoc
     */
    public function init()
    {
        $this->sourcePath = "@modules/papertrainmodule/assetbundles/papertrainmodule/dist";

        $this->depends = [
            CpAsset::class,
        ];

        $this->js = [
            'js/PapertrainModule.js',
        ];

        $this->css = [
            'css/PapertrainModule.css',
        ];

        parent::init();
    }
}
