import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { useContainer } from 'class-validator';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

(async function () {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(
    new ValidationPipe({
      transform: true,
    }),
  );
  app.enableCors();
  useContainer(app.select(AppModule), { fallbackOnErrors: true });
  const config = new DocumentBuilder()
    .addBearerAuth(
      {
        type: 'http',
        scheme: 'bearer',
        description: 'Авторизация по JSON Web Token',
        bearerFormat: '',
      },
      'basic',
    )
    .setTitle('Esme Shop')
    .setDescription(
      'Добро пожаловать в API магазина ESME INS. Для того что бы авторизовать запросы, необходимо получить токен ' +
        'выполнив запрос "/auth/login", затем вставить этот токен в форму авторизации по кнопке "Authorize". ' +
        'После этих двух шагов вы можете беспрепятственно тестировать API через Swagger Documentation',
    )
    .setVersion('1.0')
    .addTag('app')
    .addTag('auth')
    .addTag('attribute')
    .addTag('category')
    .addTag('country')
    .addTag('zone')
    .addTag('customer')
    .addTag('currency')
    .addTag('filter')
    .addTag('information')
    .addTag('manufacturer')
    .addTag('option')
    .addTag('order')
    .addTag('product')
    .addTag('return')
    .addTag('upload')
    .addTag('location')
    .addTag('weight-class')
    .addTag('length-class')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);
  await app.listen(parseInt(process.env.PORT, 10) || 3000);
})();
