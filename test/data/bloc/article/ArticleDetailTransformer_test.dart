import 'package:farmsmart_flutter/model/bloc/article/ArticleDetailTransformer.dart';
import 'package:farmsmart_flutter/model/bloc/article/ArticleListItemViewModelTransformer.dart';
import 'package:farmsmart_flutter/model/entities/mock/MockArticle.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

final testArticle = MockArticle().build();

void main() {

  TestWidgetsFlutterBinding.ensureInitialized();
  test('Article detail viewmodel transfomed from article correctly', () {
    final detailTransformer = ArticleDetailViewModelTransformer();
    final listTransformer = ArticleListItemViewModelTransformer(detailTransformer: detailTransformer);
    detailTransformer.setListItemTransformer(listTransformer);
    
    final articleDetailViewModel = detailTransformer.transform(from: testArticle);
    final publishedDateString = DateFormat("d MMMM").format(testArticle.published);

    expect(articleDetailViewModel.title, testArticle.title);
    expect(articleDetailViewModel.body, testArticle.content);

    final subtitleContainsPublishDate = articleDetailViewModel.subtitle.contains(publishedDateString);
    expect(subtitleContainsPublishDate, true);

    //TODO: add more coverage, sharelink, releated
  });
}