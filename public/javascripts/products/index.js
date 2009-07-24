Event.addBehavior({
  'table tbody tr:click' : function() {
    window.location = Routes.productPath(this.readAttribute('id'));
  }
});

