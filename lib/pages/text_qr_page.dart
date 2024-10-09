import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TextQrPage extends StatefulWidget {
  const TextQrPage({super.key});

  @override
  State<TextQrPage> createState() => _TextQrPageState();
}

class _TextQrPageState extends State<TextQrPage> {
  TextEditingController textcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key to manage form state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text"),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              key: _formKey, // Assign the form key
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
                        borderSide: BorderSide(color: Colors.black, width: 2),
                      ),
                      labelText: 'Enter Text',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                    
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                     final urlPattern =
                          r'^(https?:\/\/)?([a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+.*)$';
                      final urlRegex = RegExp(urlPattern);
                      if (urlRegex.hasMatch(value)) {
                        return 'Please enter text, not a URL';
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
                          setState(() {
                            
                          });
                        }
                      },
                      child: const Text("Generate QR"),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 4),
                        borderRadius: BorderRadius.circular(8)),
                    child: QrImageView(
                      data: textcontroller.text,
                      size: 300,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
