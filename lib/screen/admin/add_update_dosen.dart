import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/config/asset.dart';
import 'package:project/event/event_db.dart';
import 'package:project/model/dosen.dart';
import 'package:project/screen/admin/list_dosen.dart';
import 'package:project/widget/info.dart';

class AddUpdateDosen extends StatefulWidget {
  final Dosen? dosen;
  AddUpdateDosen({this.dosen});

  @override
  State<AddUpdateDosen> createState() => _AddUpdateDosenState();
}

class _AddUpdateDosenState extends State<AddUpdateDosen> {
  var _formKey = GlobalKey<FormState>();
  var _controllernidn = TextEditingController();
  var _controllerNama = TextEditingController();
  var _controllerAlamat = TextEditingController();
  var _controllerProdi = TextEditingController();

  bool _isHidden = true;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.dosen != null) {
      _controllernidn.text = widget.dosen!.nidn!;
      _controllerNama.text = widget.dosen!.nama!;
      _controllerAlamat.text = widget.dosen!.alamat!;
      _controllerProdi.text = widget.dosen!.prodi!;
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // titleSpacing: 0,
        title: widget.dosen != null
            ? Text('Update Dosen')
            : Text('Tambah Dosen'),
        backgroundColor: Asset.colorPrimary,
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                TextFormField(
                  enabled: widget.dosen == null ? true : false,
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllernidn,
                  decoration: InputDecoration(
                      labelText: "Nidn",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerNama,
                  decoration: InputDecoration(
                      labelText: "Nama",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value == '' ? 'Jangan Kosong' : null,
                  controller: _controllerAlamat,
                  decoration: InputDecoration(
                      labelText: "Alamat",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.dosen == null) {
                        String message = await EventDb.AddDosen(
                          _controllernidn.text,
                          _controllerNama.text,
                          _controllerAlamat.text,
                          _controllerProdi.text,
                        );
                        Info.snackbar(message);
                        if (message.contains('Berhasil')) {
                          _controllernidn.clear();
                          _controllerNama.clear();
                          _controllerAlamat.clear();
                          _controllerProdi.clear();
                          Get.off(
                            ListDosen(),
                          );
                        }
                      } else {
                        EventDb.UpdateDosen(
                          _controllernidn.text,
                          _controllerNama.text,
                          _controllerAlamat.text,
                          _controllerProdi.text,
                        );
                        Get.off(
                          ListDosen(),
                        );
                      }
                    }
                  },
                  child: Text(
                    widget.dosen == null ? 'Simpan' : 'Ubah',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Asset.colorAccent,
                      fixedSize: Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}