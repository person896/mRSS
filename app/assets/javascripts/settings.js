
// custom css expression for a case-insensitive contains()
jQuery.expr[':'].Contains = function(a, i, m) {
    return (a.textContent || a.innerText || "").toUpperCase().indexOf(m[3].toUpperCase()) >= 0;
};
var named_function = function(){
    $.getScript('/fetch/load_script.js')
    console.log("It works on each visit!")
};
$(document).on('turbolinks:before-cache', function(e) {
    $('.select2').remove();
    $('#ui-datepicker-div').remove();
});

$( document ).on('turbolinks:load', named_function);