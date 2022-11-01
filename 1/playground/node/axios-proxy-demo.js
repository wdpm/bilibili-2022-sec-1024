//https://github.com/axios/axios/issues/2072#issuecomment-567473812

const HttpsProxyAgent = require('https-proxy-agent');
let axios = require('axios')

// https://ip.jiangxianli.com/

const axiosDefaultConfig = {
    // baseURL: 'https://www.youtube.com',
    proxy: false,
    httpsAgent: new HttpsProxyAgent('http://207.236.12.190:80')
};

client = axios.create(axiosDefaultConfig);
client.get('https://security.bilibili.com/')
    .then(function (response) {
        console.log('Response with axios was ok: ' + response.status);
        // console.log(response.data)
    })
    .catch(function (error) {
        console.log(error);
    });
