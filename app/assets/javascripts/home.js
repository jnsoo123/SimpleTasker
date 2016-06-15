$(document).on("ready page:change", function() {
  $('[data-toggle="tooltip"]').tooltip()
  
//  $('.alert_area').hide();
  
//  setTimeout((function() {
//    $('.alert').hide('blind', {}, 50);
//  }), 3000);
  
  
  $('.datetimepicker').datetimepicker({format:'DD/MM/Y h:mm A'});
  
  $('.edit-reminder-div').blur(function(){
    var content = "";
    $(this).find('div.html-content').each(function(){
      content += $(this).html().replace(/(\n)/g,"<br>") + "<br>";
    });
    content = content.split('<br>').slice(0,-1).join('<br>');
    var id = $(this).data('id');
    update_reminder(id, content);
  });  
  
  
  $.ajax({url: "/users/get_users", success: function(result){
    $('textarea').atwho({
      at: '@', 
      displayTpl: "<li>@${username} <span style='font-weight: bold;'>${name}</span></li>",
      insertTpl: "${atwho-at}${username}",
      data: result
    });
  }});
  
  
  
  
  //----------FUNCTIONS-------------
  
  
  
  
  
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


