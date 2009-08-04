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

function addAjaxToDestroyForm() {
  $('form.deleteLink').ajaxForm({target:'#inner-content', success: addAjaxToForm});
}

function addAjaxToDataTable() {
  $('table#dataList tbody tr').live('click', function(){
    $('#inner-content').spin()
      .load($(this)
      .find('a.editLink')
      .attr('href'), null, addAjaxToForm);
      return false;
  });

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

