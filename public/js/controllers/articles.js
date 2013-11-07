(function() {
  angular.module("mean.articles").controller("ArticlesController", [
    "$scope", "$routeParams", "$location", "Global", "Articles", function($scope, $routeParams, $location, Global, Articles) {
      $scope.global = Global;
      $scope.create = function() {
        var article;
        article = new Articles({
          title: this.title,
          content: this.content
        });
        article.$save(function(response) {
          return $location.path("articles/" + response._id);
        });
        this.title = "";
        return this.content = "";
      };
      $scope.remove = function(article) {
        var i, _results;
        article.$remove();
        _results = [];
        for (i in $scope.articles) {
          if ($scope.articles[i] === article) {
            _results.push($scope.articles.splice(i, 1));
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };
      $scope.update = function() {
        var article;
        article = $scope.article;
        if (!article.updated) {
          article.updated = [];
        }
        article.updated.push(new Date().getTime());
        return article.$update(function() {
          return $location.path("articles/" + article._id);
        });
      };
      $scope.find = function() {
        return Articles.query(function(articles) {
          return $scope.articles = articles;
        });
      };
      return $scope.findOne = function() {
        return Articles.get({
          articleId: $routeParams.articleId
        }, function(article) {
          return $scope.article = article;
        });
      };
    }
  ]);

}).call(this);
