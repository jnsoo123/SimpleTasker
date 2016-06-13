$(document).on("ready page:change", function() {
  $('[data-toggle="tooltip"]').tooltip()
  
  setTimeout((function() {
    $('.alert').hide('blind', {}, 50);
  }), 3000);
  
  
  $('.datetimepicker').datetimepicker({format:'DD/MM/Y h:mm A'});
  
  
  
});

$(document).ready(function(){
  
  var content = "";
  
  $('.edit-reminder-div').click(function(){
    content = $(this).find('div.html-content').html();
  });
  
  $('.edit-reminder-div').blur(function(){
    var id = $(this).data('id');
    var changed_content = $(this).find('div.html-content').html().replace(/(\n)+/g,"<br>");
    update_reminder(id, changed_content);
  });  
  
  function update_reminder(id, content) {
    var data = { id: id, title: content };
    $.ajax({
      type: 'PUT',
      url: '/reminders/' + id,
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      data: JSON.stringify(data)
    });
  }

});