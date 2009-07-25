$('a#new-button').click(function(){
  $.get($(this).attr('href'), function(data){
    $(data).dialog({
			bgiframe: true,
			width: 600,
			modal: true,
			draggable: false
		});
  });
  return false;
});

