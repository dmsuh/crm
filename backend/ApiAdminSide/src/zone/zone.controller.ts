import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
} from '@nestjs/common';
import { ZoneService } from './zone.service';
import { CreateZoneDto } from './dto/create-zone.dto';
import { UpdateZoneDto } from './dto/update-zone.dto';
import { QueryFilterZoneDto } from './dto/query-filter-zone.dto';
import {
  ApiBearerAuth,
  ApiHeader,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { EntityDeleteDto } from '../common/dto/entity-delete.dto';

@ApiBearerAuth('basic')
@ApiHeader({
  name: 'Authorization',
  description: 'Токен пользователя для авторизации запросов',
  required: false,
})
@ApiTags('zone')
@Controller('zone')
export class ZoneController {
  constructor(private readonly zoneService: ZoneService) {}

  @ApiOperation({
    summary: 'Получить список регионов',
  })
  @Get()
  findAll(@Query() dto: QueryFilterZoneDto) {
    return this.zoneService.findAll(dto);
  }

  @ApiParam({
    name: 'id',
    type: Number,
    description: 'id региона',
    required: true,
  })
  @ApiOperation({
    summary: 'Получить регион по id',
  })
  @Get(':id')
  findOne(@Param('id') id: number) {
    return this.zoneService.findOne(+id);
  }

  @ApiOperation({
    summary: 'Получить табличный список регионов',
  })
  @Post('paginate')
  paginate(@Body() dto: QueryFilterZoneDto) {
    return this.zoneService.paginate(dto);
  }

  @ApiOperation({
    summary: 'Создать регион',
  })
  @Post()
  create(@Body() dto: CreateZoneDto) {
    return this.zoneService.create(dto);
  }

  @ApiOperation({
    summary: 'Обновить регион по id',
  })
  @ApiParam({
    name: 'id',
    type: Number,
    description: 'id региона',
    required: true,
  })
  @Patch(':id')
  update(@Param('id') id: number, @Body() dto: UpdateZoneDto) {
    return this.zoneService.update(+id, dto);
  }

  @ApiOperation({
    summary: 'Множественное удаление регионов',
  })
  @Delete()
  remove(@Body() dto: EntityDeleteDto) {
    return this.zoneService.remove(dto);
  }
}
