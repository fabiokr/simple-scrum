$(document).ready(function() {
  //addAlertOnDestroy();

  //Test only
  $("body").addGrid({img_path: '/images/',margin:"1.5em auto"});
});

/*function addAlertOnDestroy() {
  $('form.deleteLink').click(function(){
    if(confirm('Are you sure?')) {
      $(this).trigger('submit');
    }
    return false;
  });
}*/

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
      .load($(this)
      .attr('href'), null, addAjaxToForm);
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

