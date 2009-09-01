$(document).ready(function() {
  $('table#dataList tbody tr td:not(:has(*))').click(function(){
     window.location = $(this).parent().find('a.showLink').attr('href');
  });
});

