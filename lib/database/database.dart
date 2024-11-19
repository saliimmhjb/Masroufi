import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class masroufiDataBase {
  List expensesList = [
    // typeName, Time, amount, icon
  ];

  final _myBox = Hive.box("myBox");

  void createIntialData()
  {
    expensesList = [
      ["Masroufi App", "8.15PM", 0.0, Icons.download_done_outlined],
    ];
  }

  void loadData()
  {
    expensesList = _myBox.get("TODOLIST");

  }

  void updateData()
  {
    _myBox.put("TODOLIST", expensesList);
  }
}