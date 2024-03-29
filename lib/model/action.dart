import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

enum ActionType { InsertInto, EditLastFrom, CreateWidgetFrom }

class Action extends Equatable {
  const Action._(this.title, this.type, this.bgColor, this.textColor, this.floatButColor);

  factory Action (ActionType type, Color primaryColor, Color textColor, Brightness brightness) {
    final title = ReCase(type.toString().split(".").last)
        .sentenceCase
        .toUpperCase();
    final floatButColor = brightness == Brightness.light ? primaryColor : textColor;
    return Action._(title, type, primaryColor, textColor, floatButColor);
  }

  final String title;
  final ActionType type;
  final Color bgColor;
  final Color textColor;
  final Color floatButColor;

  @override
  List<Object> get props => [type];
}
