import { Controller } from "@hotwired/stimulus";

export class FlashController extends Controller {
  connect() {
    console.log(this.element);
    setTimeout(() => {
      if (!this.element) {
        return;
      }
      this.element.remove();
    }, 3000);
  }

  onClose() {
    this.element.remove();
  }
}