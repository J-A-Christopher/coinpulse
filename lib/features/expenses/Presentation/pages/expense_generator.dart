import 'package:coinpulse/providers/expense_provider.dart';
import 'package:coinpulse/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenseGenerator extends StatefulWidget {
  const ExpenseGenerator({super.key});

  @override
  State<ExpenseGenerator> createState() => _ExpenseGeneratorState();
}

class _ExpenseGeneratorState extends State<ExpenseGenerator> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<ExpenseProvider>(context, listen: false)
            .fetchandSetPExpenses(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Consumer<ExpenseProvider>(builder: (context, notifier, child) {
                return notifier.expenseList.isEmpty
                    ? Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 80, horizontal: 30),
                        child: const Text(
                          'No Transactions to display. Click the plus button to add something...',
                          style: TextStyle(
                              color: ColorsUsed.secondaryColor, fontSize: 18),
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.38,
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              final expenseItem = notifier.expenseList[index];
                              final convertDate = expenseItem.createdDate;
                              final cDate =
                                  DateFormat.yMMMEd().format(convertDate);
                              final cTime = DateFormat.jm().format(convertDate);

                              return ListTile(
                                leading: const CircleAvatar(
                                  backgroundColor: ColorsUsed.secondaryColor,
                                  child: Icon(
                                    Icons.camera,
                                    color: ColorsUsed.primaryColor,
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(expenseItem.title),
                                    Text(cDate),
                                  ],
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '-ksh ${expenseItem.amount}',
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(cTime)
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: 7,
                                color: Colors.grey[700],
                              );
                            },
                            itemCount: notifier.expenseList.length),
                      );
              }));
  }
}
