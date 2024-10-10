import {computed, ref} from 'vue'
import {defineStore} from 'pinia'
import Api from "@/services/api/Api";

export const useDataStore = defineStore('Data', () => {
    const data = ref(<{ id: Number, name: String }[]>[])
    const getData = computed(() => data)


    function auth() {
        Api.auth()
    }

    async function addData(name: String) {
        let idData = null
        switch (name) {
            case 'lead': {
                const dataServ = await Api.createLead(1)
                idData = dataServ.data._embedded.leads[0].id;
                break;
            }
            case 'contact': {
                const dataServ = await Api.createContact(1)
                idData = dataServ.data._embedded.contacts[0].id;
                break;
            }
            case 'company': {
                const dataServ = await Api.createCompany(1)
                idData = dataServ.data._embedded.companies[0].id;
                break;
            }
        }


        if (name !== 'none') {
            const payload = {
                id: idData,
                name: name
            }


            data.value.push(payload)
        }
    }

    return {data, auth, getData, addData}
})
