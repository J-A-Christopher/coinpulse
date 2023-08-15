part of 'expenses_bloc.dart';

sealed class ExpensesState extends Equatable {
  const ExpensesState();

  @override
  List<Object> get props => [];
}

final class ExpensesInitial extends ExpensesState {}

final class ExpensesCreating extends ExpensesState {}

final class ExpensesCreated extends ExpensesState {
  final ExpenseModel expenseMoadel;
  const ExpensesCreated({required this.expenseMoadel});
}

final class ExpenseLoaded extends ExpensesState {
  final List<ExpenseModel> loadedExpenses;
  const ExpenseLoaded({required this.loadedExpenses});
}

final class ExpensesError extends ExpensesState {
  String errorMessage;
  ExpensesError({required this.errorMessage});
}
