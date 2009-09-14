$(document).ready(function() {
  showPrioritySlider();
  showEstimativeSlider();
});

var estimativeInput, estimativeSlider, priorityInput, prioritySlider;

function showPrioritySlider() {
  priorityInput = $('input#story_priority');
  priorityInput.attr("readonly","readonly").after('<br/><span class="slider clearfix" id="priority-slider"></span>');
  prioritySlider = $('span#priority-slider');
  prioritySlider.slider({min:0, max:100, value:priorityInput.val(), slide:function(e,ui){priorityInput.val(ui.value)}});
}

function showEstimativeSlider() {
  estimativeInput = $('input#story_estimative');
  estimativeInput.attr("readonly","readonly").after('<br/><span class="slider clearfix" id="estimative-slider"></span>');
  estimativeSlider = $('span#estimative-slider');
  estimativeSlider.slider({min:0, max:100, value:estimativeInput.val(), slide:function(e,ui){estimativeInput.val(ui.value)}});
}

