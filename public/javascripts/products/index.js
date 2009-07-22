$(document).ready(function () {
  $('table tbody tr').click(
    function(e) {
      window.location = Routes.product_path($(this).attr('id'));
    }
  );
});

