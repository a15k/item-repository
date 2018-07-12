module.exports = {
  notify: true,
  verbose: true,
  rootDir: '../',
  testEnvironment: './spec/javascript/environment.js',
  setupTestFrameworkScriptFile: '<rootDir>/spec/javascript/spec_helper.js',
  modulePaths: ['<rootDir>/app/javascript', '<rootDir>/spec/javascript'],
  testRegex: 'spec\/javascript\/.*\.spec\.js$',
  transform: {
    "^.+\\.jsx?$": "babel-jest",
  },
}
