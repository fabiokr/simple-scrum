$(document).ready(function () {
  $('table tbody tr').click(function(e) {
    window.location = Routes.productPath($(this).attr('id'));
  });
});

