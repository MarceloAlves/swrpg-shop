module.exports = {
  'settings': {
    'react': {
      'version': 'detect'
    }
  },
  'env': {
    'browser': true,
    'es6': true
  },
  'extends': ['standard', 'plugin:react/recommended'],
  'globals': {
    'Atomics': 'readonly',
    'SharedArrayBuffer': 'readonly'
  },
  'parserOptions': {
    'ecmaFeatures': {
      'jsx': true
    },
    'ecmaVersion': 2018,
    'sourceType': 'module'
  },
  'plugins': [
    'react',
    'react-hooks'
  ],
  'rules': {
    'jsx-quotes': ["error", "prefer-single"],
    'react-hooks/rules-of-hooks': 2,
    'react-hooks/exhaustive-deps': 2
  }
}
