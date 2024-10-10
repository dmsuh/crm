import Axios from 'axios'


declare module 'axios' {
    interface AxiosRequestConfig {
        hideNotification?: boolean;
    }
}

const axiosInstance = Axios.create({
    baseURL: `http://localhost:3000/`
})

const httpClient = {
    get(url: string, data?: AxiosRequestConfig) {
        return axiosInstance.get(url, data)
    },

    post(url: string, data?: any, config?: AxiosRequestConfig) {
        return axiosInstance.post(url, data, config)
    },

    put(url: string, data?: any, config?: AxiosRequestConfig) {
        return axiosInstance.put(url, data, config)
    },

    patch(url: string, data?: any, config?: AxiosRequestConfig) {
        return axiosInstance.patch(url, data, config)
    },

    delete(url: string, data?: any, config: AxiosRequestConfig = {}) {
        if (data && !config.data) {
            config.data = data
        }

        return axiosInstance.delete(url, config)
    }
}

export {axiosInstance, httpClient}
