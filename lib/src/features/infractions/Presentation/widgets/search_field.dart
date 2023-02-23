import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../blocs/infraction_bloc.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
