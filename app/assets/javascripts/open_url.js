$(document).on('click', 'tbody tr td:not(:first)', function() {
  var data = $(this).parent('tr').data('open-url');
  if (data && data.trim().length) {
    window.location.href = data;
  }
});
