$(document).ready(function() {
    prepareAjax({showLinkCallback: function(){
        window.location = $(this).parent().find('a.showLink').attr('href');
    }});
});

