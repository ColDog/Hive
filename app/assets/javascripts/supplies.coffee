$ ->
  $.get("/admin/supplies/list_form.html", (data) ->
    $(".addForm").each( (i, obj) ->
      $(obj).html(data)
    )
  )
