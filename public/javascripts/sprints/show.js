$(document).ready(function() {
  prepareBacklog();
});

function prepareBacklog() {
  $('.postit').live('click', function(){
    showDetailDialog($(this).attr('ticket_show_url'));
  });
}

