import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';

class SharedPreferencesRepository implements DatabaseRepository {

  final SharedPreferencesAsync _pref = SharedPreferencesAsync();
  final String _itemsKey = 'items';
  @override
  Future<void> addItem(String item) async {
    List<String> items = await getItems();
    items.add(item);
    await _pref.setStringList(_itemsKey, items);
  }

  @override
  Future<void> deleteItem(int index) async {
    List<String> items = await getItems();
    if (items.length > index) {
      items.removeAt(index);
      await _pref.setStringList(_itemsKey, items);
    } else {
      throw Exception('invalid remove index');
    }
  }

  @override
  Future<void> editItem(int index, String newItem) async {
    List<String> items = await getItems();
    if (items.length > index) {
      items[index] = newItem;
      await _pref.setStringList(_itemsKey, items);
    } else {
      throw Exception('invalid edit index');
    }
  }

  @override
  Future<int> getItemCount() async => (await getItems()).length;

  @override
  Future<List<String>> getItems() async => await _pref.getStringList(_itemsKey) ?? [];
}