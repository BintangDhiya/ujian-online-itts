// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ujian Online ITTS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ExamHeaderPage(), // Mengubah halaman awal ke ExamHeaderPage
    );
  }
}

// Halaman Header Dengan StatelessWidget
class ExamHeaderPage extends StatelessWidget {
  const ExamHeaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Ujian Online ITTS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const Image(
                        image: AssetImage('assets/logoitts.png'),
                        fit: BoxFit.contain, // Ini akan menyesuaikan ukuran gambar
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Selamat datang di sistem ujian online ITTS. '
                        'Silakan lengkapi data diri Anda dan pilih jenis ujian yang akan diikuti.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              onPressed: () {
                // Navigasi ke halaman ExamPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExamPage()),
                );
              },
              child: const Text(
                'Mulai Ujian',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Form Ujian Dengan StatefulWidget
class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  final _formKey = GlobalKey<FormState>();
  String nama = '';
  String mataPelajaran = '';
  String? jenisUjian;
  bool setuju = false;
  bool showSummary = false;

  final List<String> jenisUjianList = ['UTS', 'UAS', 'Quiz'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Ujian Online'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      nama = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Mata Pelajaran',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      mataPelajaran = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mata pelajaran tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Jenis Ujian',
                    border: OutlineInputBorder(),
                  ),
                  value: jenisUjian,
                  items: jenisUjianList
                      .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      jenisUjian = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih jenis ujian';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: setuju,
                      onChanged: (value) {
                        setState(() {
                          setuju = value ?? false;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text('Saya siap mengikuti ujian'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() && setuju) {
                      setState(() {
                        showSummary = true;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Submit'),
                ),
                if (showSummary) ...[
                  const SizedBox(height: 24),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nama: $nama'),
                          const SizedBox(height: 8),
                          Text('Mata Pelajaran: $mataPelajaran'),
                          const SizedBox(height: 8),
                          Text('Jenis Ujian: ${jenisUjian ?? ""}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}