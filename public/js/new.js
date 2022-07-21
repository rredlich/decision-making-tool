$(document).ready(function() {
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

    // Add input after hit enter when writing on input
    $("#add-task-input").keyup(function(event) {
        if (event.keyCode === 13) {
            $("#add-task-btn").click();
        }
    });
});