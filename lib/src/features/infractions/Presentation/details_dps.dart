import 'package:flutter/material.dart';

import '../../../core/styles/buttons.dart';

class DetailsDPS extends StatelessWidget {
  final String dpsLongLabel;
  final String dpsArticle;
  final String dpsPunissable;
  final String dpsIntention;
  final String dpsElemMat;
  final String dpsDesc;

  const DetailsDPS(this.dpsLongLabel, this.dpsArticle, this.dpsPunissable, this.dpsIntention, this.dpsElemMat, this.dpsDesc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Infraction'),
          ),
          body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                const SizedBox(height: 10),
                Center(child: Text(dpsLongLabel, textAlign: TextAlign.center, style: titleStyle)),
                const SizedBox(height: 30),
                Expanded(
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical, child: buildInfosDPS(dpsArticle, dpsPunissable, dpsIntention, dpsElemMat, dpsDesc)))
              ]))),
    );
  }

  Widget buildInfosDPS(String dpsArticle, String dpsPunissable, String dpsIntention, String dpsElemMat, String dpsDesc) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(dpsArticle),
            const SizedBox(height: 20),
            Text(dpsIntention),
            const SizedBox(height: 20),
            const Text('Tentative', style: prefixStyle),
            const SizedBox(height: 10),
            Text(dpsPunissable),
            const SizedBox(height: 30),
            const Text('Elément matériel', style: prefixStyle),
            const SizedBox(height: 10),
            Text(dpsElemMat.replaceAll(r'\n', '\n')),
            if (dpsDesc.isNotEmpty) const SizedBox(height: 30),
            if (dpsDesc.isNotEmpty) const Text('Description', style: prefixStyle),
            if (dpsDesc.isNotEmpty) const SizedBox(height: 10),
            if (dpsDesc.isNotEmpty) Text(dpsDesc.replaceAll(r'\n', '\n')),
          ],
        ));
  }
}
