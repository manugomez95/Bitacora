import 'package:bitacora/model/property.dart';
import 'package:bitacora/ui/components/property_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

TypeAheadFormField typeAheadFormField(
    {BuildContext context,
    Property property,
    ValueLV value,
    Function(dynamic) onSuggestionSelected,
    Function(dynamic) onChanged,
    Function(String) validator}) {
  return TypeAheadFormField(
    textFieldConfiguration: TextFieldConfiguration(
        controller: TextEditingController(text: value.current),
        keyboardAppearance: Theme.of(context).brightness,
        textInputAction: TextInputAction.next,
        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        onChanged: onChanged,
        focusNode: value.focus,
        decoration: textInputDecoration(value)),
    suggestionsCallback: (pattern) {
      return property.foreignKeyOf.client
          .getPkDistinctValues(property.foreignKeyOf, pattern: pattern);
    },
    itemBuilder: (context, suggestion) {
      return ListTile(
        title: Text(suggestion),
      );
    },
    hideOnEmpty: true,
    transitionBuilder: (context, suggestionsBox, controller) {
      return suggestionsBox;
    },
    onSuggestionSelected: onSuggestionSelected,
    validator: validator,
  );
}

InputDecoration textInputDecoration(ValueLV value) {
  return InputDecoration(
      hintMaxLines: 1,
      hintText: value.last != null ? value.last.toString() : "");
}

InputDecoration dateTimeField(
    {bool showDate,
    bool showTime,
    BuildContext context,
    ValueLV value,
    Function(dynamic) onChanged}) {
  if (!showDate && !showTime) throw Exception("Nonsense dateTimeField");
  DateFormat format = DateFormat(
      "${showDate ? "yyyy-MM-dd" : ""}${showTime && showDate ? " " : ""}${showTime ? "HH:mm" : ""}");

  return InputDecoration(
      hintMaxLines: 1,
      hintText: value.last != null ? value.toString() : "");
}
