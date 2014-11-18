path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    app:
      name: 'mezouilhac'
    port: 3000
    db: 'mongodb://localhost:27017/mezouilhac'
    

  test:
    root: rootPath
    app:
      name: 'mezouilhac'
    port: 3000
    db: 'mongodb://localhost:27017/mezouilhac'
    

  production:
    root: rootPath
    app:
      name: 'mezouilhac'
    port: 3000
    db: 'mongodb://localhost:27017/mezouilhac'
    

module.exports = config[env]
