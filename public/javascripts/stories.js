$(document).ready(function() {
    formSpecifics();
});

function formSpecifics() {
  showPrioritySlider();
  showEstimativeSlider();
  $("input#story_color").attachColorPicker();
}

function showPrioritySlider() {
    $('input#story_priority')
        .attr("readonly","readonly")
        .attr('tabindex', '')
        .after('<br/><span class="slider clearfix" id="priority-slider"></span>');
    $('span#priority-slider')
        .slider({min:0, max:100, value:$('input#story_priority').val(), slide:function(e,ui){$('input#story_priority').val(ui.value)}})
        .children('a')
        .attr('tabindex', '2');
}

function showEstimativeSlider() {
    $('input#story_estimative')
        .attr("readonly","readonly")
        .attr('tabindex', '')
        .after('<br/><span class="slider clearfix" id="estimative-slider"></span>');
    $('span#estimative-slider')
        .slider({min:0, max:100, value:$('input#story_estimative').val(), slide:function(e,ui){$('input#story_estimative').val(ui.value)}})
        .children('a')
        .attr('tabindex', '3');
}

