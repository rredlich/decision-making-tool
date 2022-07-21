$(document).ready(function() {
    // Redirect based on input hash
    $("#setting-redirect-btn").on("click", function() {
        hash = $("#setting-redirect-input").val()
        if (hash != "") {
            window.location.replace("/decisions/"+hash);
        }
    });
});