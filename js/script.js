document.addEventListener('DOMContentLoaded', () => {
    const modal = document.getElementById('modal');
    const newTopicBtn = document.getElementById('newTopicBtn');
    const closeBtn = document.querySelector('.close');
    const postTopicBtn = document.getElementById('postTopicBtn');
    const topicsDiv = document.getElementById('topics');
    const topicTitleInput = document.getElementById('topicTitle');
    const topicContentInput = document.getElementById('topicContent');

    newTopicBtn.addEventListener('click', () => {
        modal.style.display = 'flex';
    });

    closeBtn.addEventListener('click', () => {
        modal.style.display = 'none';
    });

    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });

    postTopicBtn.addEventListener('click', () => {
        const title = topicTitleInput.value.trim();
        const content = topicContentInput.value.trim();
        const userName = "T001"; // You need to set this value dynamically

        if (title && content && userName) {
            console.log('Before fetch:', title, content, userName);
            fetch('../EASYMATH/index.aspx/AddTopic', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ title: title, content: content, userName: userName })
            })

                .then(response => {
                    console.log('Server response:', response); // Log the entire response
                    return response.json(); // Parse the JSON data
                })

                .then(result => {
                    console.log('Server response:', result); // Log the parsed data
                    if (result.d == "Success") {
                        console.log("Topic posted successfully.");
                        window.location.reload();
                    } else {
                        alert(result.d || 'Unexpected response format');
                    }
                })

        } else {
            alert('Please fill in both the title and content.');
        }
    });
});