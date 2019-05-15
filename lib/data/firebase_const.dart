const IMAGE_BASE_PATH = "/flamelink/media/sized";

const FLAME_LINK_CONTENT = 'fl_content';
const FLAME_LINK_SCHEMA = '_fl_meta_.schema';
const FLAME_LINK_SCHEMA_TYPE = "_fl_meta_.schemaType";
const FLAME_LINK_ENVIROMENT = '_fl_meta_.env';
const FLAME_LINK_LOCALE = '_fl_meta_.locale';
const PUBLICATION_STATUS = 'status';
const DASH = '/';

const String EMPTY = "";
const String documentFieldContent = "content";
const String documentFieldImage = "image";
const String documentFieldStatus = "status";
const String documentFieldSummary = "summary";
const String documentFieldTitle = "title";

const String imageSizes = "sizes";
const String imagePath = "path";
const String imageFile = "file";

class DataStatus {
  static const DRAFT = 'DRAFT';
  static const PUBLISHED = 'PUBLISHED';
}

class Schema {
  static const CROP =  'crop';
  static const CROP_STAGE = 'cropStage';
  static const ARTICLE = "article";
  static const ARTICLE_DIRECTORY = "articleDirectory";
}

class SchemaType {
  static const SINGLE = "single";
}

class FirestoreEnvironment {
  static const PRODUCTION = 'production';
  static const DEVELOPMENT = 'development';
}

class Locale {
  static const EN_US = 'en-US';
  static const SW_KE = 'sw-KE';
}
