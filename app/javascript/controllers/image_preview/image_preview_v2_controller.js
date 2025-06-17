import { ImagePreviewController } from "./image_preview_controller";

export class ImagePreviewV2Controller extends ImagePreviewController {

  // 드래그 오버 이벤트
  onDragOver(e) {
    e.preventDefault();
    this.labelTarget.classList.add("border-primary");
  }

  // 드래그 리브 이벤트
  onDragLeave(e) {
    e.preventDefault();
    this.labelTarget.classList.remove("border-primary");
  }

  // 드롭 이벤트
  onDrop(e) {
    e.preventDefault();

    const files = Array.from(e.dataTransfer.files);

    // 파일 입력 요소에 파일 할당
    this.updateFileInput(files);

    // 부모 클래스의 파일 처리 메서드 활용
    this.handleFiles(files);
  }

  // 파일 입력 요소 업데이트
  updateFileInput(files) {
    const dataTransfer = new DataTransfer();

    files.forEach((file) => {
      dataTransfer.items.add(file);
    });

    this.fileInputTarget.files = dataTransfer.files;
  }
}
