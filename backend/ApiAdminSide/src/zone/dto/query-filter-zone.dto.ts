import { IsBoolean, IsNumber, IsOptional, IsString } from 'class-validator';
import { PaginateDto } from '../../common/dto/paginate.dto';
import { ApiProperty, PartialType } from '@nestjs/swagger';
import { Type } from 'class-transformer';

export class QueryFilterZoneDto extends PartialType(PaginateDto) {
  @ApiProperty({
    required: false,
    type: Number,
  })
  @IsNumber()
  @Type(() => Number)
  @IsOptional()
  countryId: number;

  @ApiProperty({
    required: false,
    type: String,
  })
  @IsString()
  @IsOptional()
  name: string;

  @ApiProperty({
    required: false,
    type: String,
  })
  @IsString()
  @IsOptional()
  code: string;

  @ApiProperty({
    required: false,
    type: Boolean,
    default: true,
  })
  @IsBoolean()
  @Type(() => Boolean)
  @IsOptional()
  isActive: boolean;
}
