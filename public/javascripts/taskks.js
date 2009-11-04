var estimativeInput, estimativeSlider, estimativeSliderControl;

$(document).ready(function() {
  showEstimativeSlider();

  estimativeInput.attr('tabindex', '');
  estimativeSliderControl.attr('tabindex', '5');
});

function showEstimativeSlider() {
  estimativeInput = $('input#taskk_estimative');
  estimativeInput.attr("readonly","readonly").after('<br/><span class="slider clearfix" id="estimative-slider"></span>');
  estimativeSlider = $('span#estimative-slider');
  estimativeSlider.slider({min:0, max:100, value:estimativeInput.val(), slide:function(e,ui){estimativeInput.val(ui.value)}});
  estimativeSliderControl = estimativeSlider.children('a');
}

