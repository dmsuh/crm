import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { Injectable } from '@nestjs/common';
import { QueryFilterZoneDto } from '../dto/query-filter-zone.dto';
import { SpecificationFactory } from '../../common/specifications/specification.factory';
import { Zone } from '../entities/zone.entity';

@Injectable()
export class ZoneQueryRepository {
  constructor(
    @InjectRepository(Zone)
    private readonly zoneRepository: Repository<Zone>,
    private readonly specificationFactory: SpecificationFactory<Zone>,
  ) {}

  getBaseQuery(dto: QueryFilterZoneDto) {
    const query = this.zoneRepository.createQueryBuilder();

    this.specificationFactory.build(dto, query, [
      { column: 'id', operator: 'equals' },
      { column: 'countryId', operator: 'equals' },
      { column: 'name', operator: 'like' },
      { column: 'code', operator: 'like' },
      { column: 'isActive', operator: 'equals' },
    ]);

    return query;
  }

  findOne(id: number) {
    return this.zoneRepository
      .createQueryBuilder()
      .where('id = :id', { id })
      .getOne();
  }
}
