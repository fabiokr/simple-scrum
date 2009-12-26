$(document).ready(function() {
  $('#tickets table.dataList tbody tr td:not(:has(*))').live('click', function(){
    showDetailDialog($(this).parent().find('a.showLink').attr('href'));
  });
  $('#sprints table.dataList tbody tr td:not(:has(*))').live('click', function(){
    window.location = $(this).parent().find('a.showLink').attr('href');
  });
});

