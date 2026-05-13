import 'package:flutter/material.dart';
import 'package:magang_yusuf/api_yusuf.dart';

class HalamanFormRank extends StatefulWidget {
  const HalamanFormRank({super.key});

  @override
  State<HalamanFormRank> createState() =>
      _HalamanFormRankState();
}

class _HalamanFormRankState
    extends State<HalamanFormRank> {

  final TextEditingController usernameController =
      TextEditingController();

  List rankList = [];

  String? selectedRank;
  String? selectedRankTitle;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadRank();
  }

  Future<void> loadRank() async {

    final data = await ApiYusuf.getTitle();

    print("DATA RANK:");
    print(data);

    setState(() {

      rankList = data;

    });
  }

  Future<void> submit() async {

    if (selectedRank == null) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text("Pilih rank dulu"),
        ),
      );

      return;
    }

    print("USERNAME:");
    print(usernameController.text);

    print("RANK:");
    print(selectedRank);

    ScaffoldMessenger.of(context).showSnackBar(

      const SnackBar(
        content: Text("Berhasil submit"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Form Rank"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            // INPUT USERNAME
            TextField(

              controller: usernameController,

              decoration: const InputDecoration(

                labelText: "Username",

                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // DROPDOWN RANK
            rankList.isEmpty

            ? const CircularProgressIndicator()

            : DropdownButtonFormField<String>(

                hint: const Text("Pilih Rank"),

                value: selectedRank,

                items: rankList.map<DropdownMenuItem<String>>((item) {

                  print(item);

                  return DropdownMenuItem<String>(

                    value: item['id'].toString(),

                    child: Text(
                      item['title'].toString(),
                    ),
                  );

                }).toList(),

                onChanged: (value) {

                  final selectedItem = rankList.firstWhere(

                    (item) => item['id'].toString() == value,

                  );

                  setState(() {

                    selectedRank = value;

                    selectedRankTitle =
                        selectedItem['title'].toString();

                  });

                  print("ID:");
                  print(selectedRank);

                  print("TITLE:");
                  print(selectedRankTitle);
                },

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),

            const SizedBox(height: 20),

            // BUTTON
            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

              onPressed: () async {

                // VALIDASI
                if (usernameController.text.isEmpty) {

                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(
                      content: Text(
                        "Username wajib diisi",
                      ),
                    ),
                  );

                  return;
                }

                if (selectedRank == null) {

                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(
                      content: Text(
                        "Pilih rank dulu",
                      ),
                    ),
                  );

                  return;
                }

                // HIT API
                final success = await ApiYusuf.insertQr(

                  username: usernameController.text,

                  title: selectedRankTitle!,
                );

                // HASIL
                if (success) {

                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(
                      content: Text(
                        "Berhasil submit",
                      ),
                    ),
                  );

                  Navigator.pop(context);

                } else {

                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(
                      content: Text(
                        "Gagal submit",
                      ),
                    ),
                  );
                }
              },

              child: const Text(
                "Submit",
              ),
            )
            ),
          ],
        ),
      ),
    );
  }
}