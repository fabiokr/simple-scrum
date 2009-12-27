var tickets, sprint;

$(document).ready(function() {
  prepareDragNDrop();

  $('table.dataList tbody tr td:not(:has(*))').live('click', function(){
    showDetailDialog($(this).parent().find('a.showLink').attr('href'));
  });

  $('table.dataList caption', sprint).live('click', function(){
    window.location = $(this).parent().find('a.showLink').attr('href');
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
  ticketRow.fadeOut(function() {
    content.spin();
    $.post(
      $('a.showLink', ticketRow).attr('href'),
      {'authenticity_token': AUTH_TOKEN, '_method': 'put', 'ticket[sprint_id]': sprint.attr('sprint_id')},
      function(data){
        content.load(window.location.pathname, function(){content.unspin();prepareDragNDrop();});
      }
    );
  });
}

function removeSprintFromTicket(ticketRow) {
  ticketRow.fadeOut(function() {
    content.spin();
    $.post(
      $('a.showLink', ticketRow).attr('href'),
      {'authenticity_token': AUTH_TOKEN, '_method': 'put', 'ticket[sprint_id]': ''},
      function(data){
        content.load(window.location.pathname, function(){content.unspin();prepareDragNDrop();});
      }
    );
  });
}

