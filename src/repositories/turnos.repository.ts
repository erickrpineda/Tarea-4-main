import {DefaultCrudRepository} from '@loopback/repository';
import {Turnos, TurnosRelations} from '../models';
import {ConnDataSource} from '../datasources';
import {inject} from '@loopback/core';

export class TurnosRepository extends DefaultCrudRepository<
  Turnos,
  typeof Turnos.prototype.id,
  TurnosRelations
> {
  constructor(
    @inject('datasources.conn') dataSource: ConnDataSource,
  ) {
    super(Turnos, dataSource);
  }
}
