import 'package:flutter/material.dart';
import 'menu.dart';
import '../models/document.dart';
import '../blocs/document_bloc.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

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
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
			  return const Center(child: Text("Aucun cours"));
			}
          },
        ));
  }

  Widget buildList(AsyncSnapshot<List<Document>> snapshot) {
    List<Document>? datas = snapshot.data;

    return ListView.builder(
        itemCount: snapshot.data?.length,
        itemBuilder: (BuildContext context, int index) {
          if (datas != null) {
            Document doc = datas[index];
            if (index == 0) {
              return Column(children: [
                Container(
                  color: Colors.cyan,
                  child: const ListTile(
                    leading: Text('N°'),
                    title: Text('Titre'),
                    trailing: Text('Catégorie'),
                  ),
                ),
                ListTile(leading: Text(doc.docNumber.toString()), title: Text(doc.title), trailing: Text(doc.category), onTap: () {})
              ]);
            } else {
              return ListTile(leading: Text(doc.docNumber.toString()), title: Text(doc.title), trailing: Text(doc.category), onTap: () {});
            }
          } else {
            return const Text("Aucun cours");
          }
        });
  }
}
