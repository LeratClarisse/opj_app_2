import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'home.dart';
import 'menu.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  Future<PackageInfo> _getPackageInfo() {
    return PackageInfo.fromPlatform();
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
            title: const Text('À propos'),
          ),
          drawer: const Menu(),
          body: FutureBuilder<PackageInfo>(
            future: _getPackageInfo(),
            builder: (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
              if (snapshot.hasError) {
                return const Text('Erreur');
              } else if (!snapshot.hasData) {
                return const Text('Chargement...');
              }

              final data = snapshot.data!;

              return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    const SizedBox(height: 30),
                    Text(data.appName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
                    Text(data.version),
                    const SizedBox(height: 30),
                    const Text('Application réalisée avec Flutter v3'),
                    const SizedBox(height: 30),
                    const Text('En cas de problème vous pouvez nous contacter ici : clarisselerat@hotmail.fr', textAlign: TextAlign.center),
                  ]));
            },
          ),
        ));
  }
}
