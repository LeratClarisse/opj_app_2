import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import '../models/document.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DocumentProvider {
  final documentsJson =
      '{"documents": [{"Id": 1, "Title": "Doc1", "File": "doc1.pdf", "Category": "DPG" },{"Id": 2, "Title": "Doc2", "File": "doc2.pdf", "Category": "DPS" },{"Id": 3, "Title": "Doc3", "File": "doc3.pdf", "Category": "DPG" },{"Id": 4, "Title": "Doc4", "File": "doc4.pdf", "Category": "DPS" },{"Id": 5, "Title": "Doc5", "File": "doc5.pdf", "Category": "PP"}]}';
  final sumupsJson =
      '{"sumups": [{"Id": 6, "Title": "Recap1", "File": "recap1.pdf", "Category": "DPG" },{"Id": 7, "Title": "Recap2", "File": "recap2.pdf", "Category": "DPS" }]}';

  Future<Database> init() async {
    io.Directory applicationDirectory =
        await getApplicationDocumentsDirectory();

    String dbPath = path.join(applicationDirectory.path, "opj_db.db");

    bool dbExists = await io.File(dbPath).exists();

    if (!dbExists) {
      // Copy from asset
      ByteData data =
          await rootBundle.load(path.join("assets", "db", "opj_db.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(dbPath).writeAsBytes(bytes, flush: true);
    }

    return openDatabase(dbPath);
  }
  
  Future<List<Document>> fetchCourseList() async {
	if (!kIsWeb) {
		Database db = await init();
		final List<Map<String, dynamic>> maps;

		maps = await db.query('Document');

		return List.generate(maps.length, (i) {
			return Document.fromJson(maps[i]);
		});
	} else {
		if (documentsJson.isNotEmpty) {
		  Iterable l = json.decode(documentsJson)['documents'];
		  List<Document> documents =
			  List<Document>.from(l.map((model) => Document.fromJson(model)));
		  return documents;
		} else {
		  throw Exception('Failed to load documents');
		}
	}
  }

  Future<List<Document>> fetchSumUpList() async {
	if (sumupsJson.isNotEmpty) {
	  Iterable l = json.decode(sumupsJson)['sumups'];
	  List<Document> sumups =
		  List<Document>.from(l.map((model) => Document.fromJson(model)));
	  return sumups;
	} else {
	  throw Exception('Failed to load documents');
	}
  }

  Future getDocumentByName(String name) async {
    io.Directory applicationDirectory =
        await getApplicationDocumentsDirectory();
    String filePath =
        path.join(applicationDirectory.path, name + ".pdf");
    bool fileExists = await io.File(filePath).exists();

    if (!fileExists) {
      // Copy from asset
      ByteData data =
          await rootBundle.load(path.join("assets", "documents", name + ".pdf"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await io.File(filePath).writeAsBytes(bytes, flush: true);
    }

    OpenFile.open(filePath);
  }
}
