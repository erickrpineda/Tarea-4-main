import {
  Count,
  CountSchema,
  Filter,
  FilterExcludingWhere,
  repository,
  Where
} from '@loopback/repository';
import {
  del, get,
  getModelSchemaRef, param,


  patch, post,




  put,

  requestBody
} from '@loopback/rest';
import {Maquina} from '../models';
import {MaquinaRepository} from '../repositories';

export class MaquinaController {
  constructor(
    @repository(MaquinaRepository)
    public maquinaRepository: MaquinaRepository,
  ) { }

  @post('/maquinas', {
    responses: {
      '200': {
        description: 'Maquina model instance',
        content: {'application/json': {schema: getModelSchemaRef(Maquina)}},
      },
    },
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Maquina, {
            title: 'NewMaquina',

          }),
        },
      },
    })
    maquina: Maquina,
  ): Promise<Maquina> {
    return this.maquinaRepository.create(maquina);
  }

  @get('/maquinas/count', {
    responses: {
      '200': {
        description: 'Maquina model count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async count(
    @param.where(Maquina) where?: Where<Maquina>,
  ): Promise<Count> {
    return this.maquinaRepository.count(where);
  }

  @get('/maquinas', {
    responses: {
      '200': {
        description: 'Array of Maquina model instances',
        content: {
          'application/json': {
            schema: {
              type: 'array',
              items: getModelSchemaRef(Maquina, {includeRelations: true}),
            },
          },
        },
      },
    },
  })
  async find(
    @param.filter(Maquina) filter?: Filter<Maquina>,
  ): Promise<Maquina[]> {
    return this.maquinaRepository.find(filter);
  }

  @patch('/maquinas', {
    responses: {
      '200': {
        description: 'Maquina PATCH success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Maquina, {partial: true}),
        },
      },
    })
    maquina: Maquina,
    @param.where(Maquina) where?: Where<Maquina>,
  ): Promise<Count> {
    return this.maquinaRepository.updateAll(maquina, where);
  }

  @get('/maquinas/{id}', {
    responses: {
      '200': {
        description: 'Maquina model instance',
        content: {
          'application/json': {
            schema: getModelSchemaRef(Maquina, {includeRelations: true}),
          },
        },
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.filter(Maquina, {exclude: 'where'}) filter?: FilterExcludingWhere<Maquina>
  ): Promise<Maquina> {
    return this.maquinaRepository.findById(id, filter);
  }

  @patch('/maquinas/{id}', {
    responses: {
      '204': {
        description: 'Maquina PATCH success',
      },
    },
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Maquina, {partial: true}),
        },
      },
    })
    maquina: Maquina,
  ): Promise<void> {
    await this.maquinaRepository.updateById(id, maquina);
  }

  @put('/maquinas/{id}', {
    responses: {
      '204': {
        description: 'Maquina PUT success',
      },
    },
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() maquina: Maquina,
  ): Promise<void> {
    await this.maquinaRepository.replaceById(id, maquina);
  }

  @del('/maquinas/{id}', {
    responses: {
      '204': {
        description: 'Maquina DELETE success',
      },
    },
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.maquinaRepository.deleteById(id);
  }

  @get('/mmaquinas/vista1')
  async vista1(): Promise<any> {
    let datos: any[] = await this.getView();
    return datos;
  }

  async getView() {
    return await this.maquinaRepository.dataSource.execute(
      `SELECT * FROM pro.vProductosMaquina`,
    );
  }
}
