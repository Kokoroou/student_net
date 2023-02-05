// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:student_net/models/settings/change_pass_model.dart';
import 'package:student_net/services/api_service.dart';

class EditPassPage extends StatefulWidget {
  @override
  _EditPassPageStage createState() => _EditPassPageStage();
}

class _EditPassPageStage extends State<EditPassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thay đổi mật khẩu',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
              imagePath: "assets/favicon.png",
              isEdit: true,
              onClicked: () async {}),
          const SizedBox(
            height: 24,
          ),
          TextFieldWidget(
              label: "", ho: "", ten_dem: "", ten: "", onChanged: (name) {}),
        ],
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}

class TextFieldWidget extends StatefulWidget {
  final int maxLines;
  final String label;
  final String ho;
  final String ten_dem;
  final String ten;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    required this.label,
    required this.ho,
    required this.ten_dem,
    required this.ten,
    required this.onChanged,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;
  late final TextEditingController controller1;
  late final TextEditingController controller2;
  late String mk_hientai, mk_moi, nhap_lai_mk;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.ho);
    controller1 = TextEditingController(text: widget.ten_dem);
    controller2 = TextEditingController(text: widget.ten);
    mk_hientai = widget.ho;
    mk_moi = widget.ten_dem;
    nhap_lai_mk = widget.ten;
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        add_field("Mật khẩu hiện tại", controller),
        const SizedBox(
          height: 24,
        ),
        add_field("Mật khẩu mới", controller1),
        const SizedBox(
          height: 24,
        ),
        add_field("Nhập lại mật khẩu mới", controller2),
        const SizedBox(
          height: 24,
        ),
        TextButton(
          style: TextButton.styleFrom(
            // textStyle: const TextStyle(fontSize: 20, color: Colors.white),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            // print(first_name_field.getText());
            if (mk_moi != nhap_lai_mk) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Thông báo'),
                  content: const Text('Nhập lại mật khẩu không đúng'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            } else if (mk_moi == mk_hientai) {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Thông báo'),
                  content:
                      const Text('Mật khẩu mới trùng với mật khẩu hiện tại'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            } else {
              ChangePassRequestModel requestModel = ChangePassRequestModel(
                token:
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzYzNiZDUyOTgxNTJmZjUzYjI2MDgwNSIsImRhdGVMb2dpbiI6IjIwMjMtMDItMDRUMDI6Mjg6MTAuMDI0WiIsImlhdCI6MTY3NTQ3NzY5MCwiZXhwIjoxNjg1NDc3Njg5fQ.m5-TFsgCleDtuZEapE_ovS3WgjxQmH8mT29mQtRUcSE",
                password: mk_hientai,
                new_password: mk_moi,
              );

              APIService.change_password(requestModel).then((reponse) {
                if (reponse == 200) {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Thông báo'),
                            content: const Text('Thay đổi mật khẩu thành công'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ));
                } else if (reponse == 400) {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text('Thông báo'),
                            content: const Text(
                                'Thay đổi mật khẩu không thành công. Xin thử lại'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ));
                } else {
                  print(reponse);
                }
                ;
              });
            }
          },
          child: const Text('Xác nhận',
              style: const TextStyle(fontSize: 18, color: Colors.white)),
        )
      ],
    );
  }

  Column add_field(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: widget.maxLines,
          onChanged: (String value) {
            if (label == "Mật khẩu hiện tại") {
              mk_hientai = value;
            } else if (label == "Mật khẩu mới") {
              mk_moi = value;
            } else {
              nhap_lai_mk = value;
            }
          },
        ),
      ],
    );
  }
}
