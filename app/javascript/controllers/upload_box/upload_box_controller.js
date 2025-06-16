import { Controller } from "@hotwired/stimulus";

export class UploadBoxController extends Controller {
  static targets = ["fileInput", "previewArea", "previewItemTemplate"];

  connect() {
    // if (this.isMultipleValue)
    // this.isMultipleValue = false;
  }

  onChange(e) {
    this.previewAreaTarget.innerHTML = '';

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
  }

  #renderPreview(metadata) {
    const { url, name, size } = metadata;
    const previewItemEl =
      this.previewItemTemplateTarget.content.cloneNode(true);

    const imgEl = previewItemEl.querySelector("[x-data='img']");
    const nameEl = previewItemEl.querySelector("[x-data='name']");
    const sizeEl = previewItemEl.querySelector("[x-data='size']");
    imgEl.src = url;
    nameEl.textContent = name;
    sizeEl.textContent = size;

    this.previewAreaTarget.appendChild(previewItemEl);
  }
}
