import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../halaman_session.dart';

class SharedScreen extends StatefulWidget {
  const SharedScreen({super.key});

  @override
  State<SharedScreen> createState() => _SharedScreenState();
}

class _SharedScreenState extends State<SharedScreen> {
  final namaController = TextEditingController();
  final pinController = TextEditingController();
  bool isBuka = true;
  bool isDarkMode = false;
  bool isData = false;
  bool isLoading = true;
  bool isLoved = false;
  bool isLoved2 = false;
  bool isGambar = true;

  List<String> namaMahasiswa = [
    "ARDAN",
    "BRIENKA",
    "CHARISTA",
    "DENNY",
    "ERLAN"
  ];
  // String namaMhsTerpilih = "";
  String? namaMhsTerpilih;

  Future<void> hapusData() async {
    await Session.hapusShared();

    namaController.clear();
    pinController.clear();

    setState(() {
      isDarkMode = false;
      isData = false;
      namaMhsTerpilih = null;
      isLoved = false;
      isLoved2 = false;
    });
  }

  Future<void> simpanData() async {
    await Session.simpanShared(
      nama: namaController.text, 
      pin: pinController.text, 
      darkMode: isDarkMode, 
      mahasiswa: namaMhsTerpilih ?? '',
      loved: isLoved,
      loved2: isLoved2
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data berhasil disimpan')),
    );
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 3));
    final data = await Session.loadShared();
    final ada = await Session.adaSharedKah();

    if(!ada){
      setState(() {
        namaController.text = "TOLONG ISI NAMA ANDA DISINI";
        pinController.text = "PINNYA JUGA";
        isBuka = false;
        isData = false;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        namaController.text = data['nama'];
        pinController.text = data['pin'];
        isDarkMode = data['darkMode'];
        namaMhsTerpilih = data['mahasiswa'].isEmpty ? null : data['mahasiswa'];
        isData = ada;
        isLoved = data['loved'];
        isLoved2 = data['loved2']; 
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: Text(" BELAJAR MEMORI SHARED "),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: isLoading ? Center(child: CircularProgressIndicator(),) : Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                  label: Text("NAMA")
                ),
                onChanged: (value) {
                  simpanData();
                },
              ),
              TextFormField(
                onChanged: (value) {
                  simpanData();
                },
                controller: pinController,
                obscureText: isBuka,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  label: Text("PIN ANDA"),
                  suffixIcon:  IconButton(onPressed: (){
                    setState(() {
                      isBuka = !isBuka;
                    });
                  }, icon: Icon(isBuka ? Icons.lock : Icons.lock_open))
                ),
              ),
              SwitchListTile(
                title: Text(isDarkMode ? "DARK MODE" : "LIGHT MODE"),
                value: isDarkMode,
                onChanged: (val) {
                  setState(() {
                    isDarkMode = val;
                  });
                  simpanData();
                },
              ),
              DropdownButton(
                hint: Text("NAMA MAHASISWA"),
                value: namaMhsTerpilih,
                isExpanded: true,
                items: namaMahasiswa.map((jeneng) {
                  return DropdownMenuItem<String>(
                    value: jeneng,
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(jeneng),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    namaMhsTerpilih = val;
                  });
                  simpanData();
                },
              ),
              ValueListenableBuilder(
                valueListenable: Session.notifier,
                builder: (context, value, child) {
                  return Text("Data berubah: $value kali");
                },
              ),
              Padding(padding: EdgeInsets.all(15), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    hapusData();
                  }, child: Text("Hapus Data")),
                  ElevatedButton(onPressed: (){
                    simpanData();
                  }, child: Text("Simpan Data"))
                ],
              )
              ,),

              SizedBox(height: 10,),

              IconButton(
                icon: Icon(
                  isLoved ? Icons.favorite : Icons.favorite_border,
                  color: isLoved ? Colors.red : Colors.grey,
                  size: 100,
                ),
                onPressed: () {
                  setState(() {
                    isLoved = !isLoved;
                  });
                  simpanData();
                },
              ),

              SizedBox(height: 20,),

              IconButton(
                icon: Icon(
                  isLoved2 ? Icons.favorite : Icons.favorite_border,
                  color: isLoved2 ? Colors.red : Colors.grey,
                  size: 100,
                ),
                onPressed: () async  {
                  setState(() {
                    isLoved2 = !isLoved2;
                  });
                  simpanData();
                },
              ),

              ValueListenableBuilder(
                valueListenable: Session.notifier,
                builder: (context, value, child) {
                  return Text("Data berubah: $value kali");
                },
              ),

              SizedBox(height: 20,),

              ElevatedButton(onPressed: (){
                setState(() {
                  isGambar = !isGambar;
                });
              }, child: isGambar? Text("tampilkan gambar") : Text("tampilkan kotak")),

              Container(

                height: 50,
                width: 50,
                color: isGambar ? Colors.amber : null,
                child: isGambar
                    ? null
                    : Image.asset("asset/images/icons/instagram.png"),
              )

            ],
          ),
        ),
      ),
    );
  }
}