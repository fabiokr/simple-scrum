var todoCol, doingCol, doneCol;

$(document).ready(function() {
  prepareBacklog();
  prepareDragNDrop();
});

function prepareBacklog() {
  $('.postit').addClass('clickable').live('click', function(){
    showDetailDialog($(this).attr('ticket_show_url'));
  });

  $('#burndown-chart h4').click(function(){
    $(this).next().toggle();
  });
}

function prepareDragNDrop() {
  todoCol = $('.todo'), doingCol = $('.doing'), doneCol = $('.done');

  $('.postit').draggable({
		cancel: 'img',
		revert: 'invalid',
		helper: 'clone',
		cursor: 'move'
	});

	todoCol.droppable({
		accept: '.postit',
		activeClass: 'state-highlight',
		drop: function(ev, ui) {
		  changeStatus(ui.draggable, todoCol.attr('status'));
		}
	});

	doingCol.droppable({
		accept: '.postit',
		activeClass: 'state-highlight',
		drop: function(ev, ui) {
		  changeStatus(ui.draggable, doingCol.attr('status'));
		}
	});

	doneCol.droppable({
		accept: '.postit',
		activeClass: 'state-highlight',
		drop: function(ev, ui) {
		  changeStatus(ui.draggable, doneCol.attr('status'));
		}
	});
}

function changeStatus(ticket, status) {
  if(status != ticket.attr('ticket_status')) {
    ticket.fadeOut(function() {
      content.spin();
      $.post(
        ticket.attr('ticket_show_url'),
        {'authenticity_token': AUTH_TOKEN, '_method': 'put', 'ticket[status]': status},
        function(data){
          content.load(window.location.pathname, function(){content.unspin();prepareDragNDrop();});
        }
      );
    });
  }
}

