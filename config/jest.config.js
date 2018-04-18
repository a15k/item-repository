module.exports = {
  notify: true,
  verbose: true,
  rootDir: '../',
  setupTestFrameworkScriptFile: '<rootDir>/spec/javascript/spec_helper.js',
  modulePaths: ['<rootDir>/app/javascript', '<rootDir>/spec/javascript'],
  testRegex: 'spec\/javascript\/.*\.spec\.js$',
  transform: {
    "^.+\\.jsx?$": "babel-jest"
  },
}
