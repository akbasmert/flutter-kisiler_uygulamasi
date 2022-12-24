import 'package:flutter/material.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'package:kisiler_uygulamasi/ui/screen/kisi_detay_sayfa.dart';
import 'package:kisiler_uygulamasi/ui/screen/kisi_kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ?
        TextField(decoration: InputDecoration(hintText:  "Ara"),
        onChanged: (aramaSonucu){
          print("kisi ara :$aramaSonucu");
        },
        ) :
        Text("Kişiler"),
        actions: [
          aramaYapiliyorMu ?
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = false;
            });
          },
              icon: const Icon(Icons.clear),
          ) :
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = true;
            });
          },
            icon: const Icon(Icons.search),
          ) ,
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: (){
              var kisi = Kisiler(kisi_id: 1, kisi_ad: "Ahmet", kisi_tel: "11111");
              Navigator.push(context, MaterialPageRoute(builder:(context) => KisiDetaySayfa(kisi: kisi,) ));
            },
                child: Text("DETAY"),

            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder:(context) => KisiKayitSayfa() ));

          },
        child: const Icon(Icons.add),
      ),
    );
  }
}
