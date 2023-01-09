import 'package:dio/dio.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kisiler_uygulamasi/data/entity/kisiler_cevap.dart';

class KisilerDaoRepository {
  List<Kisiler> parseKisilerCevap(String cevap){
    return KisilerCevap.fromJson(json.decode(cevap)).kisiler;
  }

  Future<void> kaydet(String kisi_ad,String kisi_tel) async {
  /* var url = Uri.parse("http://kasimadalan.pe.hu/kisiler/insert_kisiler.php");
  var veri = {"kisi_ad":kisi_ad,"kisi_tel":kisi_tel};
  var cevap = await http.post(url,body: veri);
  print("kisi kaydı : ${cevap.body}"); */ // http kütüphanesi kodları
    // Dio kodları
    var url = "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php";
    var veri = {"kisi_ad": kisi_ad, "kisi_tel": kisi_tel};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("kisi ekle: ${cevap.data.toString()}");

  }

  Future<void> guncelle(int kisi_id,String kisi_ad,String kisi_tel) async {
   /* var url = Uri.parse("http://kasimadalan.pe.hu/kisiler/update_kisiler.php");
    var veri = {"kisi_id":kisi_id.toString(), "kisi_ad":kisi_ad,"kisi_tel":kisi_tel};
    var cevap = await http.post(url,body: veri);//http kütüphanesine sadeve string veri gönderilir.
    print("kisi guncellendi : ${cevap.body}"); */
    var url = "http://kasimadalan.pe.hu/kisiler/update_kisiler.php";
    var  veri = {"kisi_id":kisi_id,"kisi_ad":kisi_ad,"kisi_tel":kisi_tel};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("kisi güncellendi: ${cevap.data.toString()}");
  }

  Future<List<Kisiler>> kisileriYukle() async {
   /* var url = Uri.parse("http://kasimadalan.pe.hu/kisiler/tum_kisiler.php");
    var cevap = await http.get(url);
    return parseKisilerCevap(cevap.body);*/ //http kütüphanesi kodları
    // dio kütüphanesi kodları
    var url =  "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php";
    var cevap = await Dio().get(url); // bizden değer istemediği için get isteseydi post
    return parseKisilerCevap(cevap.data.toString());
  }

  Future<List<Kisiler>> ara(String aramaKelimesi) async {
   /* var url = Uri.parse("http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php");
    var veri = { "kisi_ad":aramaKelimesi};
    var cevap = await http.post(url,body: veri);
    return parseKisilerCevap(cevap.body);*/
    var url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php";
    var veri = {"kisi_ad":aramaKelimesi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    return parseKisilerCevap(cevap.data.toString());

    }

  Future<void> sil(int kisi_id) async {
    /*
    var url = Uri.parse("http://kasimadalan.pe.hu/kisiler/delete_kisiler.php");
    var veri = {"kisi_id":kisi_id.toString()};
    var cevap = await http.post(url,body: veri);//http kütüphanesine sadeve string veri gönderilir.
    print("kisi silindi : ${cevap.body}");
     */
    var url = "http://kasimadalan.pe.hu/kisiler/delete_kisiler.php";
    var veri = {"kisi_id":kisi_id};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("kisi sil: ${cevap.data.toString()}");
  }
}