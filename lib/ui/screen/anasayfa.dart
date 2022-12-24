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

  Future<List<Kisiler>> tumKisileriGoster()async{
    var kisilerListesi = <Kisiler>[];
    var k1 = Kisiler(kisi_id: 1, kisi_ad: "Ahmet", kisi_tel: "9879879");
    var k2 = Kisiler(kisi_id: 2, kisi_ad: "Mert", kisi_tel: "08080");
    var k3 = Kisiler(kisi_id: 3, kisi_ad: "hilal", kisi_tel: "09098");
    kisilerListesi.add(k1);
    kisilerListesi.add(k2);
    kisilerListesi.add(k3);
    return kisilerListesi;
  }
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
      body: FutureBuilder<List<Kisiler>>(
        future: tumKisileriGoster(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var kisilerListesi = snapshot.data;
            return ListView.builder(
              itemCount: kisilerListesi!.length,
              itemBuilder:  (context,indeks){
                var kisi = kisilerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>KisiDetaySayfa(kisi: kisi)));
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Text("${kisi.kisi_ad} - ${kisi.kisi_tel}"),
                        Spacer(),
                        IconButton(onPressed: (){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content:
                            Text("${kisi.kisi_ad} silinsinmi?"),
                              action: SnackBarAction(
                                label: "Evet",
                                onPressed: (){
                                  print("Kisi sil : ${kisi.kisi_id}");
                                },
                              ),
                            )
                          );
                        }, icon: Icon(Icons.delete_forever_outlined, color: Colors.black54,),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return const Center();
          }
        },
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
