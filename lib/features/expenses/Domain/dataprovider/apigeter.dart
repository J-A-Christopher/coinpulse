import 'package:coinpulse/features/expenses/Data/Repositories/data_repository.dart';
import 'package:injectable/injectable.dart';

import '../models/expenses_model.dart';

@injectable
class ApiGetter {
  final _dataProvider = DataProvider();
  List<ExpenseModel> get expenseitems => _dataProvider.expenseList;

  //retrieve method create expense from data Provider

  createExpense(ExpenseModel model) {
    return _dataProvider.createExpense(model);
  }
}
