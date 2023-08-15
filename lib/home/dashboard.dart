import 'package:coinpulse/features/expenses/Domain/models/expenses_model.dart';
import 'package:coinpulse/providers/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/expenses/Presentation/pages/expense_generator.dart';
import '../utils/colors.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  TextEditingController incomeValue = TextEditingController();
  String? displayedIncome = 'N/A';
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  ExpenseModel newExpense = ExpenseModel(
      amount: '',
      createdDate: DateTime.now(),
      title: '',
      id: DateTime.now().toString());

  void showExpenseDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Expense Details'),
            content: Form(
                key: _formState,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        newExpense = ExpenseModel(
                            amount: newExpense.amount,
                            createdDate: DateTime.now(),
                            title: value!,
                            id: DateTime.now().toString());
                      },
                      decoration:
                          const InputDecoration(hintText: 'Expense title'),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      onSaved: (value) {
                        newExpense = ExpenseModel(
                            amount: value!,
                            createdDate: DateTime.now(),
                            title: newExpense.title,
                            id: DateTime.now().toString());
                      },
                      decoration:
                          const InputDecoration(hintText: 'Expense amount'),
                    )
                  ],
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(onPressed: submitForm, child: const Text('Submit'))
            ],
          );
        });
  }

  void submitForm() {
    _formState.currentState!.save();
    Provider.of<ExpenseProvider>(context, listen: false)
        .createExpense(newExpense);
    Provider.of<ExpenseProvider>(context, listen: false).tAmount;

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showExpenseDialog,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: ColorsUsed.secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Column(
                              children: [
                                Text(
                                  'Total Balance (Ksh)',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  'Ksh 200',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 60,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    'Income (Ksh)',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Fill in your income:'),
                                              content: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Input cannot be empty';
                                                  }
                                                  return null;
                                                },
                                                controller: incomeValue,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Amount',
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child:
                                                        const Text('Cancel')),
                                                TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if (incomeValue
                                                            .text.isNotEmpty) {
                                                          displayedIncome =
                                                              incomeValue.text;
                                                        } else {
                                                          displayedIncome =
                                                              'N/A';
                                                        }
                                                      });
                                                      if (incomeValue
                                                          .text.isNotEmpty) {
                                                        incomeValue.text = '';
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                    child: const Text('Submit'))
                                              ],
                                            );
                                          });
                                    },
                                    child: Text(
                                        'Ksh: ${displayedIncome ?? 'N/A'}',
                                        style: const TextStyle(
                                            fontSize: 25, color: Colors.white)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        //Text('Total Expenses: $totalExpenses')
                      ],
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 22),
                ),
                TextButton(onPressed: () {}, child: const Text('See All'))
              ],
            ),
          ),
          const ExpenseGenerator(),
        ],
      ),
    );
  }
}
