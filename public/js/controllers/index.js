(function() {
  angular.module('mean.system').controller('IndexController', [
    '$scope', 'Global', function($scope, Global) {
      return $scope.global = Global;
    }
  ]);

}).call(this);
