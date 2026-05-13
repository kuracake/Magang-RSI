import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormDanValid extends StatefulWidget {
  const FormDanValid({super.key});

  @override
  State<FormDanValid> createState() => _FormDanValidState();
}

class _FormDanValidState extends State<FormDanValid> {

  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form dan text",
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: usernameController,
                inputFormatters: [FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-Z0-9]')
                  ),
                  ],
                decoration: InputDecoration(
                  labelText: 'Username',
                  suffixIcon: usernameController.text.isNotEmpty
                  ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: (){
                      usernameController.clear();
                          setState(() {});
                    }
                  )
                  :null
                ),
                onChanged: (value) {
                  setState(() {
                  });
                },
                validator: (value) {
                  if (value==null || value.isEmpty) {
                    return 'Tidak Boleh Kosong Cuy';
                  }
                  if (value.length >10){
                    return 'Karakter Lebih Dari 10 Cuy';
                  }
                  if (value.contains(' ')){
                    return 'Tidak Boleh ada spasi Cuy';
                  }
                  return null;
                }, 
              ),

              TextFormField(
                controller: pinController,
                keyboardType: const TextInputType.numberWithOptions(signed: false, decimal: false),
                decoration: InputDecoration(
                  labelText: 'Pin',
                  suffixIcon: pinController.text.isNotEmpty
                  ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: (){
                      pinController.clear();
                          setState(() {});
                    }
                  )
                  :null
                ),
                onChanged: (value) {
                  setState(() {
                  });
                },
                validator: (value) {
                  if (value==null || value.isEmpty) {
                    return 'Tidak Boleh Kosong Cuy';
                  }
                  if (value.length!=6) {
                    return 'Wajin 6 Karakter Cuy';
                  }
                  return null;
                },  
              ),

              SizedBox(
                height: 30,
              ),
              ElevatedButton(onPressed: (){
                if (_formKey.currentState!.validate()) {

                  String namaHasil = usernameController.text;
                  String pinHasil = pinController.text;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Berhasil! Username: $namaHasil | PIN: $pinHasil'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
               }, child: Text("KIRIM"))

            ],
          ),
      )
      )
    );
  }
}