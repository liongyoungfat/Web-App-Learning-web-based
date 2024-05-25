function uploadFile(input) {
    var file = input.files[0];
    if (file) {
        var reader = new FileReader();
        console.log("reader works: ", reader);
        reader.onload = function (e) {
            var row = input.closest('tr');  // Find the closest parent row
            console.log("row works: ", row);
            console.log("Row HTML: ", row.innerHTML);  // Log the entire row's HTML

            if (row) {
                // Find the hidden fields within the row
                var hiddenField = row.querySelector('input[id*="hiddenCommentImage"]');
                var hiddenFileNameField = row.querySelector('input[id*="hiddenFileName"]');
                console.log("Hidden field found: ", hiddenField);  // Log the hidden field
                console.log("Hidden file name field found: ", hiddenFileNameField);  // Log the hidden file name field

                if (hiddenField && hiddenFileNameField) {
                    hiddenField.value = e.target.result;  // Update hidden field with file data
                    hiddenFileNameField.value = file.name;  // Update hidden field with file name
                    console.log("Hidden field value set: " + hiddenField.value);
                    console.log("Hidden file name field value set: " + hiddenFileNameField.value);

                    // Use setTimeout to ensure the value is set before triggering the click
                    setTimeout(function () {
                        var hiddenButton = document.getElementById('<%= hiddenButton.ClientID %>');
                        console.log("Hidden button: ", hiddenButton);  // Log the hidden button
                        if (hiddenButton) {
                            hiddenButton.click();  // Click the hidden button
                            console.log("Hidden button clicked");
                        } else {
                            console.log("Hidden button not found");
                        }
                    }, 100);
                } else {
                    console.log("Hidden field or file name field not found");
                }
            } else {
                console.log("Row not found");
            }
        };
        reader.readAsDataURL(file);  // Read the file as a data URL
    }
}