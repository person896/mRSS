$(document).on('click', 'tbody tr', function() {
  var data = $(this).data('open-url');
  if (data && data.trim().length) {
    window.location.href = data;
  }
});
