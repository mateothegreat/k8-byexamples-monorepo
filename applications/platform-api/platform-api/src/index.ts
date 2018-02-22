import {PlatformAPI} from './application';
import {ApplicationConfig} from '@loopback/core';

export {PlatformAPI};

export async function main(options?: ApplicationConfig) {
  const app = new PlatformAPI(options);

  try {
    await app.start();
  } catch (err) {
    console.error(`Unable to start application: ${err}`);
  }
  return app;
}
