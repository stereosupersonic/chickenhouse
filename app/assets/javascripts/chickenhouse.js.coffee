$ ->
  $(document).on "click", "a.form_submitter", (e) ->
    e.preventDefault()
    form = $(this).closest("form")
    btn = $(this)
    btn.button "loading"
    form.submit()


