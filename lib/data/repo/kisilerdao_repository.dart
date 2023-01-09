import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kisiler_uygulamasi/data/entity/kisiler_cevap.dart';

class KisilerDaoRepository {
  List<Kisiler> parseKisilerCevap(String cevap){
    return KisilerCevap.fromJson(json.decode(cevap)).kisiler;
  }

  Future<void> kaydet(String kisi_ad,String kisi_tel) async {
    print("Kişi Kaydet : $kisi_ad - $kisi_tel");
  }

  Future<void> guncelle(int kisi_id,String kisi_ad,String kisi_tel) async {
    print("Kişi Güncelle : $kisi_id - $kisi_ad - $kisi_tel");
  }

  Future<List<Kisiler>> kisileriYukle() async {
    var url = Uri.parse("http://kasimadalan.pe.hu/kisiler/tum_kisiler.php");
    var cevap = await http.get(url);
    return parseKisilerCevap(cevap.body);
  }

  Future<List<Kisiler>> ara(String aramaKelimesi) async {
    var kisilerListesi = <Kisiler>[];
    var k1 = Kisiler(kisi_id: "1", kisi_ad: "Ahmet", kisi_tel: "1111");
    kisilerListesi.add(k1);
    return kisilerListesi;
  }

  Future<void> sil(int kisi_id) async {
    print("Kişi Sil : $kisi_id");
  }
}