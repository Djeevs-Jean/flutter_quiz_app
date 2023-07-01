import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text('Question 1'),
            children: [
              ListTile(
                title: Text('Réponse 1'),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Question 2'),
            children: [
              ListTile(
                title: Text('Réponse 2'),
              ),
            ],
          ),
          // Ajoutez autant de questions et réponses que nécessaire
        ],
      ),
    );
  }
}



class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('about'.tr()),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'about1'.tr(),
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'about2'.tr(),
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'about3'.tr(),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'about4'.tr(),
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'about5'.tr(),
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'about6'.tr(),
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'about7'.tr(),
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
