// {
//   id: 3,
//   name: None,
//   order: 2,
//   user_id: e39d90b7-23e1-43dd-9256-754f5d825d26,
//   favorites: [
//     {
//       id: 15,
//       symbol_id: 5285,
//       order: 1,
//       group_id: 3,
//       user_id: e39d90b7-23e1-43dd-9256-754f5d825d26,
//       symbols: {
//         id: 5285,
//         ticker: AMZN,
//         name: Amazon.com Inc,
//         country: United States,
//         currency: USD,
//         exchange: NASDAQ,
//         mic_code: XNGS,
//         type: Stock
//       }
//     },
//     {
//       id: 14,
//       symbol_id: 22055,
//       order: 0,
//       group_id: 3,
//       user_id: e39d90b7-23e1-43dd-9256-754f5d825d26,
//       symbols: {
//         id: 22055,
//         ticker: SNOW,
//         name: Snowflake Inc,
//         country: United States,
//         currency: USD,
//         exchange: NYSE,
//         mic_code: XNYS,
//         type: Stock
//       }
//     }
//   ]
// }

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
