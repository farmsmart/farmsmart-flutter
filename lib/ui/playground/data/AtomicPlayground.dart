import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';
import 'package:farmsmart_flutter/ui/playground/playground_view.dart';
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:flutter/widgets.dart';

enum AtomicType { atom, molecule, organism, template, page }

class _Strings {
  static const atomTitle = "Atom";
  static const moleculeTitle = "Molecule";
  static const organismTitle = "Organism";
  static const templateTitle = "Template";
  static const pageTitle = "Page";
}

class AtomicPlaygroundComponent {
  static List<AtomicPlaygroundComponent> _components = [];
  final AtomicType type;
  final String title;
  final Widget component;

  AtomicPlaygroundComponent({@required AtomicType type, @required String title, @required Widget component})
      : this.title = title,
        this.type = type,
        this.component = component {
    _components.add(this);
  }

  Widget asPlaygroundEntry() {
    return PlaygroundWidget(
      child: component,
      title: title,
    );
  }

  static List<AtomicPlaygroundComponent> _getComponents() {
    return _components;
  }
}

class AtomicPlaygroundDatasource implements PlaygroundDataSource {
  @override
  List<Widget> getList() {
    return [
      PlaygroundWidget(
        title: _Strings.atomTitle,
        child: PlaygroundView(widgetList: _generateFor(AtomicType.atom)),
      ),
      PlaygroundWidget(
        title: _Strings.moleculeTitle,
        child: PlaygroundView(widgetList: _generateFor(AtomicType.molecule)),
      ),
      PlaygroundWidget(
        title: _Strings.organismTitle,
        child: PlaygroundView(widgetList: _generateFor(AtomicType.organism)),
      ),
      PlaygroundWidget(
        title: _Strings.templateTitle,
        child: PlaygroundView(widgetList: _generateFor(AtomicType.template)),
      ),
      PlaygroundWidget(
        title: _Strings.pageTitle,
        child: PlaygroundView(widgetList: _generateFor(AtomicType.page)),
      ),
    ];
  }

  List<Widget> _generateFor(AtomicType type) {
    return AtomicPlaygroundComponent._getComponents().where((component) {
      return component.type == type;
    }).map((component) {
      return component.asPlaygroundEntry();
    }).toList();
  }
}
