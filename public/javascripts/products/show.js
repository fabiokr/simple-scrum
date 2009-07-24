$(document).ready(function () {
  $('#change-product').change(
    function(e) {
      window.location = Routes.productPath($("#change-product option:selected").val());
    }
  );
});

