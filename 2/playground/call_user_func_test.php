<?php

class Action
{
    function run($args)
    {
        echo "foo() called." . "\r\n";
        echo "args: " . $args;
    }
}


call_user_func_array("Action::run", ["run something"]);