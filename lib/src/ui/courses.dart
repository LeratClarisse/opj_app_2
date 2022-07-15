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
              return buildList(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
			  return const Center(child: Text("Aucun cours"));
			}
          },
        ));
  }

  Widget buildList(List<Document> documents) {
    return ListView.builder(
        itemCount: documents.length,
        itemBuilder: (BuildContext context, int index) {
			Document doc = documents[index];
			if (index == 0) {
			  return Column(children: [
				Container(
				  color: Colors.cyan,
				  child: const ListTile(
					leading: Text('Cat.'),
					title: Text('Titre'),
					trailing: Text('Sous-cat.'),
				  ),
				),
				ListTile(leading: Text(doc.category), title: Text(doc.title), trailing: Text(doc.subcategory), onTap: () {})
			  ]);
			} else {
			  return ListTile(leading: Text(doc.category), title: Text(doc.title), trailing: Text(doc.subcategory), onTap: () {bloc.getDocumentByName(doc.file);});
			}
        });
  }
}
