import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../models/document.dart';

class DocumentProvider {
  final documentsJson =
      '{"documents": [{"id": 1, "docNumber": 1, "title": "Doc1", "file": "doc1.pdf", "category": "DPG" },{"id": 2, "docNumber": 2, "title": "Doc2", "file": "doc2.pdf", "category": "DPS" },{"id": 3, "docNumber": 3, "title": "Doc3", "file": "doc3.pdf", "category": "DPG" },{"id": 4, "docNumber": 4, "title": "Doc4", "file": "doc4.pdf", "category": "DPS" },{"id": 5, "docNumber": 5, "title": "Doc5", "file": "doc5.pdf", "category": "PP"}]}';
  final sumupsJson =
      '{"sumups": [{"id": 6, "docNumber": 6, "title": "Recap1", "file": "recap1.pdf", "category": "DPG" },{"id": 7, "docNumber": 7, "title": "Recap2", "file": "recap2.pdf", "category": "DPS" }]}';

  Future<List<Document>> fetchCourseList() async {
    if (documentsJson.isNotEmpty) {
      Iterable l = json.decode(documentsJson)['documents'];
      List<Document> documents =
          List<Document>.from(l.map((model) => Document.fromJson(model)));
      return documents;
    } else {
      throw Exception('Failed to load documents');
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
