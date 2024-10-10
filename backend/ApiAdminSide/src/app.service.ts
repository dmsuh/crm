import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import axios from 'axios';

interface dtoLogin {
  access_token: string;
  base_domain: string;
}

axios.interceptors.request.use(
  (config) => {
    config.headers['X-Client-ID'] = 31992158;
    return config;
  },
  (error) => Promise.reject(error),
);

@Injectable()
export class AppService {
  constructor(private readonly httpService: HttpService) {}

  base_domian = <string>'';
  access_token = <string>'';

  async login(): Promise<any> {
    axios.defaults.headers.common['X-Client-Id'] = process.env.X_Client_Id;
    const data = await axios
      .get('https://app2.gnzs.ru/amocrm/test/oauth/get-token.php')
      .then((data) => data.data);
    this.base_domian = data.base_domain;
    this.access_token = data.access_token;

    return true;
  }

  getHello(): string {
    return 'Hello World!';
  }

  async addLead(lead: Lead): Promise<any> {
    const payload = <Lead[]>[
      {
        name: 'Сделка для примера 2',
        price: 10000,
        _embedded: {
          tags: [
            {
              id: 2719,
            },
          ],
        },
      },
    ];

    const data = await axios
      .post(`https://${this.base_domian}/api/v4/leads`, payload, {
        headers: {
          Authorization: 'Bearer ' + this.access_token,
        },
      })
      .then((data) => data.data);
    return data;
  }

  async addContact(contact: Contact): Promise<any> {
    const payload = <Contact[]>[
      {
        name: 'Владимир Смирнов',
      },
    ];

    const data = await axios
      .post(`https://${this.base_domian}/api/v4/contacts`, payload, {
        headers: {
          Authorization: 'Bearer ' + this.access_token,
        },
      })
      .then((data) => data.data);
    return data;
  }

  async addCompany(contact: Company): Promise<any> {
    const payload = <Company[]>[
      {
        name: 'АО Рога и Копыта',
        custom_fields_values: [
          {
            field_code: 'PHONE',
            values: [
              {
                value: '+7912322222',
                enum_code: 'WORK',
              },
            ],
          },
        ],
      },
    ];

    const data = await axios
      .post(`https://${this.base_domian}/api/v4/companies`, payload, {
        headers: {
          Authorization: 'Bearer ' + this.access_token,
        },
      })
      .then((data) => data.data);
    return data;
  }
}
