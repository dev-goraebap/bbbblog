import { Controller } from "@hotwired/stimulus";

export class ImageUploaderController extends Controller {
  static targets = [
    "addFileInput",
    "newImagesView",
    "newImageTemplate",
    "removeIdInputTemplate",
  ];

  connect() {
    console.log("이미지업로더 커넥션");
    this.element.addEventListener(
      "CUSTOM_FILE_CHANGE",
      this.onChange.bind(this)
    );
  }

  disconnect() {
    console.log("이미지업로더 커넥션 종료");
    this.element.removeEventListener(
      "CUSTOM_FILE_CHANGE",
      this.onChange.bind(this)
    );
  }

  // 인풋 change 이벤트, 또는 커스텀 파일변경 이벤트가 일어나면 작동됨
  onChange() {
    // 기존의 프리뷰영역 초기화
    this.newImagesViewTarget.innerHTML = "";

    // 변경된 Input 파일들의 메타데이터 추출
    const metadata = this.#getAddedFileMetadata();

    // 가져온 메타데이터만큼 아이템 그리기
    metadata.forEach((x) => {
      const { index, url, name, size, type } = x;
      const newImageEl = this.newImageTemplateTarget.content.cloneNode(true);
      newImageEl.querySelector("[x-data='img']").src = url;
      newImageEl.querySelector("[x-data='name']").textContent = name;
      newImageEl.querySelector("[x-data='size']").textContent = size;
      newImageEl.querySelector("[x-data='type']").textContent = type;
      newImageEl.querySelector("[x-data='removeBtn']").dataset.index = index;
      this.newImagesViewTarget.appendChild(newImageEl);
    });
  }

  // 드롭으로 파일 가져올 시 작동됨
  onDrop(e) {
    e.preventDefault();

    // 드롭으로 가져온 파일을 인풋 파일에 덮어씌우기
    this.addFileInputTarget.files = e.dataTransfer.files;

    // 파일 변경 이벤트 발생시키기
    const event = new Event("CUSTOM_FILE_CHANGE");
    this.element.dispatchEvent(event);
  }

  // 새창에서 이미지가 뜨는 이벤트를 막기위해 명시
  onDragOver(e) {
    e.preventDefault();
  }

  // 새로 추가할 예정인 이미지 파일 제거
  onRemoveNewImage(e) {
    // 삭제할 인덱스 가져오기
    const index = Number(e.currentTarget.dataset.index);
    if (isNaN(index)) throw new Error("삭제할 인덱스를 찾을 수 없습니다.");

    // 삭제할 인덱스를 제외한 파일들 추출
    const currentFileList = this.addFileInputTarget.files;
    const currentFiles = Array.from(currentFileList);
    const filterFiles = currentFiles.filter((x, i) => i !== index);

    // 삭제할 파일을 제외한 나머지 파일들만 다시 저장
    const dataTransfer = new DataTransfer();
    filterFiles.forEach((file) => {
      dataTransfer.items.add(file);
    });
    this.addFileInputTarget.files = dataTransfer.files;

    // 파일 변경 이벤트 발생시키기
    const event = new Event("CUSTOM_FILE_CHANGE");
    this.element.dispatchEvent(event);
  }

  // 업로드된 이미지 파일 제거: 제거할 파일 ID 인풋을 만들어냄
  onRemoveUploadedImage(e) {
    const removeInputEl =
      this.removeIdInputTemplateTarget.content.cloneNode(true);
    const id = e.currentTarget.dataset.id;
    removeInputEl.value = id;
    this.element.appendChild(removeInputEl);
    this.element.querySelector(`#preview_item_${id}`)?.remove();
  }

  // 파일에서 메타데이터 추출
  #getAddedFileMetadata() {
    // FileList 타입에 map등의 메서드가 없음, Array타입으로 변환
    const fileList = this.addFileInputTarget.files;
    const files = Array.from(fileList);
    const fileMetadata = files.map((x, i) => {
      return {
        // 파일객체에서 url 추출(서버 업로드전 미리보기용 URL)
        index: i,
        url: URL.createObjectURL(x),
        name: x.name,
        size: this.#formatFileSize(x.size),
        type: x.type,
      };
    });
    return fileMetadata;
  }

  // 파일 크기 포맷팅
  #formatFileSize(bytes) {
    if (bytes < 1024) return bytes + " B";
    else if (bytes < 1048576) return (bytes / 1024).toFixed(1) + " KB";
    else return (bytes / 1048576).toFixed(1) + " MB";
  }
}
