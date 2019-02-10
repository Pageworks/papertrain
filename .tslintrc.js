module.exports = {
    extends: [
      'tslint-config-airbnb',
      'tslint-config-prettier',
    ],
    defaultSeverity: 'error',
    rules: {
      'no-debugger': true,
      'prefer-array-literal': [ true, { 'allow-type-parameters': true } ],
      'variable-name': [ true, 'ban-keywords', 'check-format', 'allow-pascal-case', 'allow-leading-underscore'],
      'max-line-length': false,
      'no-increment-decrement': false,
      'strict-boolean-expressions': false,
      'import-name': false,
      'radix': false
    },
  };