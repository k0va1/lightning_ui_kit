import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage"

class Upload {
  constructor(file, controller) {
    this.controller = controller
    this.file = file;
    this.directUpload = new DirectUpload(file, this.controller.inputTarget.dataset.directUploadUrl, this);
  }

  process() {
    this.insertUpload();

    this.directUpload.create((error, blob) => {
      if (error) {
        const fileContainer = this.controller.filesTarget.querySelector(`#upload_${this.directUpload.id}`)
        const status = fileContainer.querySelector("[data-lui-dropzone-target='status']")
        status.textContent = "Failed. " + error
        status.classList.add("text-red-500")
      } else {
        const hiddenField = document.createElement('input')
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("value", blob.signed_id);
        hiddenField.name = this.controller.inputTarget.name
        this.controller.filesTarget.querySelector(`#upload_${this.directUpload.id}`).appendChild(hiddenField)
      }
    });
  }

  insertUpload() {
    const template = this.controller.templateTarget.content.cloneNode(true)
    template.querySelector('#\\#NEW_FILE').id = `upload_${this.directUpload.id}`
    template.querySelector("[data-lui-dropzone-target='filename']").textContent = this.file.name
    template.querySelector("[data-lui-dropzone-target='status']").textContent = "Uploading..."

    this.controller.filesTarget.appendChild(template)
  }

  directUploadWillStoreFileWithXHR(request) {
    request.upload.addEventListener("progress", (event) => this.updateProgress(event));
  }

  updateProgress(event) {
    const progress = ((event.loaded / event.total) * 100).toFixed(0)
    const status = progress == 100 ? "Uploaded" : "Uploading..."

    const fileContainer = this.controller.filesTarget.querySelector(`#upload_${this.directUpload.id}`)
    fileContainer.querySelector("[data-lui-dropzone-target='status']").textContent = status
    fileContainer.querySelector("[data-lui-dropzone-target='progressbar']").style.width = `${progress}%`
    fileContainer.querySelector("[data-lui-dropzone-target='percentage-progress']").textContent = `${progress}%`
  }
}

export default class extends Controller {
  static targets = ["input", "template", "files"]

  selectFiles(_event) {
    this.inputTarget.click()
  }

  uploadFiles(event) {
    event.preventDefault();
    const files = event.dataTransfer ? event.dataTransfer.files : event.target.files;
    [...files].forEach(f => new Upload(f, this).process())
  }

  activate(event) {
    event.preventDefault()
  }

  removeFile(event) {
    event.preventDefault()
    const container = event.target.closest("[data-lui-dropzone-target='file']")
    container.remove()
  }
}
