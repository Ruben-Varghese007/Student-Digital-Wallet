import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_digital_wallet/screens/login_screen.dart';
import 'package:student_digital_wallet/screens/profile_screen.dart';

import '../models/transaction.dart';
import '../router.dart';
import '../utils/app_colors.dart';
import '../utils/app_dimens.dart';
import '../utils/app_font.dart';
import '../utils/app_images.dart';
import '../utils/themes.dart';
import '../widgets/custom_widget_button.dart';
import '../widgets/transaction_detail.dart';
import '../widgets/transaction_item.dart';
import 'notification_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 10000.0; //Initial Balance

  void updateBalance(double amount) {
    setState(() {
      balance -= amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert), // Add an icon to the button
              offset: const Offset(0, 50), // Adjust the offset to move the menu down
              onSelected: (choice) {
                if (choice == 'Profile') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                } else if (choice == 'Settings') {
                  // Navigate to the Settings Page
                  // Implement your settings page here
                } else if (choice == 'Logout') {
                  FirebaseAuth.instance.signOut().then((value) {
                    print("Signed Out");
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  });
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'Profile',
                    child: ListTile(
                      leading: Icon(Icons.person), // Add a profile icon
                      title: Text(
                        'Profile',
                          style: TextStyle(fontSize: 20)
                      ),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Settings',
                    child: ListTile(
                      leading: Icon(Icons.settings), // Add a settings icon
                      title: Text(
                        'Settings',
                          style: TextStyle(fontSize: 20)
                      ),
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Logout',
                    child: ListTile(
                      leading: Icon(Icons.logout), // Add a logout icon
                      title: Text(
                        'Logout',
                          style: TextStyle(fontSize: 20)
                      ),
                    ),
                  ),
                ];
              },
            ),
            const Text(
              "Student Digital Wallet",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.white60,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Stack(
                      children: [
                        Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                        Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: Icon(
                            Icons.brightness_1,
                            size: 8.0,
                            color: Colors.redAccent,
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => NotificationPage(onPaymentConfirmed: updateBalance),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: const Column(
                children: [
                  Text(
                    "BALANCE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "10,000 Tokens",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 25,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Recent Transactions",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF3D538F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext ctx) {
                                  return const DetailTransactionScreen();
                                },
                              );
                            },
                            child: const Text(
                              'View All',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF3D538F),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return TransactionItem(
                            transaction: transactions[index],
                          );
                        },
                        itemCount: transactions.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomWidgetButton(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.35,
        borderRadius: 100,
        onPressed: () async {
          await Navigator.of(context).pushNamed(Routes.scan);
        },
        backgroundColor: AppColors.colorPrimary,
        child: Container(
          padding: const EdgeInsets.only(left: Dimens.margin24, right: Dimens.margin16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Scan QR',
                style: AppFont.colorWhite_14,
              ),
              width5,
              Image.asset(
                AppImages.icScanner,
                height: Dimens.margin20,
                width: Dimens.margin20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}




