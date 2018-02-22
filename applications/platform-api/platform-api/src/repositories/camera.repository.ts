import { DefaultCrudRepository, DataSourceType } from '@loopback/repository';
import { Camera } from '../models';
import { inject } from '@loopback/core';

export class CameraRepository extends DefaultCrudRepository<Camera, typeof Camera.prototype.id> {

    public constructor(@inject('datasource') protected datasource: DataSourceType) {

        super(Camera, datasource);

    }

}