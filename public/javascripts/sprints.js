$(document).ready(function() {
  formSpecifics();
});

function formSpecifics() {
  $('#sprint_start').datepicker({ dateFormat: 'yy-mm-dd' });
  $('#sprint_end').datepicker({ dateFormat: 'yy-mm-dd' });
}

