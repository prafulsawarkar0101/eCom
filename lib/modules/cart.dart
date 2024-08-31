import 'package:shared_preferences/shared_preferences.dart';

  const String _idList = "idKeyList";

  Future<void> savaIdList(List<int> idList) async {
        print("saveIdList");

    final pref = await SharedPreferences.getInstance();
    List<String> idStringList = idList.map((id) => id.toString()).toList();
    await pref.setStringList(_idList, idStringList);
  }

  Future<List<int>> getIdList() async {
        print("getIdList");

    final pref = await SharedPreferences.getInstance();

    List<String>? idStingList = pref.getStringList(_idList);

    if (idStingList != null) {
      return idStingList.map((id) => int.parse(id)).toList();
    } else {
      return [];
    }
  }

  Future<void> saveId(int value) async {
    print("saveIdFunction");
    List<int> idIntList = await getIdList();
    idIntList.add(value);
    print(value);


    await savaIdList(idIntList);
    // print(idIntList);
  }

  Future<void> removeId(int id) async {
    List<int> idList = await getIdList();
    idList.remove(id);
    await savaIdList(idList);
    
  }
Future<int> getIdCount() async {
  print("getIdCount");


  List<int> idIntList = await getIdList();

  if (idIntList != null) {
    return idIntList.length;
  } else {
    return 0;
  }
}
