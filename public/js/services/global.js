(function() {
  angular.module("mean.system").factory("Global", [
    function() {
      var _this;
      _this = this;
      _this._data = {
        user: window.user,
        authenticated: !!window.user
      };
      return _this._data;
    }
  ]);

}).call(this);
