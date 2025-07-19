// app/javascript/controllers/image_preview_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["preview"]

  preview(event) {
    const input = event.target
    if (input.files && input.files[0]) {
      const reader = new FileReader()

      reader.onload = (e) => {
        this.previewTarget.src = e.target.result
        this.previewTarget.classList.remove("d-none")
      }

      reader.readAsDataURL(input.files[0])
    } else {
      // ファイルが選択されていなければプレビュー非表示
      this.previewTarget.src = ""
      this.previewTarget.classList.add("d-none")
    }
  }
}
