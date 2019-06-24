
import 'dart:math';
import 'package:farmsmart_flutter/data/model/article_entity.dart';
import 'package:farmsmart_flutter/data/repositories/ArticleRepositoryInterface.dart';
import 'package:farmsmart_flutter/model/enums.dart';

class MockString {
  final Random _rand;
  final List<String> _library;

  MockString({List<String> library, int seed = 0}) : _library = library, _rand = Random(seed);

  String _getLibraryString() {
    final errorString =  "Error string library data missing";
    if ( _library.isEmpty){
      return errorString;
    }
    final index = _rand.nextInt(max(0,_library.length-1));
    final string = _library[index];
    return string.isNotEmpty ? string : errorString; 
  }
  
  String random({int length = 0}) {
    final libraryString = _getLibraryString(); 
    final maxLength = (length > 0) ? min(length, libraryString.length) : libraryString.length;
    final lastIndex = max(0,_rand.nextInt(maxLength)-1);
    return libraryString.substring(0,lastIndex);
  }

  String indexed({String text = "index", int index}) {
    return text + " " + index.toString();
  }

  String identifier() {
    int maxSupported = 1<<32;
    return _rand.nextInt(maxSupported).toString();
  }
  
}

class MockArticle {
  static ArticleEntity build() {
      return ArticleEntity(id:_mockPlainText.identifier(),
       content: _mockRichText.random(), 
       imagePathReference: "",
       imageUrl: Future.value(""),
       relatedArticles: [],
       relatedArticlesPathReference: [],
       status:Status.PUBLISHED,
       summary:_mockPlainText.random(),
       title:_mockTitleText.random(),
       ); 
  }
}

class MockArticlesRepository implements ArticleRepositoryInterface {

  final _articles;
  final _delay = Duration(seconds: 1);
  final _streamEventCount = 50;

  MockArticlesRepository({int articleCount = 50}) : _articles = _generateArticles(count: articleCount);

  static List<ArticleEntity> _generateArticles({int count = 50}) {
    var articles = [];
    for (var i = 0; i < count; i++) {
      articles.add(MockArticle.build());
    }
    return articles;
  }

  @override
  Future<List<ArticleEntity>> get({ArticleCollectionGroup group = ArticleCollectionGroup.all, int limit = 0}) {
    return Future.delayed(_delay, () => _articles);
  }

  @override
  Future<ArticleEntity> getArticle(String uri) {
    return Future.delayed(_delay, () => MockArticle.build());
  }

  @override
  Future<List<ArticleEntity>> getArticles(ArticleEntityCollection collection) {
    return collection.getEntities();
  }

  @override
  Stream<ArticleEntity> observeArticle(String uri) {
    var sequence;
    for (var i = 0; i < _streamEventCount; i++) {
      sequence.add(Future.delayed(_delay, () => MockArticle.build()));
    }
    return Stream.fromFutures(sequence);
  }
  
}

// Mock Strings --------------

MockString _mockTitleText = MockString(library: ["Title example",
"Longer title example", 
"A Bit longer title example"]);
MockString _mockPlainText = MockString(library: ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."]);
MockString _mockRichText = MockString(library: ["""<p><abbr>ABBR</abbr>, <acronym>ACRONYM</acronym> or <span style="border-bottom: 1px dotted">inline style</span></p>
<p><b>B</b>, <strong>STRONG</strong> or <span style="font-weight: bold">inline style</span></p>
<p><em>EM</em>, <i>I</i> or <span style="font-style: italic">inline style</span></p>
<p><u>U</u> or <span style="text-decoration: underline">inline</span> <span style="border-bottom: 1px">style</span></p>
<p><span style="color: #ff0000">Red</span>, <span style="color: #00ff00">green</span>, <span style="color: #0000ff">blue</span></p>
<p>
  <span style="text-decoration: line-through">
    <span style="text-decoration: overline">
      <span style="text-decoration: underline">
        All decorations...
        <span style="text-decoration: none">and none</span>
      </span>
    </span>
  </span>
</p>""", """<ul>
  <li>One</li>
  <li>Two</li>
  <li>Three</li>
</ul>""", """<ol>
  <li>One</li>
  <li>
    Two
    <ul>
      <li>2.1</li>
      <li>
        2.2
        <ul>
          <li>2.2.1</li>
          <li>2.2.2</li>
        </ul>
      </li>
      <li>2.3</li>
    </ul>
  </li>
  <li>Three</li>
  <li>
    <a href="https://gph.is/QFgPA0"><img src="https://media.giphy.com/media/6VoDJzfRjJNbG/giphy-downsized.gif" /></a>
  </li>
  <li>Five</li>
  <li>Six</li>
  <li>Seven</li>
  <li>Eight</li>
  <li>Nine</li>
  <li>Ten</li>
  <li>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed nibh quam, sodales in sollicitudin ut, scelerisque non sapien. Nam nec mi malesuada libero euismod tincidunt sit amet mattis ipsum. Etiam dapibus sem ac accumsan elementum. Vivamus mattis at diam ac pellentesque. Sed id eros condimentum, dignissim risus id, semper enim. Etiam tempor mauris id lorem fringilla, dapibus feugiat enim placerat. In hac habitasse platea dictumst. Nam est felis, accumsan et sapien ac, molestie convallis sapien. Vivamus ligula sapien, ultrices quis nisl ac, blandit hendrerit massa. Maecenas eleifend, nisi eget commodo mollis, elit magna pellentesque odio, sit amet auctor quam nibh vel purus. Integer ultricies lacinia ipsum, in tincidunt erat finibus eget.</li>
</ol>"""]);