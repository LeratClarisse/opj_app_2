import 'package:flutter/material.dart';
import 'menu.dart';
import '../models/document.dart';
import '../blocs/document_bloc.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllDocuments();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('OPJ Expert'),
        ),
        drawer: const Menu(),
        body: StreamBuilder(
          stream: bloc.allDocuments,
          builder: (context, AsyncSnapshot<List<Document>> snapshot) {
            if (snapshot.hasData) {
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget buildList(AsyncSnapshot<List<Document>> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data?.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return const Text("test");
        });
  }
}
