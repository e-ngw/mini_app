document.addEventListener("DOMContentLoaded", function () {
  const input = document.getElementById("post_image_input");
  const preview = document.getElementById("image_preview");

  if (!input) return;

  input.addEventListener("change", function () {
    const file = this.files[0];
    if (file) {
      const reader = new FileReader();

      reader.onload = function (e) {
        preview.src = e.target.result;
        preview.style.display = "block";
      };

      reader.readAsDataURL(file);
    } else {
      preview.src = "";
      preview.style.display = "none";
    }
  });
});
