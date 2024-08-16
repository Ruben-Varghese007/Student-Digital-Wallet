import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scan/scan.dart' as scan;
import '../../router.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dimens.dart';
import '../../utils/app_images.dart';
import '../../widgets/custom_widget_button.dart';
import '../../widgets/stagger_animated_widget.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) async {
      await processQRCode(scanData, controller);
    });
  }

  Future<void> _pickImage() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.any);
    if (result?.files.single.path != null) {
      String? resultDataFromImage = await scan.Scan.parse(result!.files.single.path!);
      await processQRCode(Barcode(resultDataFromImage, BarcodeFormat.qrcode, []), controller);
    }
  }

  Future<void> processQRCode(Barcode scanData, QRViewController controller) async {
    if (scanData.code?.isNotEmpty ?? false) {
      try {
        int billingAmount = int.parse(scanData.code!);

        // Display a notification with the billing amount
        showBillingAmountNotification(billingAmount);

        // Continue with any additional logic
        // ...
      } catch (e) {
        print('Error parsing QR code data: $e');
      }
    }
  }

  void showBillingAmountNotification(int billingAmount) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow tapping outside the dialog to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Billing Amount'),
          content: Text('Token Bill: $billingAmount'),
          actions: [
            TextButton(
              onPressed: () {
                // Pop the billing amount dialog
                Navigator.of(context).pop();
                // Navigate to the Notifications Screen
                Navigator.of(context).pushNamedAndRemoveUntil(Routes.homeScreen, (route) => false);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderRadius: 15,
              borderColor: Colors.white,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
          StaggerAnimatedWidget(animation: "Scale", children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(bottom: 400, left: 15, right: 15),
                child: const Text(
                  "Scan QR Code For Payment",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ]),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // animatedAppBarLabel("Scan", context),
                StaggerAnimatedWidget(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      leading: InkWell(
                        child: Image.asset(
                          AppImages.icBack,
                          color: AppColors.colorWhite,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      centerTitle: true,
                      title: const Text(
                        'Scan',
                        // style: AppFont.colorWhite_18,
                        textAlign: TextAlign.center,
                      ),
                      elevation: 0,
                    ),
                  ],
                ),
                StaggerAnimatedWidget(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomWidgetButton(
                            height: 54,
                            width: 54,
                            borderRadius: 27,
                            backgroundColor: AppColors.colorWhite18,
                            child: Image.asset(
                              AppImages.icTorch,
                              height: Dimens.margin32,
                              width: Dimens.margin32,
                              color: isFlashOn ? Colors.green : Colors.white,
                            ),
                            onPressed: () {
                              controller.toggleFlash();
                              setState(() {
                                isFlashOn = !isFlashOn;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CustomWidgetButton(
                            height: 54,
                            width: 54,
                            borderRadius: 27,
                            backgroundColor: AppColors.colorWhite18,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                AppImages.icImage,
                                height: Dimens.margin20,
                                width: Dimens.margin20,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () {
                              _pickImage();
                            },
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          CustomWidgetButton(
                            height: 54,
                            width: 54,
                            borderRadius: 27,
                            backgroundColor: AppColors.colorWhite18,
                            child: Image.asset(
                              AppImages.icSwitchCam,
                              height: Dimens.margin32,
                              width: Dimens.margin32,
                            ),
                            onPressed: () {
                              controller.flipCamera();
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

