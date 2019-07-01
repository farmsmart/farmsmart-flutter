abstract class ImageEntityURLProvider {
    Future<String> urlToFit({double width,double height});
}

class ImageEntity {
    final int width;
    final int height;
    final String path;
    ImageEntityURLProvider urlProvider;
    final List<ImageEntity> otherSizes;
  ImageEntity(this.width, this.height, this.path, this.urlProvider, this.otherSizes);
}