import './assets/main.css'
import MdiSvg from "@yeliulee/vue-mdi-svg/v3"

import {createApp} from 'vue'
import {createPinia} from 'pinia'

import App from './App.vue'
import router from './router'

const app = createApp(App)

app.use(createPinia())
app.use(MdiSvg)
app.use(router)

app.mount('#app')
