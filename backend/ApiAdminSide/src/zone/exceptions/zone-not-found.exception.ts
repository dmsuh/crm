import { HttpException, HttpStatus } from '@nestjs/common';

export class ZoneNotFoundException extends HttpException {
  constructor() {
    super('Zone not found', HttpStatus.NOT_FOUND);
  }
}
