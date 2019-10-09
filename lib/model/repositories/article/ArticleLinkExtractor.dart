import 'package:farmsmart_flutter/model/entities/ImageURLProvider.dart';
import 'package:farmsmart_flutter/model/entities/article_entity.dart';
import 'package:farmsmart_flutter/model/repositories/image/implementation/PathImageProvider.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class _Fields {
  static const imageTag = "img";
  static const sourceTag = "src";
}

class ArticleLinkExtractor {
  final ArticleEntity article;

  ArticleLinkExtractor(this.article);

  List<ImageURLProvider> imageLinks(){
    dom.Document document = parser.parse(article.content);
    dom.Node body = document.body;
    return _findImageLinks(body);
  }

  List<ImageURLProvider> _findImageLinks(dom.Node node){
    ImageURLProvider nodeImage;
      if (node is dom.Element) {
                if (node.localName == _Fields.imageTag) {
                nodeImage = PathImageProvider(node.attributes[_Fields.sourceTag]);
                }
      }
    List<ImageURLProvider> links = (nodeImage!=null) ? [nodeImage] : [];
    for (var child in node.children) {
        _findImageLinks(child).forEach((image) => links.add(image));
    }
    return links;
  }
  
}