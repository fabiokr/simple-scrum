var tickets, sprint;

$(document).ready(function() {
  prepareDragNDrop();

  $('table.dataList tbody tr td:not(:has(*))').addClass('clickable').live('click', function(){
    showDetailDialog($(this).parent().attr('ticket_path'));
  });

  $('table.dataList caption', sprint).addClass('clickable').live('click', function(){
    window.location = $(this).attr('sprint_path');
  });
});

function prepareDragNDrop() {
  tickets = $('#tickets'), sprint = $('#sprint');

	$('tr', tickets).draggable({
		cancel: 'img',
		revert: 'invalid',
		helper: 'clone',
		cursor: 'move'
	});

	$('tr', sprint).draggable({
		cancel: 'img',
		revert: 'invalid',
		helper: 'clone',
		cursor: 'move'
	});

	sprint.droppable({
		accept: '#tickets tr',
		activeClass: 'state-highlight',
		drop: function(ev, ui) {
			addTicketToSprint(ui.draggable);
		}
	});

	tickets.droppable({
		accept: '#sprint tr',
		activeClass: 'state-highlight',
		drop: function(ev, ui) {
			removeSprintFromTicket(ui.draggable);
		}
	});
}

function addTicketToSprint(ticketRow) {
  sprint_id = sprint.find('caption').attr('sprint_id');
  if(sprint_id) {
    ticketRow.fadeOut(function() {
      content.spin();
      $.post(
        ticketRow.attr('ticket_path'),
        {'authenticity_token': AUTH_TOKEN, '_method': 'put', 'ticket[sprint_id]': sprint_id},
        function(data){
          content.load(window.location.pathname, function(){content.unspin();prepareDragNDrop();});
        }
      );
    });
  }
}

function removeSprintFromTicket(ticketRow) {
  ticketRow.fadeOut(function() {
    content.spin();
    $.post(
      ticketRow.attr('ticket_path'),
      {'authenticity_token': AUTH_TOKEN, '_method': 'put', 'ticket[sprint_id]': ''},
      function(data){
        content.load(window.location.pathname, function(){content.unspin();prepareDragNDrop();});
      }
    );
  });
}

