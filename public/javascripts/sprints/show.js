$(document).ready(function() {
  prepareAjax({formCallback: showEstimativeSlider, lastBreadcrumbCallback: prepareBacklog});
  prepareBacklog();
  $('table#kanban tbody tr td div.name').live('click', defaultShowLinkBehaviour);
});

function prepareBacklog() {
    $('#newTaskForm').validationEngine({
        success: function(){
            form = $('#newTaskForm');
            content.spin();
            $.get(form.attr('action'), form.serialize(), function(data){
                content.html(data);
                prepareForm();
                content.unspin();
            });
        }
    });
}

function showEstimativeSlider() {
  $('input#taskk_estimative')
    .attr('tabindex', '')
    .attr("readonly","readonly")
    .after('<br/><span class="slider clearfix" id="estimative-slider"></span>');
  $('span#estimative-slider')
    .slider({min:0, max:100, value:$('input#taskk_estimative').val(), slide:function(e,ui){$('input#taskk_estimative').val(ui.value)}})
    .children('a')
    .attr('tabindex', '5');
}

