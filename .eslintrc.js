module.exports = {
  "env": {
    "browser": true,
    "es6": true
  },
  "parser": "babel-eslint",
  "extends": "eslint:recommended",
  "parserOptions": {
    "ecmaFeatures": {
      "experimentalObjectRestSpread": true,
      "jsx": true
    },
    "sourceType": "module"
  },
  "plugins": [
    "react"
  ],
  "rules": {
    "comma-dangle": ["error", "always-multiline"],
    "no-console":  "error",
    "no-debugger": "error",
    "indent": [
      "error",
      2
    ],
    "no-unused-vars": [2, {'varsIgnorePattern': '_+'}],
    "consistent-return": ["error", { "treatUndefinedAsUnspecified": true }],
    "object-curly-spacing": ["error", "always"],
    "quotes": ["error", "double"],
    "no-multiple-empty-lines": [2, { "max": 2, "maxEOF": 0, "maxEOF": 0 }],
    "no-multi-spaces": [2, {
      "exceptions": {
        "Identifier": true,
        "ClassProperty": true,
        "ImportDeclaration": true,
        "VariableDeclarator": true,
        "AssignmentExpression": true,
        "ReturnStatement": true,
        "BlockStatement": true,
        "IfStatement": true,
        "JSXAttribute": true,
        "JSXIdentifier": true,
        "JSXOpeningElement": true,
        "JSXClosingElement": true
      }
    }],
    "linebreak-style": [
      "error",
      "unix"
    ],
    "quotes": [
      "error",
      "single"
    ],
    "semi": [
      "error",
      "always"
    ],
    "react/prefer-stateless-function": [2, {
      "ignorePureComponents": true
    }],
    "react/prop-types": 2,
    "react/jsx-uses-vars": [2],
    "react/jsx-indent": [2, 2],
    "react/jsx-indent-props": [2, 2],
    "key-spacing": [2, {
      "singleLine": {
        "beforeColon": false,
        "afterColon":  true
      },
      "multiLine": {
        "beforeColon": false,
        "afterColon":  true,
        "mode": "minimum"
      }
    }],
  }
};
