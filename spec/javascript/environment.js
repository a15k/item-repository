const JestEnvironment = require('jest-environment-jsdom');
const { exec } = require('child_process');

const RAILS_ROOT = __dirname + '/../..';
let client_path;

function readVar(expr) {
  if (client_path) return Promise.resolve(client_path);

  return new Promise((resolve, reject) => {
    exec(
      `${RAILS_ROOT}/bin/rails runner -e test 'puts ${expr}'`,
      (error, stdout) => {
        if (error) { reject(error); }
        resolve(stdout.split("\n")[0]);
      });
  });
}

class CustomEnvironment extends JestEnvironment {
  constructor(config) {
    super(config);
  }

  async setup() {
    await super.setup();
    this.global.interactions = {
      api_path: await readVar('A15K::Interactions.js_client_path'),
      url: await readVar('Rails.application.secrets[:interactions_api][:url]'),
    };
  }

  async teardown() {
    await super.teardown();
  }

  runScript(script) {
    return super.runScript(script);
  }
}

module.exports = CustomEnvironment;
