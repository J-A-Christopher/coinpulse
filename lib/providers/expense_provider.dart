import 'package:flutter/material.dart';

import '../features/expenses/Domain/models/expenses_model.dart';
import '../features/expenses/Presentation/Domain/models/income_model.dart';

class ExpenseProvider with ChangeNotifier {
  //Empty list initializer for expenselist
  final List<ExpenseModel> _expenseList = [];

  //Empty list initializer for an incomelist
  final List<IncomeModel> _incomeList = [];

  //income list getter
  List<IncomeModel> get incomeList => [..._incomeList];

//Getter that returns the original list and alows outside modification
  List<ExpenseModel> get expenseList => [..._expenseList];

  int get tAmount {
    int totalExpenses = 0;
    final amount =
        _expenseList.map((expenses) => int.tryParse(expenses.amount)).toList();
    totalExpenses =
        amount.fold(0, (previousValue, element) => previousValue + element!);
    notifyListeners();
    //print(totalExpenses);

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

  //Creation of an income entry
  void createIncome(IncomeModel model) {
    final income = IncomeModel(
        createdTime: model.createdTime,
        incomeAmount: model.incomeAmount,
        incomeTitle: model.incomeTitle,
        id: model.id);
    _incomeList.add(income);

    notifyListeners();
  }

  //using fold to loop over all the income amounts to get the total
  int get totalIncome {
    int totalIncomeadd = 0;
    List<int> totalIncome =
        _incomeList.map((incomes) => incomes.incomeAmount).toList();
    totalIncomeadd = totalIncome.fold(
        0, (previousValue, element) => previousValue + element);
    notifyListeners();
    return totalIncomeadd;
  }
}
