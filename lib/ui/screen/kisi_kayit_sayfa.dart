import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/ui/cubit/kisi_kayit_cubit.dart';

class KisiKayitSayfa extends StatefulWidget {
  const KisiKayitSayfa({Key? key}) : super(key: key);

  @override
  State<KisiKayitSayfa> createState() => _KisiKayitSayfaState();
}

class _KisiKayitSayfaState extends State<KisiKayitSayfa> {
  var tfKisiAd = TextEditingController();
  var tfKisiTel = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kişi Kayıt"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0,right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfKisiAd,
                decoration: const InputDecoration(hintText: "Kisi Ad:"),
              ),
              TextField(
                controller: tfKisiTel,
                decoration: const InputDecoration(hintText: "Kisi Tel:"),
              ),
              ElevatedButton(onPressed: (){
                context.read<KisiKayitCubit>().kaydet(tfKisiAd.text, tfKisiTel.text);
              },
                child: Text("Kaydet"),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
