import '../../Domain/models/expenses_model.dart';

class DataProvider {
//List Initializer
  List<ExpenseModel> expenseList = [];

  //Creation of an expense
  void createExpense(ExpenseModel model) {
    final modelCreation = ExpenseModel(
        amount: model.amount,
        createdDate: model.createdDate,
        title: model.title,
        id: model.id);
    expenseList.add(modelCreation);

    print(expenseList.first.title);
    print(expenseList.first.amount);
    print(expenseList.first.createdDate);
    print(expenseList.first.id);
  }
}
