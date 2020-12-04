import {inject, lifeCycleObserver, LifeCycleObserver} from '@loopback/core';
import {juggler} from '@loopback/repository';

/*const config = {
  name: 'conn',
  connector: 'mssql',
  url: 'mssql://talivan00220_SQLLogin_1:f37356i7k6@produccion00220.mssql.somee.com/produccion00220',
  host: 'produccion00220.mssql.somee.com',
  port: 1433,
  user: 'talivan00220_SQLLogin_1',
  password: 'f37356i7k6',
  database: 'produccion00220'
};*/

const config = {
  name: 'conn',
  connector: 'mssql',
  url: 'mssql://sa:Temporal+1@192.168.3.139/produccion',
  host: '192.168.3.139',
  port: 1433,
  user: 'sa',
  password: 'Temporal+1',
  database: 'produccion'
};
// Observe application's life cycle to disconnect the datasource when
// application is stopped. This allows the application to be shut down
// gracefully. The `stop()` method is inherited from `juggler.DataSource`.
// Learn more at https://loopback.io/doc/en/lb4/Life-cycle.html
@lifeCycleObserver('datasource')
export class ConnDataSource extends juggler.DataSource
  implements LifeCycleObserver {
  static dataSourceName = 'conn';
  static readonly defaultConfig = config;

  constructor(
    @inject('datasources.config.conn', {optional: true})
    dsConfig: object = config,
  ) {
    super(dsConfig);
  }
}
