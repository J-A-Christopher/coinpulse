import 'package:bloc/bloc.dart';
import 'package:coinpulse/features/expenses/Domain/dataprovider/apigeter.dart';
import 'package:equatable/equatable.dart';

import '../../Domain/models/expenses_model.dart';

part 'expenses_event.dart';
part 'expenses_state.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  ExpensesBloc() : super(ExpensesInitial()) {
    on<CreateExpense>((event, emit) async {
      final apigetter = ApiGetter();

      try {
        emit(ExpensesCreating());
        final response = await apigetter.createExpense(event.expenses);

        emit(ExpensesCreated(expenseMoadel: response));

        emit(ExpenseLoaded(loadedExpenses: apigetter.expenseitems));
      } catch (error) {
        emit(ExpensesError(errorMessage: 'Sorry Something went wrong'));
      }
    });
  }
}
