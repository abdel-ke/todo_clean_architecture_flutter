import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class TodoEntity extends Equatable {
  static int lastId = 0;
  final int? id;
  String title;
  String description;
  bool isDone = false;

  TodoEntity({required this.title, required this.description}): id = ++lastId;


  @override
  List<Object?> get props => [id, title, description, isDone];

  // TodoEntity copyWith({String? title, String? description, bool? isDone}) {
  //   return TodoEntity(
  //     title: title ?? this.title,
  //     description: description ?? this.description,
  //   )..isDone = isDone ?? this.isDone;
  // }
}
