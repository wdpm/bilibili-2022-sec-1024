<?php

// flag in /tmp/flag.php


class Modifier
{

    # 调用方式 $modifier()
    public function __invoke()
    {
        include("index.php");
    }
}

class Action
{
//    注意private和protected修饰时的%00
    protected $checkAccess; // tmp/flag.php
    protected $id;

    public function run()
    {
        if (strpos($this->checkAccess, 'upload') !== false || strpos($this->checkAccess, 'log') !== false) {
            echo "error path";
            exit();
        }

        // $id = "0";
        if ($this->id !== 0 && $this->id !== 1) {
            switch ($this->id) {
                case 0:
                    if ($this->checkAccess) {
                        echo "case 0 in action";
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
    // object
    public $formatters;

    public function getFormatter($formatter)
    {
        if (isset($this->formatters[$formatter])) {
            return $this->formatters[$formatter];
        }

        foreach ($this->providers as $provider) {
            if (method_exists($provider, $formatter)) {
                // for example: = [$show,"reset"]
                $this->formatters[$formatter] = array($provider, $formatter);
                return $this->formatters[$formatter];
            }
        }
        throw new \InvalidArgumentException(sprintf('Unknown formatter "%s"', $formatter));
    }

    // 1)  $content.__call(reset) => $this->formatters[reset]?  => $provider.reset() => $show.reset()
    // 2)  $content.__call(close) => $this->formatters[close]()
    public function __call($name, $arguments)
    {
        echo "name: " . $name . ";  arguments: " . print_r($arguments);
        echo "\r\n";
        return call_user_func_array($this->getFormatter($name), $arguments);
    }
}

class Show
{
    public $source;
    public $str; // $content(a Content() instance)
    public $reader;

    public function __construct($file = 'index.php')
    {
        $this->source = $file;
        echo 'Welcome to ' . $this->source . "<br>";
    }

    public function __toString()
    {
        // $content.reset() => $content.__call(reset)
        $this->str->reset();
    }

    // start point
    public function __wakeup()
    {
        // $this->source => $show ref string evaluation => __toString
        if (preg_match("/gopher|phar|http|file|ftp|dict|\.\./i", $this->source)) {
            throw new Exception('invalid protocol found in ' . __CLASS__);
        }
    }

    public function reset()
    {
//        echo "how to use close method?";
        if ($this->reader !== null) {
            $this->reader->close();
        }
    }
}


highlight_file(__FILE__);