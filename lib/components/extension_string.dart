

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

extension CapitalizeExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension ColorExtension on String {
  Color toColor() {
    String _str = this.replaceAll("#", "");
    Color _color = Colors.grey;
    if (_str.length == 6) _str = "FF$_str";
    if (_str.length == 8) _color = Color(int.parse("0x$_str"));
    return _color;
  }
}

extension Digit4Extension on String {
  String format4Digits() =>
      "${this.substring(0, 4)} ${this.substring(4, 8)} ${this.substring(8, 12)} ${this.substring(12)}";
}

extension AndroidUpperCaseExtension on String {
  String toUpperCaseIfAndroid() =>
      (Platform.isAndroid) ? this.toUpperCase() : this;
}

// base64 - pipe64
extension Pine64Extension on String {
  String encodeBase64ToPipe64() {
    // знаки "=" убираем, а их кол-во ставим впереди строки
    final int _q = replaceFirst(RegExp(r'[^=]+'), '').length;
    return _q.toString() + substring(0, this.length - _q);
  }

  String decodePipe64ToBase64() {
    // 1й символ это кол-во "=" в конце
    int _q = 0;
    try {
      _q = int.parse(this.substring(0, 1));
      return this.substring(1, this.length) + ("=" * _q);
    } catch (_) {
      return "";
    }
  }

  String encodeStringToPipe64() {
    String? _s;
    try {
      _s = base64.encode(utf8.encode(this)).encodeBase64ToPipe64();
    } catch (_) {}
    return _s ?? "";
  }

  String decodePipe64ToString() {
    String? _s;
    try {
      _s = utf8.decode(base64.decode(this.decodePipe64ToBase64()));
    } catch (_) {}
    return _s ?? "";
  }
}
