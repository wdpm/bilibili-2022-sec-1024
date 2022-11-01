<?php

// $key="e45e329feb5d925b";
$key = "flag3{Beh1_nder}";

function decrypt(string $post, string $key): string
{
    // 首先base64解码
    $t = "base64_" . "decode";
    $post = $t($post . "");

    // XOR decrypt
    for ($i = 0; $i < strlen($post); $i++) {
        //  $post[$i] = $post[$i]^$key[$i+1&15];
        //  猜测结果：这里从key[index]从index=0开始
        $post[$i] = $post[$i] ^ $key[$i + 0 & 15];
    }

    return $post;
}


for ($i = 1; $i <= 7; $i++) {
    $request= './text/rq-'.strval($i).'.txt';
    $response = './text/rs-'.strval($i).'.txt';

    $req_content = file_get_contents($request);
    $resp_content= file_get_contents($response);

    $req_decrypted = decrypt($req_content,$key);
    $resp_decrypted = decrypt($resp_content,$key);

    file_put_contents($request . ".decrypt", $req_decrypted);
    file_put_contents($response . ".decrypt", $resp_decrypted);
}

