import {DefaultCrudRepository} from '@loopback/repository';
import {Ordenes, OrdenesRelations} from '../models';
import {ConnDataSource} from '../datasources';
import {inject} from '@loopback/core';

export class OrdenesRepository extends DefaultCrudRepository<
  Ordenes,
  typeof Ordenes.prototype.id,
  OrdenesRelations
> {
  constructor(
    @inject('datasources.conn') dataSource: ConnDataSource,
  ) {
    super(Ordenes, dataSource);
  }
}
