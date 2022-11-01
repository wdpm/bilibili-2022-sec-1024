const axios = require("axios")

//https://stackoverflow.com/a/65424198

/**
 *
 * @param {import("axios").AxiosInstance} axios
 * @param {Object} options
 * @param {number} options.retry_time
 * @param {number} options.retry_status_code
 */
const retryWrapper = (axios, options) => {
    const max_time = options.retry_time;
    const retry_status_code = options.retry_status_code;
    let counter = 0;
    axios.interceptors.response.use(null, (error) => {
        /** @type {import("axios").AxiosRequestConfig} */
        const config = error.config
        // you could defined status you want to retry, such as 503
        console.log(`error.response.status: ${error.response.status}`)
        // if (counter < max_time && error.response.status === retry_status_code) {
        if (counter < max_time) {
            console.log(`retry.... ${counter + 1}`)
            counter++
            return new Promise((resolve) => {
                resolve(axios(config))
            })
        }
        return Promise.reject(error)
    })
}

async function main() {
    retryWrapper(axios, {retry_time: 3})
    try {
        const result = await axios.get("https://httpstat.us/503")
        console.log(result.data);
    } catch (e) {
        console.log('SOME ERROR OCCURRED.')
    }
}

main()

