import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:core';
import 'dart:io' show Platform;
import 'dart:convert' show utf8;

import 'package:path_provider_android/path_provider_android.dart';
import 'package:share_plus/share_plus.dart';

/// --- Model Data Kuesioner ---
class QuestionnaireData {
  String? nama; // Tambah: Nama
  String? asal; // Tambah: Asal
  String? namaGunung;
  int? frekuensiPendakian;
  List<String> motivasiPendakian;
  String? motivasiLainnya;
  String? jalurPendakian;
  List<String> sumberInformasiJalur;
  String? sumberInformasiLainnya;
  String? kondisiJalurKesulitan;
  String? kondisiJalurPerawatan;
  bool? pernahKecelakaan;
  String? penyebabKecelakaan;
  String? penilaianKeamanan;
  List<String> upayaKeamanan;
  String? upayaKeamananLainnya;
  List<String> fasilitasDibutuhkan;
  String? fasilitasLainnya;
  String? ketersediaanFasilitas;
  String? penilaianInfrastruktur;
  String? saranPerbaikan;
  String? kritik;
  String? saranLain;

  QuestionnaireData({
    this.nama, // Tambah
    this.asal, // Tambah
    this.namaGunung,
    this.frekuensiPendakian,
    this.motivasiPendakian = const [],
    this.motivasiLainnya,
    this.jalurPendakian,
    this.sumberInformasiJalur = const [],
    this.sumberInformasiLainnya,
    this.kondisiJalurKesulitan,
    this.kondisiJalurPerawatan,
    this.pernahKecelakaan,
    this.penyebabKecelakaan,
    this.penilaianKeamanan,
    this.upayaKeamanan = const [],
    this.upayaKeamananLainnya,
    this.fasilitasDibutuhkan = const [],
    this.fasilitasLainnya,
    this.ketersediaanFasilitas,
    this.penilaianInfrastruktur,
    this.saranPerbaikan,
    this.kritik,
    this.saranLain,
  });

  Map<String, dynamic> toJson() => {
    'nama': nama, // Tambah
    'asal': asal, // Tambah
    'namaGunung': namaGunung,
    'frekuensiPendakian': frekuensiPendakian,
    'motivasiPendakian': motivasiPendakian,
    'motivasiLainnya': motivasiLainnya,
    'jalurPendakian': jalurPendakian,
    'sumberInformasiJalur': sumberInformasiJalur,
    'sumberInformasiLainnya': sumberInformasiLainnya,
    'kondisiJalurKesulitan': kondisiJalurKesulitan,
    'kondisiJalurPerawatan': kondisiJalurPerawatan,
    'pernahKecelakaan': pernahKecelakaan,
    'penyebabKecelakaan': penyebabKecelakaan,
    'penilaianKeamanan': penilaianKeamanan,
    'upayaKeamanan': upayaKeamanan,
    'upayaKeamananLainnya': upayaKeamananLainnya,
    'fasilitasDibutuhkan': fasilitasDibutuhkan,
    'fasilitasLainnya': fasilitasLainnya,
    'ketersediaanFasilitas': ketersediaanFasilitas,
    'penilaianInfrastruktur': penilaianInfrastruktur,
    'saranPerbaikan': saranPerbaikan,
    'kritik': kritik,
    'saranLain': saranLain,
  };

  factory QuestionnaireData.fromJson(Map<String, dynamic> json) {
    return QuestionnaireData(
      nama: json['nama'], // Tambah
      asal: json['asal'], // Tambah
      namaGunung: json['namaGunung'],
      frekuensiPendakian: json['frekuensiPendakian'],
      motivasiPendakian: List<String>.from(json['motivasiPendakian'] ?? []),
      motivasiLainnya: json['motivasiLainnya'],
      jalurPendakian: json['jalurPendakian'],
      sumberInformasiJalur: List<String>.from(json['sumberInformasiJalur'] ?? []),
      sumberInformasiLainnya: json['sumberInformasiLainnya'],
      kondisiJalurKesulitan: json['kondisiJalurKesulitan'],
      kondisiJalurPerawatan: json['kondisiJalurPerawatan'],
      pernahKecelakaan: json['pernahKecelakaan'],
      penyebabKecelakaan: json['penyebabKecelakaan'],
      penilaianKeamanan: json['penilaianKeamanan'],
      upayaKeamanan: List<String>.from(json['upayaKeamanan'] ?? []),
      upayaKeamananLainnya: json['upayaKeamananLainnya'],
      fasilitasDibutuhkan: List<String>.from(json['fasilitasDibutuhkan'] ?? []),
      fasilitasLainnya: json['fasilitasLainnya'],
      ketersediaanFasilitas: json['ketersediaanFasilitas'],
      penilaianInfrastruktur: json['penilaianInfrastruktur'],
      saranPerbaikan: json['saranPerbaikan'],
      kritik: json['kritik'],
      saranLain: json['saranLain'],
    );
  }
}

