import 'package:coinpulse/features/expenses/Presentation/bloc/expenses_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseGenerator extends StatelessWidget {
  const ExpenseGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpensesBloc, ExpensesState>(builder: (context, state) {
      if (state is ExpensesCreating) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is ExpenseLoaded) {
        print(state.loadedExpenses.first.title);
        return Text(state.loadedExpenses.first.title);
      }
      // if (state is ExpensesError) {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text('An error occured ')));
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return const AlertDialog(
      //         title: Text('Error'),
      //         content: Text('An error occured try again later'),
      //       );
      //     });
      // }

      return const SizedBox.shrink();
    });
  }
}
