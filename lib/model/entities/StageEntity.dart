import 'package:farmsmart_flutter/model/entities/article_entity.dart';
class StageEntity {
  final String id;
  final ArticleEntity article;
  final DateTime started;
  final DateTime ended;

  StageEntity({
    String id,
    ArticleEntity article,
    DateTime started,
    DateTime ended,
  })  : this.id = id,
        this.article = article,
        this.started = started,
        this.ended = ended;
}
