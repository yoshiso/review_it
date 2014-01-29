var proxySnippet = require('grunt-connect-proxy/lib/utils').proxyRequest;
var mountFolder = function (connect, dir) {
  return connect.static(require('path').resolve(dir));
};

module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    connect: {
      options: {
        port: 9000,
        hostname: 'localhost',
        keepalive: true,
        middleware: function(connect, options) {
          var config = [
                          connect.static(options.base),
                          connect.directory(options.base)
                        ];
          var proxy = require('grunt-connect-proxy/lib/utils').proxyRequest;
          config.unshift(proxy);
          return config;
        }
      },
      proxies: [{
        context: '/api',
        host: 'localhost',
        port: '4567',
        changeOrigin: true
      }]
    }
  });

  grunt.loadNpmTasks('grunt-connect-proxy');
  grunt.loadNpmTasks('grunt-contrib-connect');

  grunt.registerTask('server', function(target) {
    if(target === 'dist') {
      return grunt.task.run(['connect']);
    }

    grunt.task.run([
      'configureProxies',
      'connect'
    ]);
  });
};
