import { Application } from "@hotwired/stimulus";
import { FlashController } from "./shared/flash_controller";
import { LottieController } from "./shared/lottie_controller";
import { ModalController } from "./shared/modal_controller";
import { NotYetController } from "./shared/not_yet_controller";
import { TinymceController } from "./shared/tinymce_controller";

const application = Application.start();

application.register("flash", FlashController);
application.register("tinymce", TinymceController);
application.register("modal", ModalController);
application.register("not_yet", NotYetController);
application.register("lottie", LottieController);