import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

class QRScanPage extends StatefulWidget {
  final Function(String, String) onSave;

  const QRScanPage({super.key, required this.onSave});

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("QR Scanner"),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 22,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
                Center(
                  child: Lottie.asset(
                    'assets/Animation - 1728193676900.json',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code;
        _showPopup(qrText!);
      });
    });
  }

  void _showPopup(String data) {
    if (_isURL(data)) {
      _showURLPopup(data);
    } else {
      _showTextPopup(data);
    }
  }

  bool _isURL(String data) {
    return Uri.tryParse(data)?.hasAbsolutePath ?? false;
  }

  void _showURLPopup(String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR Code Scanned'),
          content:
              const Text('This is a URL. Do you want to visit the website?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _launchURL(url);
                widget.onSave('URL', url);
                Navigator.pop(context);
              },
              child: const Text('Visit'),
            ),
          ],
        );
      },
    );
  }

  void _showTextPopup(String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR Code Scanned'),
          content: Text('Scanned Text: $text'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                widget.onSave('Text', text);
                Navigator.pop(context);
              },
              child: const Text('Save to History'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
