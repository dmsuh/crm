import {Module} from '@nestjs/common';
import {ConfigModule, ConfigService} from '@nestjs/config';
import {TypeOrmModule} from '@nestjs/typeorm';
import {ZoneModule} from './common/modules';
import {AppController} from './app.controller';
import {AppService} from './app.service';


@Module({
  imports: [
    ConfigModule.forRoot({
      cache: true,
      isGlobal: true,
      envFilePath: ['.env.development.local'],
      load: [dbConfig, baseConfig],
    }),
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
    }),
    ZoneModule,
  ],
  exports: [ConfigModule],
  controllers: [AppController],
  providers: [
    UniqueValidator,
    ExistsValidator,
    AppService,
    SpecificationFactory,
    {
      provide: 'APP_GUARD',
      useClass: JwtAuthGuard,
    },
  ],
})
export class AppModule {
}
