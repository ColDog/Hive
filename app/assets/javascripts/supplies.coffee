$ ->
  $.get("/admin/supplies/list_form.html", (data) ->
    $(".addForm").each( (i, obj) ->
      $(obj).html(data)
    )
  )

  $("a[data-background-color]")

#  $("#pop<%= list_id %>").popover({
#    html: true,
#    content: function () {
#  return $("#form<%= list_id %>").html();
#  }
#});