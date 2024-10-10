import { Body, Controller, Get, Post } from '@nestjs/common';
import { AppService } from './app.service';
import { ApiOperation, ApiTags } from '@nestjs/swagger';

@ApiTags('app')
@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  async getHello(): Promise<any> {
    return await this.appService.login();
  }

  @ApiOperation({
    summary: 'Добавить сделку',
  })
  @Post('addLead')
  addLead(@Body() dto: Lead) {
    return this.appService.addLead(dto);
  }

  @ApiOperation({
    summary: 'Добавить контакт',
  })
  @Post('addContact')
  addContact(@Body() dto: Contact) {
    return this.appService.addContact(dto);
  }

  @ApiOperation({
    summary: 'Добавить Компанию',
  })
  @Post('addCompany')
  addCompany(@Body() dto: Company) {
    return this.appService.addCompany(dto);
  }
}