/// --- Halaman Input Kuesioner ---
class QuestionnaireScreen extends StatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();

  QuestionnaireData _currentData = QuestionnaireData();

  final TextEditingController _motivasiLainnyaController = TextEditingController();
  final TextEditingController _sumberInformasiLainnyaController = TextEditingController();
  final TextEditingController _penyebabKecelakaanController = TextEditingController();
  final TextEditingController _upayaKeamananLainnyaController = TextEditingController();
  final TextEditingController _fasilitasLainnyaController = TextEditingController();
  final TextEditingController _saranPerbaikanController = TextEditingController();
  final TextEditingController _kritikController = TextEditingController();
  final TextEditingController _saranLainController = TextEditingController();

  // Tambah: TextEditingController untuk Nama dan Asal
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _asalController = TextEditingController();


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _currentData = QuestionnaireData(
      motivasiPendakian: [],
      sumberInformasiJalur: [],
      upayaKeamanan: [],
      fasilitasDibutuhkan: [],
    );
  }

  @override
  void dispose() {
    _motivasiLainnyaController.dispose();
    _sumberInformasiLainnyaController.dispose();
    _penyebabKecelakaanController.dispose();
    _upayaKeamananLainnyaController.dispose();
    _fasilitasLainnyaController.dispose();
    _saranPerbaikanController.dispose();
    _kritikController.dispose();
    _saranLainController.dispose();
    // Tambah: Dispose controllers baru
    _namaController.dispose();
    _asalController.dispose();
    super.dispose();
  }

  /// Menyimpan data kuesioner ke SharedPreferences.
  Future<void> _saveQuestionnaireData(QuestionnaireData data) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> rawDataList = prefs.getStringList('questionnaires') ?? [];
    List<QuestionnaireData> allData = rawDataList
        .map((e) {
          try {
            return QuestionnaireData.fromJson(jsonDecode(e));
          } catch (error) {
            print('Error decoding JSON from SharedPreferences (save): $error, Data: $e');
            return QuestionnaireData();
          }
        })
        .toList();

    allData.add(data);
    List<String> updatedRawDataList =
        allData.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('questionnaires', updatedRawDataList);
    bool committed = await prefs.commit(); // Explicitly commit changes
    print('SharedPreferences committed: $committed');
    print('Data saved to SharedPreferences. Total entries: ${updatedRawDataList.length}');
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Pastikan data dari text controllers dan pilihan disimpan ke _currentData
      _currentData.nama = _namaController.text; // Ambil nilai Nama
      _currentData.asal = _asalController.text; // Ambil nilai Asal

      _currentData.motivasiLainnya = _currentData.motivasiPendakian.contains('Lainnya') ? _motivasiLainnyaController.text : null;
      _currentData.sumberInformasiJalur.contains('Lainnya') ? _sumberInformasiLainnyaController.text : null;
      _currentData.penyebabKecelakaan = _currentData.pernahKecelakaan == true ? _penyebabKecelakaanController.text : null;
      _currentData.upayaKeamananLainnya = _currentData.upayaKeamanan.contains('Lainnya') ? _upayaKeamananLainnyaController.text : null;
      _currentData.fasilitasLainnya = _currentData.fasilitasDibutuhkan.contains('Lainnya') ? _fasilitasLainnyaController.text : null;
      _currentData.saranPerbaikan = _saranPerbaikanController.text;
      _currentData.kritik = _kritikController.text;
      _currentData.saranLain = _saranLainController.text;

      QuestionnaireData dataToSave = QuestionnaireData(
        nama: _currentData.nama, // Tambah
        asal: _currentData.asal, // Tambah
        namaGunung: _currentData.namaGunung,
        frekuensiPendakian: _currentData.frekuensiPendakian,
        motivasiPendakian: List.from(_currentData.motivasiPendakian),
        motivasiLainnya: _currentData.motivasiLainnya,
        jalurPendakian: _currentData.jalurPendakian,
        sumberInformasiJalur: List.from(_currentData.sumberInformasiJalur),
        sumberInformasiLainnya: _currentData.sumberInformasiLainnya,
        kondisiJalurKesulitan: _currentData.kondisiJalurKesulitan,
        kondisiJalurPerawatan: _currentData.kondisiJalurPerawatan,
        pernahKecelakaan: _currentData.pernahKecelakaan,
        penyebabKecelakaan: _currentData.penyebabKecelakaan,
        penilaianKeamanan: _currentData.penilaianKeamanan,
        upayaKeamanan: List.from(_currentData.upayaKeamanan),
        upayaKeamananLainnya: _currentData.upayaKeamananLainnya,
        fasilitasDibutuhkan: List.from(_currentData.fasilitasDibutuhkan),
        fasilitasLainnya: _currentData.fasilitasLainnya,
        ketersediaanFasilitas: _currentData.ketersediaanFasilitas,
        penilaianInfrastruktur: _currentData.penilaianInfrastruktur,
        saranPerbaikan: _currentData.saranPerbaikan,
        kritik: _currentData.kritik,
        saranLain: _currentData.saranLain,
      );

      print('Data to be saved: ${jsonEncode(dataToSave.toJson())}');
      await _saveQuestionnaireData(dataToSave);

      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kuesioner berhasil disimpan!')),
        );
      }

      _formKey.currentState!.reset();
      setState(() {
        _currentData = QuestionnaireData(
          motivasiPendakian: [],
          sumberInformasiJalur: [],
          upayaKeamanan: [],
          fasilitasDibutuhkan: [],
        );
      });
      _motivasiLainnyaController.clear();
      _sumberInformasiLainnyaController.clear();
      _penyebabKecelakaanController.clear();
      _upayaKeamananLainnyaController.clear();
      _fasilitasLainnyaController.clear();
      _saranPerbaikanController.clear();
      _kritikController.clear();
      _saranLainController.clear();
      // Tambah: Clear controllers baru
      _namaController.clear();
      _asalController.clear();
    } else {
      print('Form validation failed.');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mohon lengkapi semua bidang yang wajib diisi.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 16),
            const Text(
              'Mohon luangkan waktu Anda untuk mengisi kuesioner ini. Masukan Anda sangat berharga untuk peningkatan kualitas jalur pendakian di masa mendatang.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            /// --- Bagian 1: Informasi Umum (Data Diri) ---
            Text(
              'Bagian 1: Informasi Umum (Data Diri)', // Ubah judul bagian
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(height: 24, thickness: 1),
            TextFormField(
              controller: _namaController, // Gunakan controller
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap Anda', // Label untuk Nama
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Mohon masukkan nama Anda';
                }
                return null;
              },
              // Nilai akan diambil dari controller di _submitForm
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _asalController, // Gunakan controller
              decoration: const InputDecoration(
                labelText: 'Asal Daerah Anda', // Label untuk Asal
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Mohon masukkan asal daerah Anda';
                }
                return null;
              },
              // Nilai akan diambil dari controller di _submitForm
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Apa nama ODTW/Jalur Pendakian yang anda kunjungi?',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _currentData.namaGunung = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Mohon masukkan nama ODTW/Jalur Pendakian';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Berapa kali Anda berkunjung dalam setahun?',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _currentData.frekuensiPendakian = int.tryParse(value);
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Mohon masukkan frekuensi kunjungan';
                }
                if (int.tryParse(value) == null) {
                  return 'Mohon masukkan angka yang valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Text('Apa motivasi Anda berkunjung? (Bisa pilih lebih dari satu)', style: Theme.of(context).textTheme.titleMedium),
            Column(
              children: [
                CheckboxListTile(
                  title: const Text('Olahraga'),
                  value: _currentData.motivasiPendakian.contains('Olahraga'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.motivasiPendakian.add('Olahraga');
                      } else {
                        _currentData.motivasiPendakian.remove('Olahraga');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Menikmati alam'),
                  value: _currentData.motivasiPendakian.contains('Menikmati alam'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.motivasiPendakian.add('Menikmati alam');
                      } else {
                        _currentData.motivasiPendakian.remove('Menikmati alam');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Tantangan'),
                  value: _currentData.motivasiPendakian.contains('Tantangan'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.motivasiPendakian.add('Tantangan');
                      } else {
                        _currentData.motivasiPendakian.remove('Tantangan');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Lainnya (sebutkan)'),
                  value: _currentData.motivasiPendakian.contains('Lainnya'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.motivasiPendakian.add('Lainnya');
                      } else {
                        _currentData.motivasiPendakian.remove('Lainnya');
                      }
                    });
                  },
                ),
                if (_currentData.motivasiPendakian.contains('Lainnya'))
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                    child: TextFormField(
                      controller: _motivasiLainnyaController,
                      decoration: const InputDecoration(
                        hintText: 'Sebutkan motivasi lainnya',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            /// --- Bagian 2: ODTW/Jalur Pendakian ---
            Text(
              'Bagian 2: ODTW/Jalur Pendakian',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(height: 24, thickness: 1),
            Text('ODTW/Jalur Pendakian mana yang Anda gunakan?', style: Theme.of(context).textTheme.titleMedium),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Jalur resmi'),
                  value: 'resmi',
                  groupValue: _currentData.jalurPendakian,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.jalurPendakian = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Jalur alternatif'),
                  value: 'alternatif',
                  groupValue: _currentData.jalurPendakian,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.jalurPendakian = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Jalur tidak resmi'),
                  value: 'tidak_resmi',
                  groupValue: _currentData.jalurPendakian,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.jalurPendakian = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Bagaimana Anda mengetahui ODTW/Jalur Pendakian yang Anda gunakan? (Bisa pilih lebih dari satu)', style: Theme.of(context).textTheme.titleMedium),
            Column(
              children: [
                CheckboxListTile(
                  title: const Text('Internet (website, media sosial)'),
                  value: _currentData.sumberInformasiJalur.contains('Internet (website, media sosial)'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.sumberInformasiJalur.add('Internet (website, media sosial)');
                      } else {
                        _currentData.sumberInformasiJalur.remove('Internet (website, media sosial)');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Rekomendasi teman/keluarga'),
                  value: _currentData.sumberInformasiJalur.contains('Rekomendasi teman/keluarga'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.sumberInformasiJalur.add('Rekomendasi teman/keluarga');
                      } else {
                        _currentData.sumberInformasiJalur.remove('Rekomendasi teman/keluarga');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Peta/aplikasi navigasi'),
                  value: _currentData.sumberInformasiJalur.contains('Peta/aplikasi navigasi'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.sumberInformasiJalur.add('Peta/aplikasi navigasi');
                      } else {
                        _currentData.sumberInformasiJalur.remove('Peta/aplikasi navigasi');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Lainnya (sebutkan)'),
                  value: _currentData.sumberInformasiJalur.contains('Lainnya'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.sumberInformasiJalur.add('Lainnya');
                      } else {
                        _currentData.sumberInformasiJalur.remove('Lainnya');
                      }
                    });
                  },
                ),
                if (_currentData.sumberInformasiJalur.contains('Lainnya'))
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                    child: TextFormField(
                      controller: _sumberInformasiLainnyaController,
                      decoration: const InputDecoration(
                        hintText: 'Sebutkan sumber informasi lainnya',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Apa yang Anda pikir tentang kondisi ODTW/Jalur Pendakian yang Anda gunakan? (Kesulitan)', style: Theme.of(context).textTheme.titleMedium),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Mudah'),
                  value: 'mudah',
                  groupValue: _currentData.kondisiJalurKesulitan,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.kondisiJalurKesulitan = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Sedang'),
                  value: 'sedang',
                  groupValue: _currentData.kondisiJalurKesulitan,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.kondisiJalurKesulitan = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Sulit'),
                  value: 'sulit',
                  groupValue: _currentData.kondisiJalurKesulitan,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.kondisiJalurKesulitan = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Apa yang Anda pikir tentang kondisi ODTW/Jalur Pendakian yang Anda gunakan? (Perawatan)', style: Theme.of(context).textTheme.titleMedium),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Terawat dengan baik'),
                  value: 'terawat',
                  groupValue: _currentData.kondisiJalurPerawatan,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.kondisiJalurPerawatan = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Cukup terawat'),
                  value: 'cukup_terawat',
                  groupValue: _currentData.kondisiJalurPerawatan,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.kondisiJalurPerawatan = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Kurang terawat'),
                  value: 'kurang_terawat',
                  groupValue: _currentData.kondisiJalurPerawatan,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.kondisiJalurPerawatan = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Tidak terawat'),
                  value: 'tidak_terawat',
                  groupValue: _currentData.kondisiJalurPerawatan,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.kondisiJalurPerawatan = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// --- Bagian 3: Keselamatan dan Keamanan ---
            Text(
              'Bagian 3: Keselamatan dan Keamanan',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(height: 24, thickness: 1),
            Text('Apakah Anda pernah mengalami kecelakaan atau cedera saat melakukan pendakian?', style: Theme.of(context).textTheme.titleMedium),
            Column(
              children: [
                RadioListTile<bool>(
                  title: const Text('Ya'),
                  value: true,
                  groupValue: _currentData.pernahKecelakaan,
                  onChanged: (bool? value) {
                    setState(() {
                      _currentData.pernahKecelakaan = value;
                    });
                  },
                ),
                RadioListTile<bool>(
                  title: const Text('Tidak'),
                  value: false,
                  groupValue: _currentData.pernahKecelakaan,
                  onChanged: (bool? value) {
                    setState(() {
                      _currentData.pernahKecelakaan = value;
                    });
                  },
                ),
              ],
            ),
            if (_currentData.pernahKecelakaan == true)
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                child: TextFormField(
                  controller: _penyebabKecelakaanController,
                  decoration: const InputDecoration(
                    labelText: 'Apa yang menyebabkan kecelakaan tersebut?',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Text('Bagaimana Anda menilai keselamatan dan keamanan ODTW/Jalur Pendakian yang Anda gunakan?', style: Theme.of(context).textTheme.titleMedium),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Sangat aman'),
                  value: 'sangat_aman',
                  groupValue: _currentData.penilaianKeamanan,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.penilaianKeamanan = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Cukup aman'),
                  value: 'cukup_aman',
                  groupValue: _currentData.penilaianKeamanan,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.penilaianKeamanan = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Kurang aman'),
                  value: 'kurang_aman',
                  groupValue: _currentData.penilaianKeamanan,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.penilaianKeamanan = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Tidak aman'),
                  value: 'tidak_aman',
                  groupValue: _currentData.penilaianKeamanan,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.penilaianKeamanan = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Perlu perhatian lebih'),
                  value: 'perlu_perhatian',
                  groupValue: _currentData.penilaianKeamanan,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.penilaianKeamanan = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Apa yang Anda lakukan untuk memastikan keselamatan dan keamanan saat melakukan pendakian? (Bisa pilih lebih dari satu)', style: Theme.of(context).textTheme.titleMedium),
            Column(
              children: [
                CheckboxListTile(
                  title: const Text('Membawa peralatan keselamatan (P3K, senter, dll.)'),
                  value: _currentData.upayaKeamanan.contains('Membawa peralatan keselamatan (P3K, senter, dll.)'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.upayaKeamanan.add('Membawa peralatan keselamatan (P3K, senter, dll.)');
                      } else {
                        _currentData.upayaKeamanan.remove('Membawa peralatan keselamatan (P3K, senter, dll.)');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Memberitahu teman atau keluarga tentang rencana pendakian'),
                  value: _currentData.upayaKeamanan.contains('Memberitahu teman atau keluarga tentang rencana pendakian'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.upayaKeamanan.add('Memberitahu teman atau keluarga tentang rencana pendakian');
                      } else {
                        _currentData.upayaKeamanan.remove('Memberitahu teman atau keluarga tentang rencana pendakian');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Menggunakan jasa pemandu'),
                  value: _currentData.upayaKeamanan.contains('Menggunakan jasa pemandu'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.upayaKeamanan.add('Menggunakan jasa pemandu');
                      } else {
                        _currentData.upayaKeamanan.remove('Menggunakan jasa pemandu');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Memeriksa perkiraan cuaca'),
                  value: _currentData.upayaKeamanan.contains('Memeriksa perkiraan cuaca'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.upayaKeamanan.add('Memeriksa perkiraan cuaca');
                      } else {
                        _currentData.upayaKeamanan.remove('Memeriksa perkiraan cuaca');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Mempersiapkan fisik dan mental'),
                  value: _currentData.upayaKeamanan.contains('Mempersiapkan fisik dan mental'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.upayaKeamanan.add('Mempersiapkan fisik dan mental');
                      } else {
                        _currentData.upayaKeamanan.remove('Mempersiapkan fisik dan mental');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Lainnya (sebutkan)'),
                  value: _currentData.upayaKeamanan.contains('Lainnya'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.upayaKeamanan.add('Lainnya');
                      } else {
                        _currentData.upayaKeamanan.remove('Lainnya');
                      }
                    });
                  },
                ),
                if (_currentData.upayaKeamanan.contains('Lainnya'))
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                    child: TextFormField(
                      controller: _upayaKeamananLainnyaController,
                      decoration: const InputDecoration(
                        hintText: 'Sebutkan upaya lainnya',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),

            /// --- Bagian 4: Fasilitas dan Infrastruktur ---
            Text(
              'Bagian 4: Fasilitas dan Infrastruktur',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(height: 24, thickness: 1),
            Text('Apa fasilitas yang Anda butuhkan saat melakukan pendakian? (Bisa pilih lebih dari satu)', style: Theme.of(context).textTheme.titleMedium),
            Column(
              children: [
                CheckboxListTile(
                  title: const Text('Tempat istirahat/shelter'),
                  value: _currentData.fasilitasDibutuhkan.contains('Tempat istirahat/shelter'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.fasilitasDibutuhkan.add('Tempat istirahat/shelter');
                      } else {
                        _currentData.fasilitasDibutuhkan.remove('Tempat istirahat/shelter');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Toilet'),
                  value: _currentData.fasilitasDibutuhkan.contains('Toilet'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.fasilitasDibutuhkan.add('Toilet');
                      } else {
                        _currentData.fasilitasDibutuhkan.remove('Toilet');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Sumber air bersih'),
                  value: _currentData.fasilitasDibutuhkan.contains('Sumber air bersih'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.fasilitasDibutuhkan.add('Sumber air bersih');
                      } else {
                        _currentData.fasilitasDibutuhkan.remove('Sumber air bersih');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Penanda jalur yang jelas'),
                  value: _currentData.fasilitasDibutuhkan.contains('Penanda jalur yang jelas'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.fasilitasDibutuhkan.add('Penanda jalur yang jelas');
                      } else {
                        _currentData.fasilitasDibutuhkan.remove('Penanda jalur yang jelas');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Tempat sampah'),
                  value: _currentData.fasilitasDibutuhkan.contains('Tempat sampah'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.fasilitasDibutuhkan.add('Tempat sampah');
                      } else {
                        _currentData.fasilitasDibutuhkan.remove('Tempat sampah');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Sinyal komunikasi/posko komunikasi'),
                  value: _currentData.fasilitasDibutuhkan.contains('Sinyal komunikasi/posko komunikasi'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.fasilitasDibutuhkan.add('Sinyal komunikasi/posko komunikasi');
                      } else {
                        _currentData.fasilitasDibutuhkan.remove('Sinyal komunikasi/posko komunikasi');
                      }
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Lainnya (sebutkan)'),
                  value: _currentData.fasilitasDibutuhkan.contains('Lainnya'),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _currentData.fasilitasDibutuhkan.add('Lainnya');
                      } else {
                        _currentData.fasilitasDibutuhkan.remove('Lainnya');
                      }
                    });
                  },
                ),
                if (_currentData.fasilitasDibutuhkan.contains('Lainnya'))
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                    child: TextFormField(
                      controller: _fasilitasLainnyaController,
                      decoration: const InputDecoration(
                        hintText: 'Sebutkan fasilitas lainnya',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Bagaimana Anda menilai ketersediaan fasilitas di ODTW/Jalur Pendakian yang Anda gunakan?', style: Theme.of(context).textTheme.titleMedium),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Sangat memadai'),
                  value: 'sangat_memadai',
                  groupValue: _currentData.ketersediaanFasilitas,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.ketersediaanFasilitas = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Memadai'),
                  value: 'memadai',
                  groupValue: _currentData.ketersediaanFasilitas,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.ketersediaanFasilitas = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Kurang memadai'),
                  value: 'kurang_memadai',
                  groupValue: _currentData.ketersediaanFasilitas,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.ketersediaanFasilitas = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Tidak memadai'),
                  value: 'tidak_memadai',
                  groupValue: _currentData.ketersediaanFasilitas,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.ketersediaanFasilitas = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Perlu banyak perbaikan'),
                  value: 'perlu_perbaikan',
                  groupValue: _currentData.ketersediaanFasilitas,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.ketersediaanFasilitas = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Apa yang Anda pikir tentang infrastruktur ODTW/Jalur Pendakian yang Anda gunakan? (misalnya: jembatan, tangga, jalur setapak)', style: Theme.of(context).textTheme.titleMedium),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text('Sangat baik'),
                  value: 'sangat_baik',
                  groupValue: _currentData.penilaianInfrastruktur,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.penilaianInfrastruktur = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Baik'),
                  value: 'baik',
                  groupValue: _currentData.penilaianInfrastruktur,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.penilaianInfrastruktur = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Cukup baik'),
                  value: 'cukup_baik',
                  groupValue: _currentData.penilaianInfrastruktur,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.penilaianInfrastruktur = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Tidak baik'),
                  value: 'tidak_baik',
                  groupValue: _currentData.penilaianInfrastruktur,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.penilaianInfrastruktur = value;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('Perlu perhatian lebih'),
                  value: 'perlu_perhatian',
                  groupValue: _currentData.penilaianInfrastruktur,
                  onChanged: (String? value) {
                    setState(() {
                      _currentData.penilaianInfrastruktur = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),

            /// --- Bagian 5: Saran dan Kritik ---
            Text(
              'Bagian 5: Saran dan Kritik',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Divider(height: 24, thickness: 1),
            TextFormField(
              controller: _saranPerbaikanController,
              minLines: 3,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: 'Saran perbaikan ODTW/Jalur Pendakian?',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _kritikController,
              minLines: 3,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: 'Kritik terhadap ODTW/Jalur Pendakian?',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _saranLainController,
              minLines: 3,
              maxLines: null,
              decoration: const InputDecoration(
                labelText: 'Saran lain terkait pendakian/ODTW/Jalur Pendakian?',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            Center(
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Kirim Kuesioner'),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

/// --- Halaman Rekapitulasi Data ---
class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  List<QuestionnaireData> _allQuestionnaireData = [];
  bool _isLoading = true;

  @override
  bool get wantKeepAlive => true; // Menjaga state daftar tetap hidup saat berpindah tab

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Tambahkan observer
    _loadQuestionnaireData(); // Muat data awal
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!mounted || _isLoading) return;

    Future.microtask(() {
      print('didChangeDependencies called in SummaryScreen. Attempting to reload questionnaire data after a short delay.');
      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        _loadQuestionnaireData();
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Hapus observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print('App resumed. Reloading questionnaire data in SummaryScreen.');
      _loadQuestionnaireData();
    }
  }

  /// Memuat semua data kuesioner dari SharedPreferences.
  Future<void> _loadQuestionnaireData() async {
    if (_isLoading && _allQuestionnaireData.isNotEmpty) {
      print('Already loading or data present, skipping reload.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    print('Loading questionnaire data from SharedPreferences...');
    final prefs = await SharedPreferences.getInstance();
    List<String> rawDataList = prefs.getStringList('questionnaires') ?? [];
    print('Raw data loaded: ${rawDataList.length} entries. Raw content: $rawDataList');
    setState(() {
      _allQuestionnaireData = rawDataList
          .map((e) {
            try {
              print('Attempting to parse JSON: $e');
              return QuestionnaireData.fromJson(jsonDecode(e));
            } catch (error) {
              print('Error decoding JSON from SharedPreferences: $error, Data causing error: $e');
              return QuestionnaireData();
            }
          })
          .toList();
      _isLoading = false;
      print('Loaded ${_allQuestionnaireData.length} valid questionnaire entries.');
    });
  }

  /// Menghapus semua data kuesioner dari SharedPreferences.
  Future<void> _clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('questionnaires');
    setState(() {
      _allQuestionnaireData = [];
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua data rekapitulasi berhasil dihapus!')),
      );
    }
    print('All data cleared from SharedPreferences.');
  }

  /// Mengekspor data kuesioner ke file CSV dan membagikannya.
  Future<void> _exportAndShareCsv() async {
    try {
      List<List<dynamic>> csvData = [];

      List<String> headers = [
        'No.',
        'Nama', // Tambah
        'Asal', // Tambah
        'Nama ODTW/Jalur Pendakian', // Tambah
        'Frekuensi Kunjungan', // Ubah
        'Motivasi Kunjungan', // Ubah
        'Motivasi Lainnya',
        'Jalur Pendakian',
        'Sumber Informasi Jalur',
        'Sumber Informasi Lainnya',
        'Kondisi Jalur (Kesulitan)',
        'Kondisi Jalur (Perawatan)',
        'Pernah Kecelakaan',
        'Penyebab Kecelakaan',
        'Penilaian Keamanan',
        'Upaya Keamanan',
        'Upaya Keamanan Lainnya',
        'Fasilitas Dibutuhkan',
        'Fasilitas Lainnya',
        'Ketersediaan Fasilitas',
        'Penilaian Infrastruktur',
        'Saran Perbaikan',
        'Kritik',
        'Saran Lain',
      ];
      csvData.add(headers);

      for (int i = 0; i < _allQuestionnaireData.length; i++) {
        final data = _allQuestionnaireData[i];
        csvData.add([
          (i + 1),
          data.nama ?? '', // Tambah
          data.asal ?? '', // Tambah
          data.namaGunung ?? '',
          data.frekuensiPendakian?.toString() ?? '',
          data.motivasiPendakian.join('; '),
          data.motivasiLainnya ?? '',
          data.jalurPendakian ?? '',
          data.sumberInformasiJalur.join('; '),
          data.sumberInformasiLainnya ?? '',
          data.kondisiJalurKesulitan ?? '',
          data.kondisiJalurPerawatan ?? '',
          (data.pernahKecelakaan == true ? 'Ya' : 'Tidak'),
          data.penyebabKecelakaan ?? '',
          data.penilaianKeamanan ?? '',
          data.upayaKeamanan.join('; '),
          data.upayaKeamananLainnya ?? '',
          data.fasilitasDibutuhkan.join('; '),
          data.fasilitasLainnya ?? '',
          data.ketersediaanFasilitas ?? '',
          data.penilaianInfrastruktur ?? '',
          data.saranPerbaikan ?? '',
          data.kritik ?? '',
          data.saranLain ?? '',
        ]);
      }

      String csvString = '';
      for (var row in csvData) {
        csvString += row.map((e) {
          String value = e.toString();
          if (value.contains(',') || value.contains(';') || value.contains('\n') || value.contains('"')) {
            value = '"${value.replaceAll('"', '""')}"';
          }
          return value;
        }).join(',');
        csvString += '\n';
      }

      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/Rekapitulasi_Kuesioner_Pendakian.csv';
      final file = File(path);

      await file.writeAsString(csvString, encoding: utf8);
      print('CSV created temporarily at: $path');

      if (mounted) {
        await Share.shareXFiles([XFile(file.path)], text: 'Berikut data kuesioner pendakian.');
        print('CSV shared via share_plus.');
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('CSV berhasil dibagikan!')),
        );
      }
    } catch (e) {
      print('Error creating or sharing CSV: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan saat membagikan data: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekapitulasi Kuesioner'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Data',
            onPressed: _isLoading ? null : () => _loadQuestionnaireData(),
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Bagikan CSV',
            onPressed: _allQuestionnaireData.isEmpty ? null : () => _exportAndShareCsv(),
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Hapus Semua Data',
            onPressed: _allQuestionnaireData.isEmpty ? null : () => _clearAllData(),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _allQuestionnaireData.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada data kuesioner yang disimpan.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadQuestionnaireData,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _allQuestionnaireData.length,
                    itemBuilder: (context, index) {
                      final data = _allQuestionnaireData[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Data Kuesioner #${index + 1}',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).primaryColor),
                              ),
                              const Divider(height: 20, thickness: 1),
                              _buildInfoRow('Nama', data.nama), // Tambah
                              _buildInfoRow('Asal', data.asal), // Tambah
                              _buildInfoRow('Nama ODTW/Jalur Pendakian', data.namaGunung), // Ubah
                              _buildInfoRow('Frekuensi Kunjungan', '${data.frekuensiPendakian ?? '-'} kali/tahun'), // Ubah
                              _buildInfoRow('Motivasi Kunjungan', data.motivasiPendakian.join(', ')), // Ubah
                              if (data.motivasiLainnya != null && data.motivasiLainnya!.isNotEmpty)
                                _buildInfoRow('Motivasi Lainnya', data.motivasiLainnya),

                              const SizedBox(height: 10),
                              Text('ODTW/Jalur Pendakian', style: Theme.of(context).textTheme.titleMedium),
                              _buildInfoRow('Jalur yang Digunakan', data.jalurPendakian),
                              _buildInfoRow('Sumber Informasi Jalur', data.sumberInformasiJalur.join(', ')),
                              if (data.sumberInformasiLainnya != null && data.sumberInformasiLainnya!.isNotEmpty)
                                _buildInfoRow('Sumber Informasi Lainnya', data.sumberInformasiLainnya),
                              _buildInfoRow('Kondisi Jalur (Kesulitan)', data.kondisiJalurKesulitan),
                              _buildInfoRow('Kondisi Jalur (Perawatan)', data.kondisiJalurPerawatan),

                              const SizedBox(height: 10),
                              Text('Keselamatan dan Keamanan', style: Theme.of(context).textTheme.titleMedium),
                              _buildInfoRow('Pernah Kecelakaan', data.pernahKecelakaan == true ? 'Ya' : 'Tidak'),
                              if (data.pernahKecelakaan == true && data.penyebabKecelakaan != null && data.penyebabKecelakaan!.isNotEmpty)
                                _buildInfoRow('Penyebab Kecelakaan', data.penyebabKecelakaan),
                              _buildInfoRow('Penilaian Keamanan', data.penilaianKeamanan),
                              _buildInfoRow('Upaya Keamanan', data.upayaKeamanan.join(', ')),
                              if (data.upayaKeamananLainnya != null && data.upayaKeamananLainnya!.isNotEmpty)
                                _buildInfoRow('Upaya Keamanan Lainnya', data.upayaKeamananLainnya),

                              const SizedBox(height: 10),
                              Text('Fasilitas dan Infrastruktur', style: Theme.of(context).textTheme.titleMedium),
                              _buildInfoRow('Fasilitas Dibutuhkan', data.fasilitasDibutuhkan.join(', ')),
                              if (data.fasilitasLainnya != null && data.fasilitasLainnya!.isNotEmpty)
                                _buildInfoRow('Fasilitas Lainnya', data.fasilitasLainnya),
                              _buildInfoRow('Ketersediaan Fasilitas', data.ketersediaanFasilitas),
                              _buildInfoRow('Penilaian Infrastruktur', data.penilaianInfrastruktur),

                              const SizedBox(height: 10),
                              Text('Saran dan Kritik', style: Theme.of(context).textTheme.titleMedium),
                              _buildInfoRow('Saran Perbaikan', data.saranPerbaikan, isMultiline: true),
                              _buildInfoRow('Kritik', data.kritik, isMultiline: true),
                              _buildInfoRow('Saran Lain', data.saranLain, isMultiline: true),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }

  /// Helper widget untuk menampilkan baris informasi di rekapitulasi.
  Widget _buildInfoRow(String title, String? value, {bool isMultiline = false}) {
    if (value == null || value.isEmpty) {
      return const SizedBox.shrink(); // Sembunyikan jika tidak ada nilai
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${title}:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          isMultiline
              ? Text(value, textAlign: TextAlign.justify)
              : Text(value),
        ],
      ),
    );
  }
}