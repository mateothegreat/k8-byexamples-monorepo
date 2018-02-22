import * as path from 'path';
import * as fs from 'fs';
import { DataSourceConstructor, juggler } from '@loopback/repository';

const dsConfigPath = path.resolve('config', 'datasources.json');

const config = require(dsConfigPath);

export const db = new DataSourceConstructor(config);