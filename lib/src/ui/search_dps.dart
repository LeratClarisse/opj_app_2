import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:opjapp/src/blocs/question_bloc.dart';
import 'package:opjapp/src/models/question.dart';
import 'package:opjapp/src/ui/details_dps.dart';
import 'package:opjapp/src/ui/home.dart';
import 'package:opjapp/src/ui/menu.dart';

class SearchDPS extends StatefulWidget {
  const SearchDPS({Key? key}) : super(key: key);
  @override
  State<SearchDPS> createState() => _SearchDPS();
}

class _SearchDPS extends State<SearchDPS> {
  bool _sortAscending = true;
  int? _sortColumnIndex;

  @override
  void initState() {
    bloc.fetchAllQuestions('Tous', 'DPS', 'Toutes', 'Tous');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Home()),
          );
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Infractions'),
            ),
            drawer: const Menu(),
            body: StreamBuilder(
              stream: bloc.allQuestions,
              builder: (context, AsyncSnapshot<List<Question>> snapshot) {
                if (snapshot.hasData) {
                  return buildTable(context, snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const Center(child: Text("Aucune infraction"));
                }
              },
            )));
  }

  List<DataColumn2> buildColumns(BuildContext context, List<Question> documents) {
    return <DataColumn2>[
      DataColumn2(
          size: ColumnSize.L,
          label: const Text('Intitulé'),
          onSort: (columnIndex, sortAsc) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = sortAsc;

              bloc.sortQuestions('Label', _sortAscending);
            });
          })
    ];
  }

  List<DataRow> buildRows(List<Question> questions) {
    return List.generate(questions.length, (index) {
      Question question = questions[index];
      return DataRow(
          cells: <DataCell>[
            DataCell(
              Text(question.label, overflow: TextOverflow.ellipsis),
            )
          ],
          onSelectChanged: (selected) {
            if (selected ?? false) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => DetailsDPS(
                        question.dpsLongLabel!, question.dpsArticle!, question.dpsPunissable!, question.dpsIntention!, question.dpsElemMat!, question.dpsDesc ?? '')),
              );
            }
          });
    });
  }

  Widget buildTable(BuildContext context, List<Question> questions) {
    List<DataColumn2> columns = buildColumns(context, questions);
    List<DataRow> rows = buildRows(questions);

    return DataTable2(sortColumnIndex: _sortColumnIndex, sortAscending: _sortAscending, showCheckboxColumn: false, columns: columns, rows: rows);
  }
}
