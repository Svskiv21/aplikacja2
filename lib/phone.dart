import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Phone {
  final int? id;
  final String producent;
  final String model;
  final String wersjaOprogramowania;
  final String photoUrl;

  const Phone({
    required this.id,
    required this.producent,
    required this.model,
    required this.wersjaOprogramowania,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'producent': producent,
      'model': model,
      'wersjaOprogramowania': wersjaOprogramowania,
      'photoUrl': photoUrl,
    };
  }
}
