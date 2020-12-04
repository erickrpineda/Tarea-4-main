import {DefaultCrudRepository} from '@loopback/repository';
import {Maquina, MaquinaRelations} from '../models';
import {ConnDataSource} from '../datasources';
import {inject} from '@loopback/core';

export class MaquinaRepository extends DefaultCrudRepository<
  Maquina,
  typeof Maquina.prototype.id,
  MaquinaRelations
> {
  constructor(
    @inject('datasources.conn') dataSource: ConnDataSource,
  ) {
    super(Maquina, dataSource);
  }
}
