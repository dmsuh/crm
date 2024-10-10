import {httpClient} from '@/services/httpClient'

class Api {

    auth(): Promise<any> {
        return httpClient.get('/')
    }

    createCompany(payload: any): Promise<any> {
        return httpClient.post('/addCompany', payload)
    }

    createContact(payload: any): Promise<any> {
        return httpClient.post('/addContact', payload)
    }

    createLead(payload: any): Promise<any> {
        return httpClient.post('/addLead', payload)
    }
}

export default new Api()
