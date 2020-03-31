import 'package:bitacora/utils/db_parameter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:bitacora/model/property.dart';
import 'package:tuple/tuple.dart';
import 'date_picker.dart';
import 'package:recase/recase.dart';
import 'package:bitacora/conf/style.dart' as app;

class FormFieldView<T> extends StatefulWidget {
  FormFieldView(this.param, this.controller);

  final DbParameter param;
  final ValueNotifier controller;

  @override
  State<StatefulWidget> createState() => _FormFieldViewState();
}

/// keep alive when out of view (to not lose state)
class _FormFieldViewState extends State<FormFieldView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.param.title,
            style: new TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
          buildInput(widget.param)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  String validator(value) {
    if (value.isEmpty) {
      return "Field can't be null";
    }
    return null;
  }

  Widget buildInput(DbParameter param) {
    // TODO use same names as the defined
    if (param is Host || param is Username || param is DatabaseName || param is Port) {
      return TextFormField(
          controller: widget.controller,
          validator: validator,
          textInputAction: TextInputAction.next,
          keyboardType: param is Port ? TextInputType.number : TextInputType.text,
          onFieldSubmitted: (v) {
            FocusScope.of(context).nextFocus();
          },
          decoration:
              new InputDecoration.collapsed(hintText: param.defaultValue.toString()));
    }
    else if (param is Password) {
      return TextFormField(
          controller: widget.controller,
          validator: validator,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (v) {
            FocusScope.of(context).nextFocus();
          },
          obscureText: true,
          decoration:
          new InputDecoration.collapsed(hintText: param.defaultValue));
    }
    else
      throw Exception;
  }
}