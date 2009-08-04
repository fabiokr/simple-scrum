$(document).ready(function() {
  $('table#dataList tbody tr').live('click', function(){
     window.location = $(this).find('a.showLink').attr('href');
  });
});

