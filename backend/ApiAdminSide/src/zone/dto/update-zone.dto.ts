import { CreateZoneDto } from './create-zone.dto';
import { ApiProperty } from '@nestjs/swagger';
import { IsNumber } from 'class-validator';

export class UpdateZoneDto extends CreateZoneDto {
  @ApiProperty({
    required: true,
    type: Number,
  })
  @IsNumber()
  id: number;
}
