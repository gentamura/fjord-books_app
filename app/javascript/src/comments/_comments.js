document.addEventListener('turbolinks:load', () => {
  // Text data
  var commentTextData = document.querySelector('#commentTextData');

  if (commentTextData) {
    var { updateText, editText, contentText } = JSON.parse(commentTextData.textContent);

    // Common input element
    var inputEl = document.createElement('input');

    // CSRF Token
    var csrfToken = document.querySelector('meta[name="csrf-token"]').content;

    var editEls = document.querySelectorAll('.js-comment-edit');

    editEls.forEach((editEl) => {
      editEl.addEventListener('click', (e) => {
        e.preventDefault();

        var editEl = e.currentTarget;
        var { commentId, polymorphicId } = editEl.dataset;
        var commentEl = document.querySelector(`.js-editable-comment-${commentId}`);

        if ('editing' in editEl.dataset) {
          var comment = { content: inputEl.value };
          var body = editEl.dataset.polymorphicName === 'report'
            ? { comment, report_id: polymorphicId }
            : { comment, book_id: polymorphicId };

          fetch(`/comments/${commentId}`, {
            method: 'PATCH',
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': csrfToken,
            },
            body: JSON.stringify(body),
          })
            .then(res => res.json())
            .then(data => {
              if (data.status_code === 200) {
                commentEl.children = null;
                commentEl.innerText = data.comment.content;
                editEl.innerText = editText;
                delete editEl.dataset.editing;
              } else {
                data.errors.content.forEach((msg) => {
                  alert(`${contentText}${msg}`);
                });
              }
            });
        } else {
          inputEl.value = commentEl.innerText;

          commentEl.innerText = '';
          commentEl.appendChild(inputEl);
          editEl.dataset.editing = null;
          editEl.innerText = updateText;
        }
      });
    });
  }
});
