$(document).ready(function() {
    showEstimativeSlider();
});

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

