import {Entity, model, property} from '@loopback/repository';

@model({settings: {idInjection: false, mssql: {schema: 'rrh', table: 'horarios'}}})
export class Horarios extends Entity {
  @property({
    type: 'number',
    required: true,
    precision: 10,
    scale: 0,
    id: 1,
    mssql: {columnName: 'id', dataType: 'int', dataLength: null, dataPrecision: 10, dataScale: 0, nullable: 'NO'},
  })
  id: number;

  @property({
    type: 'string',
    required: true,
    length: 50,
    mssql: {columnName: 'nombre', dataType: 'nvarchar', dataLength: 50, dataPrecision: null, dataScale: null, nullable: 'NO'},
  })
  nombre: string;

  @property({
    type: 'date',
    mssql: {columnName: 'inicio', dataType: 'time', dataLength: null, dataPrecision: null, dataScale: null, nullable: 'YES'},
  })
  inicio?: string;

  @property({
    type: 'date',
    mssql: {columnName: 'final', dataType: 'time', dataLength: null, dataPrecision: null, dataScale: null, nullable: 'YES'},
  })
  final?: string;

  @property({
    type: 'string',
    length: -1,
    mssql: {columnName: 'observacion', dataType: 'nvarchar', dataLength: -1, dataPrecision: null, dataScale: null, nullable: 'YES'},
  })
  observacion?: string;

  // Define well-known properties here

  // Indexer property to allow additional data
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  [prop: string]: any;

  constructor(data?: Partial<Horarios>) {
    super(data);
  }
}

export interface HorariosRelations {
  // describe navigational properties here
}

export type HorariosWithRelations = Horarios & HorariosRelations;
