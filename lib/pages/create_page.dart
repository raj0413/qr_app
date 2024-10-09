import 'package:flutter/material.dart';

import 'package:qr_app/pages/text_qr_page.dart';
import 'package:qr_app/pages/website_qr_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Home"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
        backgroundColor: Colors.orange,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WebsiteQrPage()),
                  );
                },
                child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.orange.shade300,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 3, color: Colors.black)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.link,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Website",
                        style: TextStyle(fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TextQrPage()),
                  );
                },
                child: Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.orange.shade300,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 3, color: Colors.black)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.text_snippet_outlined,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Text",
                        style: TextStyle(fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
