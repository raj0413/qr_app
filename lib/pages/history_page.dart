import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, String>> qrHistory = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? historyString = prefs.getString('qrHistory');
    if (historyString != null) {
      List<dynamic> historyList = jsonDecode(historyString);
      setState(() {
        qrHistory = List<Map<String, String>>.from(
            historyList.map((item) => Map<String, String>.from(item)));
      });
    }
  }

  Future<void> _saveHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String historyString = jsonEncode(qrHistory);
    await prefs.setString('qrHistory', historyString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan History"),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: qrHistory.isEmpty
          ? const Center(
              child: Text(
                'No scan history available',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
            children: [
              const SizedBox(height: 14,),
              Divider(
                color: Colors.black,
                thickness: 2,
                indent: 30,
                endIndent: 30,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: qrHistory.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                         
                          Card(
                            color: Colors.orange,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(qrHistory[index]['type']!),
                              subtitle: Text(qrHistory[index]['data']!),
                              leading: const Icon(Icons.qr_code),
                              onTap: () {
                                String data = qrHistory[index]['data']!;
                                _handleTap(context, data);
                              },
                            ),
                          ),
                          Divider(
                color: Colors.black,
                thickness: 2,
                indent: 30,
                endIndent: 30,
              ),
                        ],
                      );
                    },
                  ),
              ),
            ],
          ),
    );
  }

  void _handleTap(BuildContext context, String data) {
    if (Uri.tryParse(data)?.hasAbsolutePath ?? false) {
      _launchURL(data);
    } else {
      _showDataDialog(context, data);
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showDataDialog(BuildContext context, String data) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Scanned Data'),
          content: Text(data),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> saveScanData(String type, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? historyString = prefs.getString('qrHistory');
    List<Map<String, String>> qrHistory = [];
    if (historyString != null) {
      List<dynamic> historyList = jsonDecode(historyString);
      qrHistory = List<Map<String, String>>.from(
          historyList.map((item) => Map<String, String>.from(item)));
    }
    qrHistory.add({'type': type, 'data': data});
    String newHistoryString = jsonEncode(qrHistory);
    await prefs.setString('qrHistory', newHistoryString);
  }
}
