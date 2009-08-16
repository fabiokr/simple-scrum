$(document).ready(function() {

  //destroy link event
  $('form.deleteLink').hide();
  $('a.deleteLink').show().live('click', function() {
    if(confirm(i18n.confirm_destroy)) {
      $(this).prev('form').trigger('submit');
    }
    return false;
  });

  //row event
  $('table#dataList tbody tr').live('click', function(){
     window.location = $(this).find('a.showLink').attr('href');
  });
});

