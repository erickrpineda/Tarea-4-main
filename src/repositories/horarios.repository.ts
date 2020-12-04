import {DefaultCrudRepository} from '@loopback/repository';
import {Horarios, HorariosRelations} from '../models';
import {ConnDataSource} from '../datasources';
import {inject} from '@loopback/core';

export class HorariosRepository extends DefaultCrudRepository<
  Horarios,
  typeof Horarios.prototype.id,
  HorariosRelations
> {
  constructor(
    @inject('datasources.conn') dataSource: ConnDataSource,
  ) {
    super(Horarios, dataSource);
  }
}
