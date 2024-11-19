import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:masroufi/database/database.dart';
import 'package:masroufi/screens/about_masroufi.dart';
import 'package:masroufi/screens/componenets/new_expense.dart';
import 'package:masroufi/widgets/expense_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    calculateTotalAmount();
    if (_myBox.get("TODOLIST") == null) {
      db.createIntialData();
    } else {
      db.loadData();
    }
    calculateTotalAmount();
    super.initState();
  }
  @override
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  String choosenType = "Random";
  double totalAmount = 0.0;

  IconData iconFromType = Icons.payments_outlined;

  masroufiDataBase db = masroufiDataBase();

  final _myBox = Hive.box("mybox");

  void createNewExpense() {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              title: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (_) => AboutMasroufi(),
                  ),
                ),
                child: Text(
                  "Masroufi".toUpperCase(),
                  style: Theme.of(context).textTheme.overline!.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              centerTitle: true,
              elevation: 0,
              toolbarHeight: 60,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Today at Thu Mar 07 2024",
                  style: Theme.of(context).textTheme.overline!.copyWith(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w300,
                      ),
                ),
                TextField(
                  controller: amountController,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .overline!
                      .copyWith(fontSize: 40, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  maxLength: 9,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      //isCollapsed: true,
                      hintText: "0"),
                ),
                Icon(
                  Icons.arrow_downward,
                  size: 30,
                  color: Colors.black.withOpacity(0.5),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent.withOpacity(0.7),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                "Cancel",
                                style: Theme.of(context).textTheme.overline!.copyWith(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16), // Add space between buttons
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black,
                            ),
                            onPressed: saveNewExpense,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                "Next",
                                style: Theme.of(context).textTheme.overline!.copyWith(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                )
              ],
            ),
          );
        });
  }

  void calculateTotalAmount() {

    for (var expense in db.expensesList) {
      totalAmount += expense[2];
    }

  }


  void saveNewExpense() {
    if (amountController.text.isNotEmpty) {
      changeExpenseType();
    }
  }

  void changeExpenseType() {
    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            title: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => AboutMasroufi(),
                ),
              ),
              child: Text(
                "Masroufi".toUpperCase(),
                style: Theme.of(context).textTheme.overline!.copyWith(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            centerTitle: true,
            elevation: 0,
            toolbarHeight: 60,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "Write your expense description",
                  style: Theme.of(context).textTheme.overline!.copyWith(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w300,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  controller: descriptionController,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .overline!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                  maxLines: 1,
                  maxLength: 25,
                  decoration: InputDecoration(
                    hintText: "I bought a Pizza!",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,15,10,15),
                child: Text(
                  "Choose your expense type",
                  style: Theme.of(context).textTheme.overline!.copyWith(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w300,
                      ),
                ),
              ),
              Container(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.count(
                    crossAxisCount: 4,
                    padding: EdgeInsets.all(12),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 20,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => setExpenseType("Food"),
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.local_pizza_outlined,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Food",
                            style:
                                Theme.of(context).textTheme.overline!.copyWith(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => setExpenseType("Health"),
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.health_and_safety_outlined,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Health",
                            style:
                                Theme.of(context).textTheme.overline!.copyWith(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => setExpenseType("Gift"),
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.card_giftcard,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Gift",
                            style:
                                Theme.of(context).textTheme.overline!.copyWith(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => setExpenseType("Vacation"),
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.beach_access_outlined,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Vacation",
                            style:
                                Theme.of(context).textTheme.overline!.copyWith(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => setExpenseType("Education"),
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.school_outlined,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Education",
                            style:
                                Theme.of(context).textTheme.overline!.copyWith(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => setExpenseType("Clothes"),
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.checkroom,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Clothes",
                            style:
                                Theme.of(context).textTheme.overline!.copyWith(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => setExpenseType("Rent"),
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.house_outlined,
                                size: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Rent",
                            style:
                                Theme.of(context).textTheme.overline!.copyWith(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => setExpenseType("Coffee"),
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: Icon(
                                Icons.coffee_outlined,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Coffee",
                            style:
                                Theme.of(context).textTheme.overline!.copyWith(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  minimumSize: Size(125, 40),
                ),
                onPressed: () => confirmExpenseSettings(),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    "Confirm",
                    style: Theme.of(context)
                        .textTheme
                        .overline!
                        .copyWith(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void confirmExpenseSettings()
  {
    selectedIconFromData();
    if (descriptionController.text.isNotEmpty) {
    setState(() {
      db.expensesList
          .add([choosenType, "05:08PM", double.parse(amountController.text), iconFromType]);
    });
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    amountController.clear();
    descriptionController.clear();
    db.updateData();
    calculateTotalAmount();
    }
  }

  void setExpenseType(String type) {
    if (type == type) {
      choosenType = type;
    }
    else {
      choosenType = "Random";
    }
  }

  void selectedIconFromData()
  {
    if (choosenType == "Food") {
      iconFromType = Icons.local_pizza_outlined;
    }
    else if (choosenType == "Health") {
      iconFromType = Icons.health_and_safety_outlined;
    }
    else if (choosenType == "Gift") {
      iconFromType = Icons.card_giftcard_outlined;
    }
    else if (choosenType == "Vacation") {
      iconFromType = Icons.beach_access_outlined;
    }
    else if (choosenType == "Education") {
      iconFromType = Icons.school_outlined;
    }
    else if (choosenType == "Clothes") {
      iconFromType = Icons.checkroom;
    }
    else if (choosenType == "Rent") {
      iconFromType = Icons.house_outlined;
    }
    else if (choosenType == "Coffee") {
      iconFromType = Icons.coffee_outlined;
    }
    else {
      iconFromType = Icons.payments_outlined;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /*leading: Icon(
          Icons.account_circle_outlined,
          color: Theme.of(context).iconTheme.color,
        ),*/
        title: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => AboutMasroufi(),
            ),
          ),
          child: Text(
            "Masroufi".toUpperCase(),
            style: Theme.of(context).textTheme.overline!.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 60,
        /*actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 11),
            child: Icon(
              Icons.analytics_outlined,
              color: Theme.of(context).iconTheme.color,
              size: 25,
            ),
          ),
        ],*/
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: Colors.redAccent,
        onPressed: createNewExpense,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 37,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Spent amount",
                      style: Theme.of(context).textTheme.overline!.copyWith(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                    ),
                    Text(
                      '-${totalAmount.toStringAsFixed(2)}DT',
                      style: Theme.of(context).textTheme.overline!.copyWith(
                            color: Colors.redAccent,
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Histroy",
                            style:
                                Theme.of(context).textTheme.overline!.copyWith(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '-${totalAmount.toStringAsFixed(2)}DT',
                            textAlign: TextAlign.end,
                            style:
                                Theme.of(context).textTheme.overline!.copyWith(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 260,
                      child: Stack(
                        children: [
                          ListView.builder(
                            itemCount: db.expensesList.length,
                            itemBuilder: (context, index) {
                              return ExpenseTile(
                                expenseType: db.expensesList[index][0],
                                expenseDate: db.expensesList[index][1],
                                expenseAmount: db.expensesList[index][2],
                                expenseIcon: db.expensesList[index][3],
                              );
                            },
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              height: 5.0,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.white.withOpacity(0.1),
                                      Colors.white,
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
