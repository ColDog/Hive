$ ->
  $.ajax({
    url: "/admin/supplies/list_form.html",
    method: 'get'
    dataType: 'html'
    success: (data) ->
      $(".addForm").each( (i, obj) ->
        $(obj).html(data)
      )
  });
