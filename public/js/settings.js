$(document).ready(function() {
    // Copy to clipboard action
    $("#button-decision-url").on("click", function() {
        copyToClipboard($("#decision-url"));
    });
    $("#button-decision-hash").on("click", function() {
        copyToClipboard($("#decision-hash"));
    });
});