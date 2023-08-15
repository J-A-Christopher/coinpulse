import 'package:flutter/material.dart';

import '../features/expenses/Domain/models/expenses_model.dart';

class ExpenseProvider with ChangeNotifier {
  final List<ExpenseModel> _expenseList = [];

//Getter that returns the original list and alows outside modification
  List<ExpenseModel> get expenseList => [..._expenseList];

  int get tAmount {
    int totalExpenses = 0;
    final amount =
        _expenseList.map((expenses) => int.tryParse(expenses.amount)).toList();
    totalExpenses =
        amount.fold(0, (previousValue, element) => previousValue + element!);
    notifyListeners();
    print(totalExpenses);

    return totalExpenses;
  }

  //Creation of an expense
  void createExpense(ExpenseModel model) {
    final modelCreation = ExpenseModel(
        amount: model.amount,
        createdDate: model.createdDate,
        title: model.title,
        id: model.id);
    _expenseList.add(modelCreation);
    notifyListeners();
  }
}
