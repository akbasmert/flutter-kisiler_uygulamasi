import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'package:kisiler_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:kisiler_uygulamasi/ui/screen/kisi_detay_sayfa.dart';
import 'package:kisiler_uygulamasi/ui/screen/kisi_kayit_sayfa.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';

class Anasafya extends StatefulWidget {
  const Anasafya({Key? key}) : super(key: key);

  @override
  State<Anasafya> createState() => _AnasafyaState();
}

class _AnasafyaState extends State<Anasafya> {
  bool aramaYapiliyorMu = false;

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().kisileriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ?
        TextField(decoration: const InputDecoration(hintText: "Ara"),onChanged: (aramaSonucu){
          context.read<AnasayfaCubit>().ara(aramaSonucu);
        },) :
        const Text("Kişiler"),
        actions: [
          aramaYapiliyorMu ?
          IconButton(onPressed: (){
            setState(() {aramaYapiliyorMu = false;});
            context.read<AnasayfaCubit>().kisileriYukle();
          }, icon: const Icon(Icons.clear)) :
          IconButton(onPressed: (){
            setState(() {aramaYapiliyorMu = true;});
          }, icon: const Icon(Icons.search)),
        ],
      ),
      body: BlocBuilder<AnasayfaCubit,List<Kisiler>>(
        builder: (context,kisilerListesi){
          if(kisilerListesi.isNotEmpty){
            return ListView.builder(
              itemCount: kisilerListesi.length,//3
              itemBuilder: (context,indeks){//0,1,2
                var kisi = kisilerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => KisiDetaySayfa(kisi: kisi)))
                        .then((value) {    context.read<AnasayfaCubit>().kisileriYukle();
                    });
                  },
                  child: Card(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${kisi.kisi_ad} - ${kisi.kisi_tel}"),
                        ),
                        const Spacer(),
                        IconButton(onPressed: (){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${kisi.kisi_ad} silinsin mi?"),
                              action: SnackBarAction(
                                label: "Evet",
                                onPressed: (){
                                  context.read<AnasayfaCubit>().sil(int.parse(kisi.kisi_id));
                                },
                              ),
                            ),
                          );
                        }, icon: const Icon(Icons.delete_outline,color: Colors.black54,)),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => const KisiKayitSayfa()))
          .then((value) {    context.read<AnasayfaCubit>().kisileriYukle();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


