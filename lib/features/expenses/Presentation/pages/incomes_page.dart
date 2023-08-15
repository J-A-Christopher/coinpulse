import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../providers/expense_provider.dart';
import '../../../../utils/colors.dart';

class IncomesWidget extends StatelessWidget {
  const IncomesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(builder: (context, notifier, child) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.38,
        child: ListView.separated(
            itemBuilder: (context, index) {
              final expenseItem = notifier.incomeList[index];
              final convertDate = expenseItem.createdTime;
              final cDate = DateFormat.yMMMEd().format(convertDate);
              final cTime = DateFormat.jm().format(convertDate);
              return ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: ColorsUsed.primaryColor,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(expenseItem.incomeTitle),
                    Text(cDate),
                  ],
                ),
                trailing: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Column(
                    children: [
                      Text(
                        '-ksh ${expenseItem.incomeAmount}',
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
                height: 1,
                color: Colors.grey[700],
              );
            },
            itemCount: notifier.incomeList.length),
      );
    });
  }
}
