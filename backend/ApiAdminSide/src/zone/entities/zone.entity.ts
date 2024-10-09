import { BaseEntity, Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity()
export class Zone extends BaseEntity {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({
    type: 'integer',
    nullable: false,
  })
  countryId: number;

  @Column({
    type: 'varchar',
    length: 128,
  })
  name: string;

  @Column({
    type: 'varchar',
    length: 32,
  })
  code: string;

  @Column({
    type: 'boolean',
    default: true,
  })
  isActive: boolean;
}
