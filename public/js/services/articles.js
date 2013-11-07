(function() {
  angular.module('mean.articles').factory('Articles', [
    '$resource', function($resource) {
      return $resource('articles/:articleId', {
        articleId: '@_id'
      }, {
        update: {
          method: 'PUT'
        }
      });
    }
  ]);

}).call(this);
