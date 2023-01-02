import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';

class KisilerDaoRepo{
  Future<void> kaydet(String kisi_ad, String kisi_tel)async{
    print("Kişi kayıt : $kisi_ad - $kisi_tel");
  }

  Future<void> guncelle(int kisi_id, String kisi_ad, String kisi_tel)async{
    print("kisi güncelle : $kisi_id - $kisi_ad - $kisi_tel");
  }

  Future<List<Kisiler>> KisileriYukle()async{
    var kisilerListesi = <Kisiler>[];
    var k1 = Kisiler(kisi_id: 1, kisi_ad: "Ahmet", kisi_tel: "879");
    var k2 = Kisiler(kisi_id: 2, kisi_ad: "Mert", kisi_tel: "08080");
    var k3 = Kisiler(kisi_id: 3, kisi_ad: "hilal", kisi_tel: "09098");
    kisilerListesi.add(k1);
    kisilerListesi.add(k2);
    kisilerListesi.add(k3);
    return kisilerListesi;
  }

  Future<List<Kisiler>> ara(String aramaKelimesi)async{
    var kisilerListesi = <Kisiler>[];
    var k1 = Kisiler(kisi_id: 1, kisi_ad: "Ahmet", kisi_tel: "879");

    kisilerListesi.add(k1);

    return kisilerListesi;
  }
  Future<void>sil(int kisi_id)async{
    print("kisi sil: $kisi_id");
  }
}