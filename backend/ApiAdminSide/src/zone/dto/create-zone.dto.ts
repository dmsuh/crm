import {
  IsBoolean,
  IsNotEmpty,
  IsNumber,
  IsString,
  MaxLength,
} from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class CreateZoneDto {
  @ApiProperty({
    required: true,
    type: Number,
  })
  @IsNumber()
  countryId: number;

  @ApiProperty({
    required: true,
    type: String,
    maxLength: 128,
  })
  @IsString()
  @IsNotEmpty()
  @MaxLength(128)
  name: string;

  @ApiProperty({
    required: true,
    type: String,
    maxLength: 32,
  })
  @IsString()
  @IsNotEmpty()
  @MaxLength(32)
  code: string;

  @ApiProperty({
    required: true,
    type: Boolean,
    default: true,
  })
  @IsBoolean()
  isActive: boolean;
}
