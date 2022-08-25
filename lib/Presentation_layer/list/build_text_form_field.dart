import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/stateManageMent_layer/provider.dart';

class BuildTextFormField extends StatelessWidget {
  TextEditingController controller;

  String validateMessage;

  String textLabel;

  BuildTextFormField(this.controller, this.validateMessage, this.textLabel);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return TextFormField(
      controller: controller,
      validator: (text) {
        if (text == null || text.trim().isEmpty) {
          return validateMessage;
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: provider.isDark() ? Colors.white : Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: provider.isDark() ? Colors.white : Colors.black)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: provider.isDark() ? Colors.white : Colors.black)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: textLabel,
        labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: provider.isDark() ? Colors.white : Colors.black,
            fontSize: 18),
      ),
    );
  }
}
