<?php
class Boy{
    function __destruct()
    {
        echo $this -> name;
    }
}
include('phar://hack.phar');
?>
