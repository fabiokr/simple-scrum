$(document).ready(function() {
    prepareAjax({
        formCallback: formSpecifics,
        showLinkCallback: function(){window.location = $(this).parent().find('a.showLink').attr('href');}
    });
});

function formSpecifics() {
  $('#sprint_start').datepicker();
  $('#sprint_end').datepicker();
}

