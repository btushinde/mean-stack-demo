(function() {
  window.bootstrap = function() {
    return angular.bootstrap(document, ["mean"]);
  };

  window.init = function() {
    return window.bootstrap();
  };

  angular.element(document).ready(function() {
    if (window.location.hash === "#_=_") {
      window.location.hash = "";
    }
    return window.init();
  });

}).call(this);
