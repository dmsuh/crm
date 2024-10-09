import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import axios from 'axios';

interface dtoLogin {
  access_token: string;
  base_domain: string;
}

axios.interceptors.request.use(
  (config) => {
    console.log('Interception!');
    config.headers['X-Client-ID'] = 31992158;
    return config;
  },
  (error) => Promise.reject(error),
);

@Injectable()
export class AppService {
  constructor(private readonly httpService: HttpService) {}

  async login(): Promise<any> {
    axios.defaults.headers.common['X-Client-Id'] = 31992158;
    return axios
      .get('https://app2.gnzs.ru/amocrm/test/oauth/get-token.php')
      .then((data) => data.data);
  }

  getHello(): string {
    return 'Hello World!';
  }
}
