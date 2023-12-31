import 'dart:async';

import 'package:raccoon_investment/main.dart';
import 'package:raccoon_investment/model/group_model.dart';

class GroupRepository {
  Future<List<Group>> getGroups() async {
    try {
      final List data = await supabase
          .from('groups')
          .select('*, favorites ( *, symbols ( * ))')
          .order('order', ascending: true)
          .order('order', foreignTable: 'favorites', ascending: true);

      final List<Group> groups =
          data.map((element) => Group.fromJson(element)).toList();

      return groups;
    } catch (error) {
      throw Exception(error);
    }
  }
}
