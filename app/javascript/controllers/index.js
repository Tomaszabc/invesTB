// Import and register all your controllers from the importmap under controllers/*

// import { application } from "controllers/application"

// // Eager load all controllers defined in the import map under controllers/**/*_controller
// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
import { application } from "./application";
import RemovalsController from "./removals_controller";
import LightboxController from "./lightbox_controller";
import SwiperController from "./swiper_controller";
import ArticlesController from "./articles_controller";
import Dialog from '@stimulus-components/dialog'


application.register("removals", RemovalsController);
application.register("lightbox", LightboxController);
application.register("swiper", SwiperController);
application.register('articles', ArticlesController);
application.register('dialog', Dialog);