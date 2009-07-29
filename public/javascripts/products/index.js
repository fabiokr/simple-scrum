$(document).ready(function() {
  $('table.dataList tbody tr').click(function() {
     window.location = $(this).find('a.showLink').attr('href');
  });
});

