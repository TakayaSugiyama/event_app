$(document).on('ajax:success', "#createTicket", function() {
  return location.reload();
});

$(document).on('ajax:error', "#createTicket",function(e){
  let form = $('.modal-body')
  let div = $('<div class = "alert alert-danger"></div>')
  let ul = $('<ul></ul>')
  ul.append("<li>" + e.detail[0].messages[0] +"</li>")
  div.append(ul)
  form.prepend(div)
})


