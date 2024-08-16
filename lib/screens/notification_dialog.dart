import 'package:flutter/material.dart';
import '../router.dart';

class NotificationPage extends StatefulWidget {

  final Function(double) onPaymentConfirmed;
  const NotificationPage({Key? key, required this.onPaymentConfirmed}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool paymentConfirmed = false;
  bool paymentRejected = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0), // Add space between messages
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: paymentRejected
                    ? Colors.red
                    : (paymentConfirmed ? Colors.green : Colors.orangeAccent),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bay Store - Tok. 120.00\n${paymentRejected ? 'Payment Rejected' : (paymentConfirmed ? 'Payment Complete' : 'Payment Pending')}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0), // Add space between messages and buttons
                  if (!paymentConfirmed && !paymentRejected)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Change the payment status to "Payment Complete"
                            setState(() {
                              paymentConfirmed = true;
                            });
                            widget.onPaymentConfirmed(120.0);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('Confirm'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Change the payment status to "Payment Rejected"
                            setState(() {
                              paymentRejected = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Reject'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.maxFinite,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.green, // Fixed color for the second container
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Garage Cafe - Tok. 350.00\nPayment Complete',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

