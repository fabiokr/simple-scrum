$(document).ready(function() {
  prepareBacklog();
});

function prepareBacklog() {
  $('form.changeState').submit(function(e){
    var form = $(e.target);
    content.spin();
    $.post(form.attr('action'), form.serialize(), function(data){
      content.load(location.href, function(){
        prepareBacklog();
        content.unspin();
      });
    });
    return false;
  });
  $('table#kanban tbody tr td div.name').live('click', function(){
    showDetailDialog($(this).parent().find('a.showLink').attr('href'))
  });
}

