import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/suplier/suplier.dart';
import '../theme.dart';

class AddSuplier extends StatefulWidget {
  const AddSuplier({Key? key, this.suplier}) : super(key: key);
  final SuplierModel? suplier;
  @override
  AddSuplierState createState() => AddSuplierState();
}

class AddSuplierState extends State<AddSuplier> {
  final GlobalKey<FormState> _mformKey = GlobalKey<FormState>();
  final TextEditingController titleController =
      TextEditingController(text: 'Hanana');
  final TextEditingController phoneController =
      TextEditingController(text: '0789989898');
  final TextEditingController emailController =
      TextEditingController(text: 'hanana@gmail.com');
  bool _canSave = false;
  void clear() {
    titleController.clear();
    phoneController.clear();
    emailController.clear();
  }

  @override
  void initState() {
    if (widget.suplier != null) {
      titleController.text = widget.suplier!.name.toString();
      phoneController.text = widget.suplier!.phone.toString();
      emailController.text = widget.suplier!.email.toString();
    }
    super.initState();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  void launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _mformKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 50),
              buildSuplierName(),
              const SizedBox(height: 20),
              buildSuplierPhone(),
              const SizedBox(height: 20),
              buildSuplierEmail(),
              // const SizedBox(height: 20),
              // buildLocation(context),
              const SizedBox(height: 40),
              buildSaveButton(context),
              const SizedBox(height: 100) //but
            ],
          ),
        ),
      ),
    );
  }

  buildSaveButton(BuildContext context) {
    /// an instance of the bloc
    // var supBloc =
    //     SuplierBloc(databaseOperations: GetIt.I<DatabaseOperations>());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
            style: MThemeData.raisedButtonStyleSave,
            onPressed: !_canSave
                ? null
                : () {
                    toast('save ${_mformKey.currentState!.validate()}');
                    if (_mformKey.currentState!.validate()) {
                      _mformKey.currentState!.save();
                      toast('save');
                      Navigator.pop(context);
                    }
                  },
            child: Text(
              widget.suplier != null ? 'Update' : 'Save',
            )),
        ElevatedButton(
          style: MThemeData.raisedButtonStyleCancel,
          child: Text(
            'Cancel'.tr(),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  TextFormField buildSuplierName() {
    return TextFormField(
      controller: titleController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      onChanged: (text) {
        setState(() {
          _canSave = text.trim().isNotEmpty;
        });
      },
      maxLength: 50,
      decoration: InputDecoration(
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: 'suplier name'.tr(),
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.person_outline),
        filled: true,
        labelText: 'Suplier-Name'.tr(),
      ),
    );
  }

  TextFormField buildSuplierPhone() {
    return TextFormField(
      controller: phoneController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      maxLength: 10,
      decoration: InputDecoration(
        // counterText:''  ,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: 'phone number'.tr(),
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.phone),
        filled: true,
        labelText: 'Phone'.tr(),
      ),
    );
  }

  TextFormField buildSuplierEmail() {
    return TextFormField(
      controller: emailController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      maxLength: 50,
      decoration: InputDecoration(
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: 'email'.tr(),
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.email),
        filled: true,
        labelText: 'Email'.tr(),
      ),
    );
  }

  Row buildLocation(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            top: 8,
          ),
          child: Text(
            'Location'.tr(),
            style: Theme.of(context).textTheme.subtitle2!,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              // border: Border.all(color: Theme.of(context).bottomAppBarColor),
              borderRadius: BorderRadius.circular(6)),
          height: 50,
          width: 160,
          child: Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.location_on_outlined),
                  // color: MThemeData.accentColor,
                  onPressed: () {
                    launchMapsUrl(SuplierModel.laayoune.latitude,
                        SuplierModel.laayoune.longitude);
                  }),
            ],
          ),
        ),
      ],
    );
  }
}
