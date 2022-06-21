$(document).ready(function() {
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
            $("form").prepend('<div class="input-group mb-3"><input class="form-control" id="'+ idTaskCnt +'" name="'+ idTaskCnt +'"><button class="btn btn-outline-secondary input-remove" type="button">x</button></div>')
            $("#"+idTaskCnt).val($("#add-task-input").val())
            $("#add-task-input").val("")
            idTaskCnt++
        }
    });
    $('form').on('click','.input-remove',function() {
        $(this).parent('div.input-group').remove()
    });
});