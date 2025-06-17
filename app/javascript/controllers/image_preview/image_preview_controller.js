import { Controller } from "@hotwired/stimulus";

export class ImagePreviewController extends Controller {
  static targets = [
    "fileInput",
    "label",
    "previewArea",
    "previewItemTemplate",
    "clearButtonTemplate",
  ];

  // 파일 변경 이벤트 핸들러
  onChange(e) {
    const files = Array.from(e.target.files);
    this.handleFiles(files);
  }

  // 초기화 메서드
  onClear() {
    this.fileInputTarget.value = '';
    this.previewAreaTarget.innerHTML = '';
    this.labelTarget.classList.remove("border-primary");
  }

  // 공통 파일 처리 로직을 분리하여 재사용성 향상
  handleFiles(files) {
    // 미리보기 영역 초기화
    this.previewAreaTarget.innerHTML = "";

    if (files.length === 0) return;

    // 파일 메타데이터 생성
    const fileMetadata = files.map((file) => ({
      url: URL.createObjectURL(file),
      name: file.name,
      size: file.size,
      type: file.type
    }));

    // 각 파일 미리보기 생성
    fileMetadata.forEach(metadata => {
      this.renderPreview(metadata);
    });

    // 초기화 버튼 추가
    this.appendClearButton();
  }

  // 미리보기 렌더링
  renderPreview(metadata) {
    this.labelTarget.classList.add("border-primary");

    const { url, name, size, type } = metadata;
    const previewItemEl = this.previewItemTemplateTarget.content.cloneNode(true);

    const imgEl = previewItemEl.querySelector("[x-data='img']");
    const nameEl = previewItemEl.querySelector("[x-data='name']");
    const sizeEl = previewItemEl.querySelector("[x-data='size']");
    const typeEl = previewItemEl.querySelector("[x-data='type']");
    
    imgEl.src = url;
    nameEl.textContent = name;
    sizeEl.textContent = this.formatFileSize(size);
    typeEl.textContent = type;

    this.previewAreaTarget.appendChild(previewItemEl);
  }

  // 초기화 버튼 추가
  appendClearButton() {
    const clearButtonEl = this.clearButtonTemplateTarget.content.cloneNode(true);
    this.previewAreaTarget.appendChild(clearButtonEl);
  }

  // 파일 크기 포맷팅 (private 메서드 -> protected 메서드로 변경하여 자식 클래스에서 접근 가능)
  formatFileSize(bytes) {
    if (bytes < 1024) return bytes + " B";
    else if (bytes < 1048576) return (bytes / 1024).toFixed(1) + " KB";
    else return (bytes / 1048576).toFixed(1) + " MB";
  }
}
