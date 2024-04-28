import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // widget yang digunakan untuk menampilkan tampilan atau komponen yang tidak perlu mengubah keadaan atau state-nya selama aplikasi berjalan
  @override
  Widget build(BuildContext context) {
    //metode yang digunakan mengembalikan widget atau tampilan yang akan ditampilkan pada layar aplikasi
    return MaterialApp(
      title: 'Baca Buku', //parameter yang digunakan pada widget
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Baca Buku'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //widget yang digunakan untuk menampilkan tampilan atau komponen yang tidak perlu mengubah keadaan atau state-nya selama aplikasi berjalan
  MyHomePage({Key? key, required this.title})
      : super(
            key:
                key); //konstruktor dari MyHomePage yang digunakan membuat objek dari kelas myHomePage

  final String title; // deklarasi variable title

  @override
  _MyHomePageState createState() =>
      _MyHomePageState(); //method yang digunakan untuk membuat objek dari kelas _MyHomePageState
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> books = [
    //list judul buku yang akan ditampilkan pada aplikasi
    'Bumi - Tere Liye',
    'Daun jatuh tak pernah membenci angin - Tere Liye',
    'Rindu - Tere Liye',
    'Pulang - Tere Liye',
    'Tentang Kamu - Tere Liye',
    'Hujan - Tere Liye',
  ];

  bool isReading = false;
  String bookContent = '';
  List<String> readBooks = [];

  void readBook(String title) {
    //method yang didefinisikan di dalam kelas (widget) yang digunakan untuk mengeksekusi suatu aksi atau tindakan ketika method tersebut dipanggil atau dijalankan.
    setState(() {
      isReading = true;
      bookContent =
          'Bumi ini merupakan series pertama dari series"BUMI" karya Tere Liye. Pada novel ini merupakan awal pengenalan tokoh-tokoh utama yang berperan. Novel ini mengisahkan tentang petualangan 3 remaja yang berusia 15 tahun bernama Raib, Ali dan Seli. Namun mereka bukanlah remaja biasa, melainkan remaja yang memiliki kekuatan khusus seperti Raib yang bisa menghilang, Seli yang bisa mengeluarkan petir dan Ali seorang pelajar yang sangat jenius. Petualangan menjelajah dunia paralel mereka dimulai dari sini, dunia paralel yang pertama mereka jelajahi adalah Klan Bulan. Tetapi mereka tidak hanya sekedar menjelajah saja, melainkan mereka harus bertarung untuk menyelamatkan dunia paralel dari orang-orang jahat. Orang-orang jahat tersebut yakni bernama Tamus. Tamus memiliki ambisi untuk menguasai dunia, oleh karena itu ia berusaha untuk membebaskan seorang pangeran yang sangat kuat dan memiliki ambisi yang sama. Pangeran tersebut sedang dipenjara yang disebut "Penjara Bayangan dibawah Bayangan". Pangeran tersebut bernama Si Tanpa Mahkota.  $title';
    });
  }

  void markAsRead(String title) {
    //Method ini digunakan untuk melakukan aksi menandai sebuah buku dengan judul yang diberikan pada parameter title sebagai sudah dibaca.
    setState(() {
      isReading = false;
      readBooks.add(title);
    });
  }

  bool isBookRead(String title) {
    return readBooks.contains(title);
  }

  @override
  Widget build(BuildContext context) {
    //method yang didefinisikan di dalam sebuah kelas (widget) dan digunakan untuk mengembalikan tampilan (widget) dari kelas tersebut.
    if (isReading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  bookContent,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    markAsRead(books
                        .firstWhere((element) => element.startsWith('Buku')));
                  },
                  child: Text('Sudah Dibaca'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isReading = false;
                    });
                  },
                  child: Text('Kembali'),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: books.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.network(
                'https://images.pexels.com/photos/2741079/pexels-photo-2741079.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                height: 100.0,
                width: 75.0,
                fit: BoxFit.cover,
              ),
              title: Text(
                books[index],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Buku Non Fiksi ${index + 1}',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              trailing: isBookRead(books[index]) & !isReading
                  ? Icon(Icons.check_box)
                  : ElevatedButton(
                      onPressed: () {
                        readBook(books[index]);
                      },
                      child: Text('Baca'),
                    ),
            );
          },
        ),
        floatingActionButton: readBooks.isEmpty
            ? null
            : FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final TextEditingController controller =
                          TextEditingController();
                      return AlertDialog(
                        title: Text('Buku Sudah Dibaca'),
                        content: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'Masukkan judul buku yang sudah dibaca',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                readBooks.add(controller.text);
                                Navigator.pop(context);
                              });
                            },
                            child: Text('Simpan'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Batal'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(Icons.check),
              ),
      );
    }
  }
}
