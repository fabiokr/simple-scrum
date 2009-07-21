$(document).ready(function () {
  $('#change-product').change(
    function(e) {
      window.location = '/products/'+$("#change-product option:selected").val();
    }
  );
});

