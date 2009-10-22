$(document).ready(function() {
  //row event
  $('.dataList tbody tr td:not(:has(*))').click(function(){
     window.location = $(this).parent().find('a.editLink').attr('href');
  });
});

