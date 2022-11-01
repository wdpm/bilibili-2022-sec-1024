const axios = require('axios');
const axiosRetry = require('axios-retry');

axiosRetry(axios, {
    retries: 3, // number of retries
    retryDelay: (retryCount) => {
        console.log(`retry attempt: ${retryCount}`);
        return retryCount * 1000; // time interval between retries
    },
    retryCondition: (error) => {
        // if retry condition is not specified, by default idempotent requests are retried
        return axiosRetry.isNetworkOrIdempotentRequestError(error) || error.response.status === 503;
    },

    onRetry : (retryCount, error, requestConfig)=>{
        console.log(`retryCount: ${retryCount}`)
    }
});

async function makeRequest() {
    await axios({
        method: 'GET',
        url: 'https://httpstat.us/503',
    }).catch((err) => {
        console.error(`API call failed with err: ${err}. after 3 retry attempts`)
    });
}

const response = makeRequest();
// 只有1次重试。重试机制无效
