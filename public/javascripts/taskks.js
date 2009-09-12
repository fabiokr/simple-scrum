$(document).ready(function() {
  showEstimativeSlider();
});

var estimativeInput, estimativeSlider;

function showEstimativeSlider() {
  estimativeInput = $('input#taskk_estimative');
  estimativeInput.addClass('notEditable').after('<br/><span class="slider clearfix" id="estimative-slider"></span>');
  estimativeSlider = $('span#estimative-slider');
  estimativeSlider.slider({min:0, max:100, value:estimativeInput.val(), slide:function(e,ui){estimativeInput.val(ui.value)}});
}

