import { Controller } from "@hotwired/stimulus";

export class ImagePreviewController extends Controller {
  static targets = [
    "fileInput",
    "previewArea",
    "previewItemTemplate",
    "clearButtonTemplate",
  ];

  onChange(e) {
    this.previewAreaTarget.innerHTML = "";

    const files = Array.from(e.target.files);

    const fileMetadata = files.map((x) => {
      return {
        url: URL.createObjectURL(x),
        name: x.name,
        size: x.size,
        type: x.type,
      };
    });

    fileMetadata.forEach((x) => {
      this.#renderPreview(x);
    });

    const clearButtonEl =
      this.clearButtonTemplateTarget.content.cloneNode(true);
    this.previewAreaTarget.appendChild(clearButtonEl);
  }

  onClear() {
    this.fileInputTarget.value = '';
    this.previewAreaTarget.innerHTML = '';
  }

  #renderPreview(metadata) {
    const { url, name, size, type } = metadata;
    const previewItemEl =
      this.previewItemTemplateTarget.content.cloneNode(true);

    const imgEl = previewItemEl.querySelector("[x-data='img']");
    const nameEl = previewItemEl.querySelector("[x-data='name']");
    const sizeEl = previewItemEl.querySelector("[x-data='size']");
    const typeEl = previewItemEl.querySelector("[x-data='type']");
    imgEl.src = url;
    nameEl.textContent = name;
    sizeEl.textContent = this.#formatFileSize(size);
    typeEl.textContent = type;

    this.previewAreaTarget.appendChild(previewItemEl);
  }

  #formatFileSize(bytes) {
    if (bytes < 1024) return bytes + " B";
    else if (bytes < 1048576) return (bytes / 1024).toFixed(1) + " KB";
    else return (bytes / 1048576).toFixed(1) + " MB";
  }
}
