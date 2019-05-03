const IMAGE_BASE_PATH = "/flamelink/media/sized";

const FLAME_LINK_CONTENT = 'fl_content';
const FLAME_LINK_SCHEMA = '_fl_meta_.schema';
const FLAME_LINK_ENVIROMENT = '_fl_meta_.env';
const FLAME_LINK_LOCALE = '_fl_meta_.locale';
const PUBLICATION_STATUS = 'status';
const DASH = '/';

class DataStatus {
  static const DRAFT = 'DRAFT';
  static const PUBLISHED = 'PUBLISHED';
}

class Schema {
  static const CROP =  'crop';
  static const CROP_STAGE = 'cropStage';
  static const ARTICLE = "article";
}

class FirestoreEnvironment {
  static const PRODUCTION = 'production';
  static const DEVELOPMENT = 'development';
}

class Locale {
  static const EN_US = 'en-US';
  static const SW_KE = 'sw-KE';
}
