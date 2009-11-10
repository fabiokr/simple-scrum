var content, message;

$(document).ready(function() {
    message = $('#message');
    content = $('#content');
    prepareList();
    prepareForm();
});

function prepareList() {
    $('a.newLink').live('click', function(e){
        content.spin();
        content.load($(this).attr('href'), function(){
            prepareForm();
            content.unspin();
        });
        return false;
    });
}

function prepareForm() {
  $('#content form').validationEngine({
      success: function(){
         form = $('#content form');
         content.spin();
         $.post(form.attr('action'), form.serialize(), null, "script");
      }
  });
}

