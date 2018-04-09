module.exports = {
  notify: true,
  verbose: true,
  rootDir: '../',
  modulePaths: ['<rootDir>/app/javascript/src', '<rootDir>/spec/javascript'],
  testRegex: 'spec\/javascript\/.*\.spec\.js$',
  transform: {
    "^.+\\.jsx?$": "babel-jest"
  },
}
