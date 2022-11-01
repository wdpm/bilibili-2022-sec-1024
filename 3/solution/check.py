# https://liriu.life/PHP-5ba36eb0362743ed8fa5588c97325f7e

from base64 import b64decode

# 明文片段
phrases = [
    "assert|eval(base64_decode('".encode(),
    b'<?\n@error_reporting(0);\n\nfunctio',
    b'<?\nfunction main($action, $remot',
    b'<?\n@error_reporting(0);\nset_time',
    b'\nerror_reporting(0);\n\nfunction m',
    b'<?\n@error_reporting(0);\n\n\nfuncti',
    b'<?\nerror_reporting(0);\nfunction ',
    b'@error_reporting(0);\nfunction ma',
    b'<?php\n\n$taskResult = array();\n$p',
    b"<?\nerror_reporting(0);\nheader('C",
    b'@error_reporting(0);\n\nfunction g',
    b'<?\n@error_reporting(0);\n@set_tim',
]


def xor(l0, l1):
    ret = [chr(ord(chr(a)) ^ ord(chr(b))) for a, b in zip(l0, l1)]
    return "".join(ret)


def check(cipher):
    cipher = b64decode(cipher)
    for phrase in phrases:
        p0 = phrase[0:16]
        p1 = phrase[16:]

        c0 = cipher[0:16]
        c1 = cipher[16:16 + len(p1)]

        # 16 bits
        k0 = xor(p0, c0)
        # 11 bits
        k1 = xor(p1, c1)

        if (k1 in k0) and k1:
            # k1: 45e329feb5d; k0: 45e329feb5d925be
            print(f'k1: {k1};k0: {k0}')
            return k0
    return None


def read_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as fp:
        return fp.read()


# cipher = "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"

def force_check(cipher):
    key = check(cipher)
    if key:
        print("[+]", cipher[:32], "is XOR Behinder Request!")
        print("[+] The Key of Behinder is ", key)
        return True
    else:
        print("[-]", cipher[:32], "not Behinder Request..")
        return False


cipher_content = read_file('./text/rq-1.txt')

print(len(cipher_content))

# 尝试所有可能的payload开头,思路就是暴力枚举破解。
# 如果`cipher[0] ^ payload[0] == cipher[1] ^ payload[1]`
# 即可判断 【该bytes 确实使用了 相同的key 异或加密 cipher[0] 和 cipher[1]】
# 进而推出 【该加密协议是 XOR，密钥为key】

# for loop step is a multiple of 4 due to base64 algorithm.
for i in range(16, len(cipher_content), 4):
    cipher_content_slice = cipher_content[0:i]
    result = force_check(cipher_content_slice)
    if result:
        print(f'i: {i}')
        break

    print('behind XOR is not found.')

# k1: fl;k0: flag3{Beh1_nder}
# [+] JgkTFVwJHRcNQTAcEAwcGk5c is XOR Behinder Request!
# [+] The Key of Behinder is  flag3{Beh1_nder}
# i: 24
