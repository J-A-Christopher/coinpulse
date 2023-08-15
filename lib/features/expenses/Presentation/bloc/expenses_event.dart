part of 'expenses_bloc.dart';

abstract class ExpensesEvent extends Equatable {
  final ExpenseModel expenses;

  const ExpensesEvent({required this.expenses});

  @override
  List<Object> get props => [expenses];
}

class CreateExpense extends ExpensesEvent {
  const CreateExpense({required super.expenses});

  @override
  List<Object?> get params => [expenses];
}
