var estimativeInput, estimativeSlider, estimativeSliderControl, priorityInput, prioritySlider, prioritySliderControl, colorInput;

$(document).ready(function() {
  showPrioritySlider();
  showEstimativeSlider();

  colorInput = $('input#story_color');
  colorInput.ColorPicker({
    onChange: function (hsb, hex, rgb) {
		  colorInput.val(hex).css('color', '#'+hex);
	  }
  });

  estimativeInput.attr('tabindex', '');
  priorityInput.attr('tabindex', '');
  estimativeSliderControl.attr('tabindex', '3');
  prioritySliderControl.attr('tabindex', '2');
});

function showPrioritySlider() {
  priorityInput = $('input#story_priority');
  priorityInput.attr("readonly","readonly").after('<br/><span class="slider clearfix" id="priority-slider"></span>');
  prioritySlider = $('span#priority-slider');
  prioritySlider.slider({min:0, max:100, value:priorityInput.val(), slide:function(e,ui){priorityInput.val(ui.value)}});
  prioritySliderControl = prioritySlider.children('a');
}

function showEstimativeSlider() {
  estimativeInput = $('input#story_estimative');
  estimativeInput.attr("readonly","readonly").after('<br/><span class="slider clearfix" id="estimative-slider"></span>');
  estimativeSlider = $('span#estimative-slider');
  estimativeSlider.slider({min:0, max:100, value:estimativeInput.val(), slide:function(e,ui){estimativeInput.val(ui.value)}});
  estimativeSliderControl = estimativeSlider.children('a');
}

