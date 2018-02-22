import { post, param, get, put, patch, del } from '@loopback/openapi-v2';
import { HttpErrors } from '@loopback/rest';
import { CameraSchema, Camera } from '../models';
import { repository } from '@loopback/repository';
import { CameraRepository } from '../repositories/index';

export class CameraController {

    public constructor(@repository(CameraRepository.name) protected CameraRepo: CameraRepository) { }

    @post('/camera')
    @param.body('Camera', CameraSchema)
    public async createCamera(Camera: Camera) {

        console.log(Camera);

        if (!Camera.title) {

            return Promise.reject(new HttpErrors.BadRequest('title is required'));

        }

        return await this.CameraRepo.create(Camera);

    }

    @get('/camera/{id}')
    @param.path.number('id')
    @param.query.boolean('items')
    public async findCameraById(id: number, items?: boolean): Promise<Camera> {

        return await this.CameraRepo.findById(id);

    }

    @get('/camera')
    public async findCameras(): Promise<Camera[]> {

        return await this.CameraRepo.find();

    }

    @put('/camera/{id}')
    @param.path.number('id')
    @param.body('Camera', CameraSchema)
    public async replaceCamera(id: number, Camera: Camera): Promise<boolean> {

        return await this.CameraRepo.replaceById(id, Camera);

    }

    @patch('/camera/{id}')
    @param.path.number('id')
    @param.body('Camera', CameraSchema)
    public async updateCamera(id: number, Camera: Camera): Promise<boolean> {

        return await this.CameraRepo.updateById(id, Camera);

    }

    @del('/camera/{id}')
    @param.path.number('id')
    public async deleteCamera(id: number): Promise<boolean> {

        return await this.CameraRepo.deleteById(id);

    }

}