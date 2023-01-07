import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'package:kisiler_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:kisiler_uygulamasi/ui/screen/kisi_detay_sayfa.dart';
import 'package:kisiler_uygulamasi/ui/screen/kisi_kayit_sayfa.dart';
class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);
//tamam
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;
  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().KisileriYukle();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ?
        TextField(decoration: InputDecoration(hintText:  "Ara"),
        onChanged: (aramaSonucu){
        context.read<AnasayfaCubit>().ara(aramaSonucu);
        },
        ) :
        Text("Kişiler"),
        actions: [
          aramaYapiliyorMu ?
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = false;
            });
            context.read<AnasayfaCubit>().KisileriYukle();
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
      body: BlocBuilder<AnasayfaCubit,List<Kisiler>>(

        builder: (context, kisilerListesi){
          if(kisilerListesi.isNotEmpty){
            return ListView.builder(
              itemCount: kisilerListesi.length,
              itemBuilder:  (context,indeks){
                var kisi = kisilerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>KisiDetaySayfa(kisi: kisi)))
                        .then((value) { context.read<AnasayfaCubit>().KisileriYukle();});
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
                                  context.read<AnasayfaCubit>().sil(kisi.kisi_id)
                                      .then((value){
                                        context.read<AnasayfaCubit>().KisileriYukle();
                                  });

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
          }else{//asfasf
            return const Center();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder:(context) => KisiKayitSayfa() ))
                .then((value){
                  context.read<AnasayfaCubit>().KisileriYukle();
            });

          },
        child: const Icon(Icons.add),
      ),
    );
  }
}
