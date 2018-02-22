import { ApplicationConfig } from '@loopback/core';
import { RestApplication, RestServer } from '@loopback/rest';
import { PingController } from './controllers/ping.controller';
import { MySequence } from './sequence';
import { CameraController } from './controllers/cameras.controller';
import {
    Class,
    Repository,
    RepositoryMixin,
    DataSourceConstructor,
} from '@loopback/repository';
import { CameraRepository } from './repositories';
import { db } from './datasources/db.datasource';

export class PlatformAPI extends RepositoryMixin(RestApplication) {

    public constructor(options?: ApplicationConfig) {

        super(options);

        this.sequence(MySequence);
        this.setupControllers();
        this.setupRepositories();

    }

    public async start() {

        await super.start();

        const server = await this.getServer(RestServer);
        const port = await server.get('rest.port');

        console.log(`Server is running at http://127.0.0.1:${port}`);
        console.log(`Try http://127.0.0.1:${port}/ping`);

    }

    public setupControllers() {

        this.controller(PingController);
        this.controller(CameraController);

    }

    public setupRepositories() {
        // This will allow you to test your application without needing to
        // use the "real" datasource!
        const datasource = this.options && this.options.datasource ? new DataSourceConstructor(this.options.datasource) : db;

        this.bind('datasource').to(datasource);
        this.repository(CameraRepository);

    }

}
