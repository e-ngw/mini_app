// Stimulusアプリ本体の生成＆コントローラ登録
import { Application } from "@hotwired/stimulus"
import { Autocomplete } from "stimulus-autocomplete" // 追加

const application = Application.start()
application.register("autocomplete", Autocomplete) // 追加

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
