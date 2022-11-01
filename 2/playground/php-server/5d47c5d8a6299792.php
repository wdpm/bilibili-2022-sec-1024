<?php

// flag in /tmp/flag.php


class Modifier
{

    # 调用形式: $modifier()
    public function __invoke()
    {
        include("index.php");
    }
}

class Action
{
    protected $checkAccess;
    protected $id;

    public function run()
    {
        if (strpos($this->checkAccess, 'upload') !== false || strpos($this->checkAccess, 'log') !== false) {
            echo "error path";
            exit();
        }

        if ($this->id !== 0 && $this->id !== 1) {
            switch ($this->id) {
                case 0:
                    if ($this->checkAccess) {
                        include($this->checkAccess);
                    }
                    break;
                case 1:
                    throw new Exception("id invalid in " . __CLASS__ . __FUNCTION__);
                    break;
                default:
                    break;
            }
        }
    }

}

class Content
{

    public $formatters;

    public function getFormatter($formatter)
    {
        if (isset($this->formatters[$formatter])) {
            return $this->formatters[$formatter];
        }

        foreach ($this->providers as $provider) {
            if (method_exists($provider, $formatter)) {
                $this->formatters[$formatter] = array($provider, $formatter);
                return $this->formatters[$formatter];
            }
        }
        throw new \InvalidArgumentException(sprintf('Unknown formatter "%s"', $formatter));
    }

    public function __call($name, $arguments)
    {
        return call_user_func_array($this->getFormatter($name), $arguments);
    }
}

class Show
{
    public $source;
    public $str;
    public $reader;

    public function __construct($file = 'index.php')
    {
        $this->source = $file;
        echo 'Welcome to ' . $this->source . "<br>";
    }
    public function __toString()
    {
        $this->str->reset();
    }
    public function __wakeup()
    {
        if (preg_match("/gopher|phar|http|file|ftp|dict|\.\./i", $this->source)) {
            echo "ban protocol";
            throw new Exception('invalid protocol found in ' . __CLASS__);
        }else{
            echo "pass protocol...perfect";
        }
    }
    public function reset()
    {
        if ($this->reader !== null) {
            $this->reader->close();
        }
    }
}


highlight_file(__FILE__);