import 'package:flutter/material.dart';
import 'package:qr_app/components/history_manager.dart';
import 'package:qr_app/pages/qr_scan_page.dart';
import 'package:qr_app/pages/create_page.dart';
import 'package:qr_app/pages/history_page.dart';


class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 1;

  //  save scan data
  void _onSave(String type, String data) {
    HistoryManager.saveScanData(type, data);
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      QRScanPage(onSave: _onSave),
      const Homepage(),
      const HistoryPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color.fromARGB(255, 64, 62, 62),
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.orange,
        items:const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
            ),
            label: "Scan",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.create_new_folder_outlined,
              color:  Colors.white,
            ),
            label: "Create",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history_outlined,
              color:  Colors.white,
            ),
            label: "History",
          ),
        ],
        onTap: (index) {
          if (index < _pages.length) {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
