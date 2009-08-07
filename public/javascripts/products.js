$(document).ready(function() {
  addQuestionToDestroyForms();
  addRedirectToDataTable();
  addValidationToForm();
});

function addValidationToForm() {
  $("[class^=validate]").validationEngine({
		success :  null,
		failure : function() {}
	})
}

function addRedirectToDataTable() {
  $('table#dataList tbody tr').live('click', function(){
     window.location = $(this).find('a.showLink').attr('href');
  });
}

