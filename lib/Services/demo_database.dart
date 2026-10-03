import 'dart:convert';
import 'package:flutter/material.dart';
import 'demo_seed.dart';

/// Small in-memory adapter for the queries used by the original screens.
/// Nothing is persisted or sent to a server. Reloading restores the seed.
class DemoDatabase extends ChangeNotifier {
  static final instance = DemoDatabase();
  Map<String, dynamic> _data = demoSeed();
  int _sequence = 0;
  Query ref([String path = '']) => Query(this, path);
  void reset() {
    _data = demoSeed();
    _sequence = 0;
    notifyListeners();
  }

  dynamic read(String path) {
    dynamic value = _data;
    for (final part in path.split('/').where((p) => p.isNotEmpty)) {
      value = value is Map ? value[part] : null;
    }
    return jsonDecode(jsonEncode(value));
  }

  void write(String path, dynamic value, {bool merge = false}) {
    // Public portfolio demo: all mutation APIs intentionally do nothing.
    // Original implementation retained below for a future connected version.
    //     final parts = path.split('/').where((p) => p.isNotEmpty).toList();
    //     Map<String, dynamic> node = _data;
    //     for (final part in parts.take(parts.length - 1)) {
    //       node =
    //           node.putIfAbsent(part, () => <String, dynamic>{})
    //               as Map<String, dynamic>;
    //     }
    //     if (value == null) {
    //       node.remove(parts.last);
    //     } else if (merge) {
    //       (node[parts.last] as Map).addAll(value as Map);
    //     } else {
    //       node[parts.last] = jsonDecode(jsonEncode(value));
    //     }
    //     notifyListeners();
  }
}

class DataSnapshot {
  const DataSnapshot(this.value);
  final dynamic value;
  bool get exists => value != null;
}

class Query {
  Query(
    this.db,
    this.path, {
    this.order,
    this.equal,
    this.minimum,
    this.maximum,
    this.limit,
    this.last = false,
    this.term,
  });
  final DemoDatabase db;
  final String path;
  final String? order, term;
  final Object? equal, minimum, maximum;
  final int? limit;
  final bool last;
  String? get key => path.split('/').last;
  Query child(String name) => Query(db, '$path/$name');
  Query orderByChild(String field) => Query(db, path, order: field);
  Query equalTo(Object? value) => Query(db, path, order: order, equal: value);
  Query startAt(Object value) => Query(db, path, order: order, minimum: value);
  Query endAt(Object value) =>
      Query(db, path, order: order, minimum: minimum, maximum: value);
  Query limitToFirst(int n) => Query(
    db,
    path,
    order: order,
    equal: equal,
    minimum: minimum,
    maximum: maximum,
    limit: n,
  );
  Query limitToLast(int n) => Query(db, path, limit: n, last: true);
  Query search(String value) =>
      Query(db, path, term: value.toLowerCase().trim());
  Query push() => child('DEMO-${++db._sequence}');
  Future<void> set(dynamic value) async => db.write(path, value);
  Future<void> update(Map<String, dynamic> value) async =>
      db.write(path, value, merge: true);
  Future<void> remove() async => db.write(path, null);
  dynamic _field(dynamic value) {
    for (final part in (order ?? '').split('/')) {
      value = value is Map ? value[part] : null;
    }
    return value;
  }

  int _compare(dynamic a, dynamic b) =>
      a is num && b is num ? a.compareTo(b) : '$a'.compareTo('$b');
  dynamic get value {
    final raw = db.read(path);
    if (raw is! Map || (order == null && term == null && limit == null)) {
      return raw;
    }
    var rows = raw.entries.where((entry) {
      final field = _field(entry.value);
      if (equal != null && field != equal) return false;
      if (minimum != null && _compare(field, minimum) < 0) return false;
      if (maximum != null && _compare(field, maximum) > 0) return false;
      if (term != null) {
        final item = entry.value as Map;
        if (!'${item['description']} ${item['code']} ${item['category']}'
            .toLowerCase()
            .contains(term!)) {
          return false;
        }
      }
      return true;
    }).toList();
    if (order != null) {
      rows.sort((a, b) => _compare(_field(a.value), _field(b.value)));
    }
    if (limit != null && rows.length > limit!) {
      rows = last
          ? rows.sublist(rows.length - limit!)
          : rows.take(limit!).toList();
    }
    return rows.isEmpty
        ? null
        : Map<String, dynamic>.fromEntries(
            rows.map((e) => MapEntry(e.key as String, e.value)),
          );
  }

  Future<DataSnapshot> get() async =>
      DataSnapshot(jsonDecode(jsonEncode(value)));
}

class LocalAnimatedList extends StatelessWidget {
  const LocalAnimatedList({
    super.key,
    required this.query,
    required this.itemBuilder,
    this.defaultChild,
    this.physics,
    this.shrinkWrap = false,
  });
  final Query query;
  final Widget Function(BuildContext, DataSnapshot, Animation<double>, int)
  itemBuilder;
  final Widget? defaultChild;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: query.db,
    builder: (context, _) {
      final rows = (query.value as Map?)?.values.toList() ?? [];
      if (rows.isEmpty) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'No hay elementos para mostrar.',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      return ListView.builder(
        physics: physics,
        shrinkWrap: shrinkWrap,
        itemCount: rows.length,
        itemBuilder: (context, i) => itemBuilder(
          context,
          DataSnapshot(rows[i]),
          const AlwaysStoppedAnimation(1),
          i,
        ),
      );
    },
  );
}
