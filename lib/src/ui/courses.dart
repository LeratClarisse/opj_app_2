import 'package:flutter/material.dart';
import 'menu.dart';
import '../models/document.dart';
import '../blocs/document_bloc.dart';
import 'package:data_table_2/data_table_2.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);
  @override
  State<Courses> createState() => _Courses();
}

class _Courses extends State<Courses> {
  bool _sortAscending = true;
  int? _sortColumnIndex;

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllCourses();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('OPJ Expert'),
        ),
        drawer: const Menu(),
        body: StreamBuilder(
          stream: bloc.allCourses,
          builder: (context, AsyncSnapshot<List<Document>> snapshot) {
            if (snapshot.hasData) {
              return buildTable(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const Center(child: Text("Aucun cours"));
            }
          },
        ));
  }

  List<DataColumn2> buildColumns(List<Document> documents) {
    return <DataColumn2>[
      DataColumn2(
          label: const Text('Titre'),
          onSort: (columnIndex, sortAsc) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = sortAsc;

              bloc.sortDocument('Title', _sortAscending);
            });
          }),
      DataColumn2(
          label: const Text('Cat.'),
          onSort: (columnIndex, sortAsc) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = sortAsc;

              bloc.sortDocument('Category', _sortAscending);
            });
          }),
      DataColumn2(
          label: const Text('Sous-cat.'),
          onSort: (columnIndex, sortAsc) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = sortAsc;

              bloc.sortDocument('Subcategory', _sortAscending);
            });
          }),
    ];
  }

  List<DataRow> buildRows(List<Document> documents) {
    return List.generate(documents.length, (index) {
      Document doc = documents[index];
      return DataRow(
          cells: <DataCell>[
            DataCell(
              Text(doc.title),
            ),
            DataCell(
              Text(doc.category),
            ),
            DataCell(
              Text(doc.subcategory),
            )
          ],
          onSelectChanged: (selected) {
            if (selected ?? false) {
              bloc.getDocumentByName(doc.file);
            }
          });
    });
  }

  Widget buildTable(List<Document> documents) {
    List<DataColumn2> columns = buildColumns(documents);
    List<DataRow> rows = buildRows(documents);

    return DataTable2(
        sortColumnIndex: _sortColumnIndex,
        sortAscending: _sortAscending,
        showCheckboxColumn: false,
        columns: columns,
        rows: rows);
  }
}
