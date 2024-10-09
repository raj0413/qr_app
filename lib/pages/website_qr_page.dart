import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:permission_handler/permission_handler.dart'; // Import permission handler

class WebsiteQrPage extends StatefulWidget {
  const WebsiteQrPage({super.key});

  @override
  State<WebsiteQrPage> createState() => _WebsiteQrPageState();
}

class _WebsiteQrPageState extends State<WebsiteQrPage> {
  TextEditingController textcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // ScreenshotController to capture QR code image
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Website"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: textcontroller,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      labelText: 'Enter Website URL',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a URL';
                      }

                      // URL validation
                      final urlPattern =
                          r'^(https?:\/\/)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:[0-9]{1,5})?(\/.*)?$';
                      final urlRegex = RegExp(urlPattern);

                      if (!urlRegex.hasMatch(value)) {
                        return 'Please enter a valid website URL';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {});
                        }
                      },
                      child: const Text(
                        "Generate QR",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // QR code with screenshot capture
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 4),
                        borderRadius: BorderRadius.circular(8)),
                    child: Screenshot(
                      controller: _screenshotController,
                      child: QrImageView(
                        data: textcontroller.text,
                        size: 300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
