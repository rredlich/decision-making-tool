// Copy text from input to clipboard
function copyToClipboard(selector){
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val($(selector).val()).select();
    document.execCommand("copy");
    $temp.remove();
}