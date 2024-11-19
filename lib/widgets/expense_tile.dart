import 'package:flutter/material.dart';
import 'package:masroufi/database/database.dart';

class ExpenseTile extends StatelessWidget {



  final double expenseAmount;
  final String expenseType;
  final String expenseDate;
  final IconData expenseIcon;

  ExpenseTile({super.key, required this.expenseAmount, required this.expenseType, required this.expenseDate, required this.expenseIcon});



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: Icon(expenseIcon,
            color: Theme.of(context).iconTheme.color),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseType,
              style: Theme.of(context)
                  .textTheme
                  .overline!
                  .copyWith(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              expenseDate,
              style: Theme.of(context)
                  .textTheme
                  .overline!
                  .copyWith(
                color: Colors.black.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        trailing: Text(
          '${expenseAmount.toString()}DT',
          style: Theme.of(context)
              .textTheme
              .overline!
              .copyWith(
            color: Colors.redAccent,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}


