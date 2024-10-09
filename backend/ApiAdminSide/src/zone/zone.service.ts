import { Injectable } from '@nestjs/common';
import { CreateZoneDto } from './dto/create-zone.dto';
import { UpdateZoneDto } from './dto/update-zone.dto';
import { QueryFilterZoneDto } from './dto/query-filter-zone.dto';
import { ZoneQueryRepository } from './repositories/zone-query.repository';
import { DataSource } from 'typeorm';
import { ZoneNotFoundException } from './exceptions/zone-not-found.exception';
import { EntityDeleteDto } from '../common/dto/entity-delete.dto';
import { Zone } from './entities/zone.entity';

@Injectable()
export class ZoneService {
  constructor(
    private readonly zoneQueryRepository: ZoneQueryRepository,
    private readonly dataSource: DataSource,
  ) {}

  findAll(dto: QueryFilterZoneDto) {
    return this.zoneQueryRepository.getBaseQuery(dto).getMany();
  }

  async findOne(id: number) {
    const zone = await this.zoneQueryRepository.findOne(id);
    if (!zone) {
      throw new ZoneNotFoundException();
    }
    return zone;
  }

  async paginate(dto: QueryFilterZoneDto) {
    const query = this.zoneQueryRepository.getBaseQuery(dto);

    return {
      total: await query.getCount(),
      data: await query.getMany(),
    };
  }

  create(dto: CreateZoneDto) {
    return this.dataSource.transaction(async (manager) => {
      const zone = new Zone();

      zone.countryId = dto.countryId;
      zone.name = dto.name;
      zone.code = dto.code;
      zone.isActive = dto.isActive;

      return manager.save(zone);
    });
  }

  update(id: number, dto: UpdateZoneDto) {
    return this.dataSource.transaction(async (manager) => {
      const zone = await this.findOne(id);

      zone.countryId = dto.countryId;
      zone.name = dto.name;
      zone.code = dto.code;
      zone.isActive = dto.isActive;

      return manager.save(zone);
    });
  }

  remove(dto: EntityDeleteDto) {
    return this.dataSource.transaction(async (manager) => {
      for (const id of dto.ids) {
        const entity = await this.zoneQueryRepository.findOne(id);
        if (entity) {
          await manager.remove(entity);
        }
      }

      return true;
    });
  }
}
