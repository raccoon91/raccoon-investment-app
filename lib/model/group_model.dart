import 'package:raccoon_investment/model/favorite_model.dart';

class Group {
  final int id;
  final String name;
  final int order;
  final List<Favorite>? fovorites;

  const Group({
    required this.id,
    required this.name,
    required this.order,
    this.fovorites,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    final List? data = json['favorites'];
    final List<Favorite>? favorites = data?.map((favorite) {
      return Favorite.fromJson(favorite);
    }).toList();

    return Group(
      id: json['id'],
      name: json['name'],
      order: json['order'],
      fovorites: favorites,
    );
  }
}
