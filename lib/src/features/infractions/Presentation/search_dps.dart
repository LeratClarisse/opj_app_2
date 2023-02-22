import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/Presentation/home.dart';
import '../../../core/Presentation/menu.dart';
import '../Domain/infraction_entity.dart';
import 'blocs/infraction_bloc.dart';
import 'details_dps.dart';

class SearchDPS extends StatefulWidget {
  const SearchDPS({Key? key}) : super(key: key);
  @override
  State<SearchDPS> createState() => _SearchDPS();
}

class _SearchDPS extends State<SearchDPS> {
  bool _searchBoolean = false;

  @override
  void initState() {
    bloc.fetchAllInfractions();
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
                title: !_searchBoolean ? const Text('Infractions') : searchTextField(),
                actions: !_searchBoolean
                    ? [
                        IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                _searchBoolean = true;
                              });
                            })
                      ]
                    : [
                        IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              bloc.searchDps();
                              setState(() {
                                _searchBoolean = false;
                              });
                            })
                      ]),
            drawer: const Menu(),
            body: StreamBuilder(
              stream: bloc.allInfractions,
              builder: (context, AsyncSnapshot<List<InfractionEntity>> snapshot) {
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

  Widget searchTextField() {
    return TextField(
      onSubmitted: (String s) {
        bloc.searchDps(search: s);
      },
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
      ],
      autofocus: true, // Display the keyboard when TextField is displayed
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search, // Specify the action for the Enter button on the keyboard
      decoration: const InputDecoration(
        //Style of TextField
        enabledBorder: UnderlineInputBorder(
            //Default TextField border
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: UnderlineInputBorder(
            //Borders when a TextField is in focus
            borderSide: BorderSide(color: Colors.white)),
        hintText: 'Recherche', //Text that is displayed when nothing is entered.
        hintStyle: TextStyle(
          //Style of hintText
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }

  List<DataColumn2> buildColumns(BuildContext context, List<InfractionEntity> documents) {
    return const <DataColumn2>[DataColumn2(size: ColumnSize.L, label: Text('Intitulé'))];
  }

  List<DataRow> buildRows(List<InfractionEntity> infractions) {
    return List.generate(infractions.length, (index) {
      InfractionEntity infraction = infractions[index];
      return DataRow(
          cells: <DataCell>[
            DataCell(
              Text(infraction.label, overflow: TextOverflow.ellipsis),
            )
          ],
          onSelectChanged: (selected) {
            if (selected ?? false) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => DetailsDPS(infraction.dpsLongLabel!, infraction.dpsArticle!, infraction.dpsPunissable!, infraction.dpsIntention!,
                        infraction.dpsElemMat!, infraction.dpsDesc ?? '')),
              );
            }
          });
    });
  }

  Widget buildTable(BuildContext context, List<InfractionEntity> infractions) {
    List<DataColumn2> columns = buildColumns(context, infractions);
    List<DataRow> rows = buildRows(infractions);

    return DataTable2(showCheckboxColumn: false, columns: columns, rows: rows);
  }
}
