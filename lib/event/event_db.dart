import 'dart:convert';

import 'package:get/get.dart';
import 'package:project/config/api.dart';
import 'package:project/model/dosen.dart';
import 'package:project/model/mahasiswa.dart';
import 'package:project/widget/info.dart';
import 'package:http/http.dart' as http;

class EventDb {
  static Future<List<Mahasiswa>> getMahasiswa() async {
    List<Mahasiswa> listMahasiswa = [];

    try {
      var response = await http.get(Uri.parse(Api.getMahasiswa));
      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var mahasiswa = responBody['mahasiswa'];

          mahasiswa.forEach((mahasiswa) {
            listMahasiswa.add(Mahasiswa.fromJson(mahasiswa));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return listMahasiswa;
  }

  static Future<String> AddMahasiswa(
      String npm, String nama, String alamat) async {
    String reason;
    try {
      var response = await http.post(Uri.parse(Api.addMahasiswa),
          body: {'npm': npm, 
          'nama': nama, 
          'alamat': alamat});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Add Mahasiswa Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }
    return reason;
  }

  static Future<void> UpdateMahasiswa(
      String npm, String nama, String alamat) async {
    try {
      var response = await http.post(Uri.parse(Api.updateMahasiswa), body: {
        'npm': npm,
        'nama': nama,
        'alamat': alamat,
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Update Mahasiswa');
        } else {
          Info.snackbar('Berhasil Update Mahasiswa');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteMahasiswa(String npm) async {
    try {
      var response = await http
          .post(Uri.parse(Api.deleteMahasiswa), body: {'npm': npm});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Delete Mahasiswa');
        } else {
          Info.snackbar('Gagal Delete Mahasiswa');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //Event DB Dosen
  static Future<List<Dosen>> getDosen() async {
    List<Dosen> ListDosen = [];

    try {
      var response = await http.get(Uri.parse(Api.getDosen));
      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          var dosen = responBody['dosen'];

          dosen.forEach((dosen) {
            ListDosen.add(Dosen.fromJson(dosen));
          });
        }
      }
    } catch (e) {
      print(e);
    }

    return ListDosen;
  }

  static Future<String> AddDosen(
      String nidn, String nama, String alamat, String prodi) async {
    String reason;
    try {
      var response = await http.post(Uri.parse(Api.addDosen),
          body: {'nidn': nidn, 
          'nama': nama, 
          'alamat': alamat,
          'prodi': prodi});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          reason = 'Add Dosen Berhasil';
        } else {
          reason = responBody['reason'];
        }
      } else {
        reason = "Request Gagal";
      }
    } catch (e) {
      print(e);
      reason = e.toString();
    }
    return reason;
  }

  static Future<void> UpdateDosen(
      String nidn, String nama, String alamat, String prodi) async {
    try {
      var response = await http.post(Uri.parse(Api.updateDosen), body: {
        'nidn': nidn,
        'nama': nama,
        'alamat': alamat,
        'prodi': prodi,
      });

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Update Dosen');
        } else {
          Info.snackbar('Berhasil Update Dosen');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteDosen(String nidn) async {
    try {
      var response = await http
          .post(Uri.parse(Api.deleteDosen), body: {'nidn': nidn});

      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);
        if (responBody['success']) {
          Info.snackbar('Berhasil Delete Dosen');
        } else {
          Info.snackbar('Gagal Delete Dosen');
        }
      }
    } catch (e) {
      print(e);
    }
  }

}