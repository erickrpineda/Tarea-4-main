import {Entity, model, property} from '@loopback/repository';

@model({settings: {idInjection: false, mssql: {schema: 'pro', table: 'categorias'}}})
export class Categorias extends Entity {
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
    length: 250,
    mssql: {columnName: 'nombre', dataType: 'nvarchar', dataLength: 250, dataPrecision: null, dataScale: null, nullable: 'NO'},
  })
  nombre: string;

  // Define well-known properties here

  // Indexer property to allow additional data
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  [prop: string]: any;

  constructor(data?: Partial<Categorias>) {
    super(data);
  }
}

export class vCategorias {
  id: number;
  categoria: string;
  producto: string;
}

export interface CategoriasRelations {
  // describe navigational properties here
}

export type CategoriasWithRelations = Categorias & CategoriasRelations;
