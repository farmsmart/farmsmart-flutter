import 'package:farmsmart_flutter/data/model/article_entity.dart';

class NewStageEntity {
  final String id;
  final ArticleEntity article;
  final DateTime started;
  final DateTime ended;

  NewStageEntity({String id, ArticleEntity article, DateTime started, DateTime ended}) : this.id = id, this.article = article, this.started = started, this.ended = ended;
}
