$(document).ready(function() {
  replaceDestroyForms();

  //Test only
  $("body").addGrid({img_path: '/images/',margin:"1.5em auto"});
});

function replaceDestroyForms() {
  $('form.deleteLink').toggleClass('hide');
  $('a.deleteLink').toggleClass('hide').live('click', function() {
    if(confirm(i18n.confirm_destroy)) {
      $('#inner-content').spin();
      $(this).prev('form').ajaxSubmit({target:'#inner-content', success: function(){
        $('form.deleteLink').toggleClass('hide');
        $('a.deleteLink').toggleClass('hide')
        $.Spinner.unspin();
      }});
    }
    return false;
  });
}

function addAjaxToPagination() {
  $('div.pagination a').live('click', function(){
    $('#inner-content').spin()
      .load($(this)
      .attr('href'), null, function(){
        $.Spinner.unspin();
      })
    return false;
  });
}

function addAjaxToForm() {
  $('div#inner-content form.dataForm').ajaxForm({target:'#inner-content', success: addAjaxToForm});
  $.Spinner.unspin();
}

function addAjaxToDataTable() {
  $('table#dataList tbody tr td a').live('click', function(){
    $('#inner-content').spin()
      .load($(this).attr('href'), null, addAjaxToForm);
      return false;
  });
  $('table#dataList tbody tr').live('click', function(){
    $('#inner-content').spin()
      .load($(this).find('a.showLink').attr('href'), null, addAjaxToForm);
      return false;
  });
}

function addAjaxToNewButton() {
  $('a.newLink').live('click', function(){
    $('#inner-content').spin()
      .load($(this)
      .attr('href'), null, addAjaxToForm);
    return false;
  });
}

