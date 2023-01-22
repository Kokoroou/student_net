import 'dart:js';

import 'package:flutter/material.dart';

class EditNamePage extends StatefulWidget {
  @override
  _EditNamePageStage createState() => _EditNamePageStage();
}

class _EditNamePageStage extends State<EditNamePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thay đổi họ tên',
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
              imagePath: "assets/test2.png",
              isEdit: true,
              onClicked: () async {}),
          const SizedBox(
            height: 24,
          ),
          TextFieldWidget(label: "", ho: "Kuroba", ten_dem: "", ten: "Kaito", onChanged: (name) {}),
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
  late String ho, ten_dem, ten;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.ho);
    controller1 = TextEditingController(text: widget.ten_dem);
    controller2 = TextEditingController(text: widget.ten);
    ho = widget.ho;
    ten_dem = widget.ten_dem;
    ten = widget.ten;
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
        add_field("Họ", controller),
        const SizedBox(
          height: 24,
        ),
        add_field("Tên đệm", controller1),
        const SizedBox(
          height: 24,
        ),
        add_field("Tên", controller2),
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
            print(ho);
            print(ten_dem);
            print(ten);
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
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: widget.maxLines,
          onChanged: (String value) {
            if (label == "Họ") {
              ho = value;
            } else if (label == "Tên đệm") {
              ten_dem = value;
            } else {
              ten = value;
            }
          },
        ),
      ],
    );
  }
}
