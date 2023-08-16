import 'package:coinpulse/features/expenses/Domain/models/expenses_model.dart';
import 'package:coinpulse/features/expenses/Presentation/Domain/models/income_model.dart';
import 'package:coinpulse/home/screens/tab_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/expense_provider.dart';
import '../utils/colors.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  TextEditingController incomeValue = TextEditingController();
  String displayedIncome = '0';
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  final GlobalKey<FormState> _incomeForm = GlobalKey<FormState>();
  ExpenseModel newExpense = ExpenseModel(
      amount: '',
      createdDate: DateTime.now(),
      title: '',
      id: DateTime.now().toString());

  IncomeModel incomeModel = IncomeModel(
      createdTime: DateTime.now(),
      incomeAmount: 0,
      incomeTitle: '',
      id: DateTime.now().toString());

  void createIncome() {
    _incomeForm.currentState!.save();
    Provider.of<ExpenseProvider>(context, listen: false)
        .createIncome(incomeModel);
    _incomeForm.currentState!.reset();

    Navigator.of(context).pop();
  }

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
                            Column(
                              children: [
                                const Text(
                                  'Total Balance (Ksh)',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Consumer<ExpenseProvider>(
                                    builder: (context, notifier, child) {
                                  final income = notifier.totalIncome;
                                  final expenses = notifier.tAmount;

                                  final result = income > expenses
                                      ? (income) - (expenses)
                                      : 'OverBudget';

                                  return income == expenses
                                      ? const Text('Ksh: 0',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white))
                                      : Text(
                                          '$result',
                                          style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.white),
                                        );
                                }),
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
                                  GestureDetector(onTap: () {
                                    showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Fill in your income:'),
                                            content: Form(
                                              key: _incomeForm,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    onSaved: (value) {
                                                      incomeModel = IncomeModel(
                                                          createdTime:
                                                              DateTime.now(),
                                                          incomeAmount:
                                                              incomeModel
                                                                  .incomeAmount,
                                                          incomeTitle:
                                                              value ?? '',
                                                          id: DateTime.now()
                                                              .toString());
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Income title e.g salary'),
                                                  ),
                                                  TextFormField(
                                                    onSaved: (value) {
                                                      incomeModel = IncomeModel(
                                                          createdTime:
                                                              DateTime.now(),
                                                          incomeAmount:
                                                              int.parse(
                                                                  value ?? ''),
                                                          incomeTitle:
                                                              incomeModel
                                                                  .incomeTitle,
                                                          id: DateTime.now()
                                                              .toString());
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
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
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Cancel')),
                                              TextButton(
                                                  onPressed: () {
                                                    createIncome();
                                                  },
                                                  child: const Text('Submit'))
                                            ],
                                          );
                                        });
                                  }, child: Consumer<ExpenseProvider>(
                                      builder: (context, notifier, child) {
                                    return Text('Ksh: ${notifier.totalIncome} ',
                                        style: const TextStyle(
                                            fontSize: 25, color: Colors.white));
                                  }))
                                ],
                              ),
                            )
                          ],
                        ),
                        Consumer<ExpenseProvider>(
                            builder: (context, notifier, child) {
                          return Column(
                            children: [
                              const Text(
                                'Total Expenses',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                'Ksh: ${notifier.tAmount}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25),
                              )
                            ],
                          );
                        })
                      ],
                    ),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 20),
                ),
                TextButton(onPressed: () {}, child: const Text('See all'))
              ],
            ),
          ),
          const MyWidget(),
        ],
      ),
    );
  }
}
