import 'package:raccoon_investment/model/symbol_model.dart';

class Favorite {
  final int id;
  final int order;
  final int groupId;
  final Symbol? symbols;

  const Favorite({
    required this.id,
    required this.order,
    required this.groupId,
    this.symbols,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    final Symbol? symbols =
        json['symbols'] != null ? Symbol.fromJson(json['symbols']) : null;

    return Favorite(
      id: json['id'],
      order: json['order'],
      groupId: json['group_id'],
      symbols: symbols,
    );
  }
}
