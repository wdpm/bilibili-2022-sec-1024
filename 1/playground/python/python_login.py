from http.cookies import SimpleCookie

import requests

# POST /crack1/login HTTP/2
# Host: security.bilibili.com
# Cookie: sessionid=68ptoochmwli2ys89nhvf8jfi2vzi5q7
# Content-Length: 115
# Sec-Ch-Ua: "(Not(A:Brand";v="8", "Chromium";v="101"
# Accept: application/json, text/javascript, */*; q=0.01
# Content-Type: application/json
# X-Requested-With: XMLHttpRequest
# Sec-Ch-Ua-Mobile: ?0
# User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36
# Sec-Ch-Ua-Platform: "Windows"
# Origin: https://security.bilibili.com
# Sec-Fetch-Site: same-origin
# Sec-Fetch-Mode: cors
# Sec-Fetch-Dest: empty
# Referer: https://security.bilibili.com/crack1/index
# Accept-Encoding: gzip, deflate
# Accept-Language: zh-CN,zh;q=0.9


headers = {
    "Host": "security.bilibili.com",
    "Sec-Ch-Ua": f'"(Not(A:Brand";v="8", "Chromium";v="101"',
    "Accept": "application/json, text/javascript, */*; q=0.01",
    "Content-Type": "application/json",
    "Sec-Ch-Ua-Mobile": "?0",
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36",
    "Sec-Ch-Ua-Platform": "Windows",
    "Origin": "https://security.bilibili.com",
    "Sec-Fetch-Site": "same-origin",
    "Sec-Fetch-Mode": "cors",
    "Sec-Fetch-Dest": "empty",
    "Referer": "https://security.bilibili.com/crack1/index",
    "Accept-Encoding": "gzip, deflate",
    "Accept-Language": "zh-CN,zh;q=0.9",
}

s = requests.Session()
s.trust_env = False

# if value contains many key-value pairs, must be encoded before loading.
rawdata_encode = 'sessionid=68ptoochmwli2ys89nhvf8jfi2vzi5q7'
cookie = SimpleCookie()
cookie.load(rawdata_encode)

cookie_dict = {k: v.value for k, v in cookie.items()}
cookiejar = requests.utils.cookiejar_from_dict(cookie_dict)
s.cookies = cookiejar

base_url = "https://security.bilibili.com"
login_path = "/crack1/login"
login_url = base_url + login_path

data = {"username": "admin",
        "password": "Aa123456",
        "nonce": 9,
        "random": "82cfe3f8-5ef0-4e0b-b1e2-59fbf5da5f78",
        "proof": "1003"}

resp = s.post(login_url, data=data, headers=headers)
print(resp.request.headers)
print(resp.status_code)
# print(resp.text)
