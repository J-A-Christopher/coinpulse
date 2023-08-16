import 'package:coinpulse/features/expenses/Presentation/pages/expense_generator.dart';
import 'package:flutter/material.dart';

import '../../features/expenses/Presentation/pages/incomes_page.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.38,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: const Color(0xfff8f6f0),
            body: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    bottom: const TabBar(
                        indicatorSize: TabBarIndicatorSize.label,
                        isScrollable: true,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            text: 'Expenses',
                          ),
                          Tab(
                            text: 'Incomes',
                          ),
                        ]),
                  ),
                ),
                const Expanded(
                    child: TabBarView(
                        children: [ExpenseGenerator(), IncomesWidget()])),
              ],
            )),
      ),
    );
  }
}
