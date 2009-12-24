$(document).ready(function() {
    formSpecifics();
});

function formSpecifics() {
  showPrioritySlider();
  showEstimativeSlider();
}

function showPrioritySlider() {
    $('input#ticket_priority')
        .attr("readonly","readonly")
        .attr('tabindex', '')
        .after('<br/><span class="slider clearfix" id="priority-slider"></span>');
    $('span#priority-slider')
        .slider({min:0, max:100, value:$('input#ticket_priority').val(), slide:function(e,ui){$('input#ticket_priority').val(ui.value)}})
        .children('a')
        .attr('tabindex', '5');
}

function showEstimativeSlider() {
    $('input#ticket_estimative')
        .attr("readonly","readonly")
        .attr('tabindex', '')
        .after('<br/><span class="slider clearfix" id="estimative-slider"></span>');
    $('span#estimative-slider')
        .slider({min:0, max:100, value:$('input#ticket_estimative').val(), slide:function(e,ui){$('input#ticket_estimative').val(ui.value)}})
        .children('a')
        .attr('tabindex', '6');
}

