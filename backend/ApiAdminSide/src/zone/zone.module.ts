import { Module } from '@nestjs/common';
import { ZoneService } from './zone.service';
import { ZoneController } from './zone.controller';
import { SpecificationFactory } from '../common/specifications/specification.factory';
import { ZoneQueryRepository } from './repositories/zone-query.repository';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Zone } from './entities/zone.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Zone])],
  exports: [TypeOrmModule],
  controllers: [ZoneController],
  providers: [ZoneService, ZoneQueryRepository, SpecificationFactory],
})
export class ZoneModule {}
