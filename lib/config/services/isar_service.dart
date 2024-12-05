// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';

// class IsarService {
//   late Future<Isar> db;

//   IsarService() {
//     db = openDB();
//   }

//   Future<Isar> openDB() async {
//     if (Isar.instanceNames.isEmpty) {
//       final dir = await getApplicationDocumentsDirectory();

//       return await Isar.open(
//         [],
//         directory: dir.path,
//         inspector: true,
//       );
//     }

//     return Future.value(Isar.getInstance());
//   }
// }
