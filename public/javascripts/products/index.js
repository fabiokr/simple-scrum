$('table tbody tr:click').click(function() {
   window.location = Routes.productPath($(this).attr('id'));
});

