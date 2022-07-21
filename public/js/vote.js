$(document).ready(function() {
    // Filters to a maximum number of checkbox on a vote
    var maxCheck = parseInt($("#decision-vote-limit").text())

    $(".form-check-input").on('click',function() {
        checked = $(".form-check-input:checked").length
        if (checked >= maxCheck+1){
            return false
        }
    });
});