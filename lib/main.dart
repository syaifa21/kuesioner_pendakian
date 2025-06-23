import 'package:flutter/material.dart';
import 'questionnaire_pages.dart'; // Import file baru kita

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuesioner Pendakian Gunung',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(), // Mulai dari MainScreen yang mengelola BottomNav
    );
  }
}

/// --- Main Screen dengan Bottom Navigation ---
/// Widget ini mengelola BottomNavigationBar dan menampilkan halaman yang sesuai.
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Index halaman yang sedang aktif

  // Daftar halaman yang akan ditampilkan di BottomNavigationBar
  final List<Widget> _screens = [
    const QuestionnaireScreen(),
    const SummaryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Judul AppBar yang akan berubah sesuai halaman yang aktif
  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Input Kuesioner';
      case 1:
        return 'Rekapitulasi Kuesioner';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(_selectedIndex)),
        // Actions (tombol ekspor & hapus) hanya ditampilkan di halaman Rekapitulasi
        actions: _selectedIndex == 1
            ? [
                // Tombol ini akan otomatis memanggil fungsi dari SummaryScreen
                // karena SummaryScreen adalah bagian dari IndexedStack yang aktif.
                // Tidak perlu memanggil fungsi secara eksplisit dari sini,
                // karena tombol-tombol tersebut sudah didefinisikan di dalam AppBar SummaryScreen.
                // Jika ingin memanggil dari sini, SummaryScreen harus punya GlobalKey
                // atau menyediakan callback. Untuk BottomNav, lebih baik biarkan
                // tombol tetap di AppBar halaman masing-masing.
                // Karena kita sudah pakai AutomaticKeepAliveClientMixin,
                // data SummaryScreen akan otomatis diperbarui saat tab dipilih.
                // Kita akan hapus tombol ini dari MainScreen AppBar
                // dan biarkan mereka di AppBar masing-masing halaman.
              ]
            : null, // Tidak ada action di halaman input kuesioner
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: 'Input',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Rekap',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}