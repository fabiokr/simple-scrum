$(document).ready(function() {
  $('.dataList tbody tr td:not(:has(*))').live('click', function(){
    showDetailDialog($(this).parent().find('a.showLink').attr('href'));
  });
});

