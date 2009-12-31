$(document).ready(function() {
  $('.dataList tbody tr td:not(:has(*))').addClass('clickable').live('click', function(){
    window.location = $(this).parent().find('a.showLink').attr('href');
  });
});

