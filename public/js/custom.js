// Copy text from input to clipboard
function copyToClipboard(selector){
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val($(selector).val()).select();
    document.execCommand("copy");
    console.log($temp.val)
    $temp.remove();
}

$(document).ready(function() {
    // Copy to clipboard action
    $("#button-decision-url").on("click", function() {
        copyToClipboard($("#decision-url"));
    });
    $("#button-decision-hash").on("click", function() {
        copyToClipboard($("#decision-hash"));
    });

    // Filters to a maximum number of checkbox on a vote
    var maxCheck = 3

    $(".form-check-input").on('click',function() {
        console.log('in')
        checked = $(".form-check-input:checked").length
        if (checked >= maxCheck+1){
            return false
        }
    });

    // Adds and remove input field for new vote page
    var idTaskCnt = 1

    $("#add-task-btn").click(function() {
        if ($("#add-task-input").val() != "") {
            $("form").prepend('<div class="input-group mb-3"><input class="form-control" id="'+ idTaskCnt +'" name="'+ idTaskCnt +'"><button class="btn btn-outline-secondary input-remove" type="button"><i class="bi bi-x"></i></button></div>')
            $("#"+idTaskCnt).val($("#add-task-input").val())
            $("#add-task-input").val("")
            idTaskCnt++
        }
    });
    $('form').on('click','.input-remove',function() {
        $(this).parent('div.input-group').remove()
    });
});