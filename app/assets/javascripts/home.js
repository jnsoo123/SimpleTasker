$(document).on("ready page:change", function() {
  $('[data-toggle="tooltip"]').tooltip()
  
  setTimeout((function() {
    $('.alert').hide('blind', {}, 50);
  }), 3000);
  
  $('.datetimepicker').datetimepicker({format:'DD/MM/Y h:mm A'});
});