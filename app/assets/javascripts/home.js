$(document).on("ready page:change", function() {
  $('[data-toggle="tooltip"]').tooltip()
  
  setTimeout((function() {
    $('.alert').hide('blind', {}, 50);
  }), 3000);
  
  
  $('.datetimepicker').datetimepicker({format:'DD/MM/Y h:mm A'});
  
  $('.edit-reminder-div').blur(function(){
    var content = "";
    $('div.html-content').each(function(){
      content += $(this).html().replace(/(\n)/g,"<br>") + "<br>";
//      alert(content);
    });
    content = content.split('<br>').slice(0,-1).join('<br>');
    var id = $(this).data('id');
//    var changed_content = $(this).find('div.html-content').html();
//    alert(changed_content);
    update_reminder(id, content);
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
//  alert(1);
  
});


