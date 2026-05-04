import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String erpUrl = 'https://ngik.thenehrugroup.com:9443/api5/erp/';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nehru Group ERP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LauncherPage(),
    );
  }
}

class LauncherPage extends StatefulWidget {
  const LauncherPage({super.key});
  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  String _status = 'Opening ERP Portal...';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _openERP();
  }

  Future<void> _openERP() async {
    final Uri uri = Uri.parse(erpUrl);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      setState(() { _loading = false; _status = 'Opened in browser'; });
    } catch (e) {
      setState(() { _loading = false; _status = 'Tap button to open'; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.business, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 24),
              const Text('Nehru Group ERP',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Enterprise Resource Planning',
                style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),
              if (_loading) const CircularProgressIndicator(),
              if (!_loading) Text(_status,
                style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _openERP,
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Open ERP Portal'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}