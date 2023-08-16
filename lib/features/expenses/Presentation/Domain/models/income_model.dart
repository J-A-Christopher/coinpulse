class IncomeModel {
  String id;
  String incomeTitle;
  int incomeAmount;
  DateTime createdTime;
  IncomeModel(
      {required this.createdTime,
      required this.incomeAmount,
      required this.incomeTitle,
      required this.id});
}
