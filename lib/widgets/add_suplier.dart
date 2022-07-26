import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/extentions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/suplier/suplier.dart';
import '../responssive.dart';
import '../theme.dart';

class AddSuplier extends ConsumerStatefulWidget {
  const AddSuplier({Key? key, this.suplier}) : super(key: key);
  final SuplierModel? suplier;
  @override
  AddSuplierState createState() => AddSuplierState();
}

class AddSuplierState extends ConsumerState<AddSuplier> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

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
      //ref.read(suplierLocationProvider.state).state = widget.suplier!.location!;
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
    return SizedBox(
      width: context.width,
      height: context.height,
      child: Column(
        children: [
          //InStockWidget(dBSupliers: dBSupliers),
          buildFlexible(context, ref),
        ],
      ),
    );
  }

  Flexible buildFlexible(BuildContext context, WidgetRef ref) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 2,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          width: Responsive.isDesktop(context) ? 600 : context.width - 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            //color: Theme.of(context).colorScheme.onBackground,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                buildSuplierName(ref),
                const SizedBox(height: 20),
                buildSuplierPhone(ref),
                const SizedBox(height: 20),
                buildSuplierEmail(ref),
                const SizedBox(height: 20),
                buildLocation(ref, context),
                const SizedBox(height: 40),
                buildSaveButton(ref, context),
                const SizedBox(height: 100) //but
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildSaveButton(WidgetRef ref, BuildContext context) {
    return widget.suplier != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  style: MThemeData.raisedButtonStyleSave,
                  child: Text(
                    'Update'.tr(),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final suplier = SuplierModel(
                        id: widget.suplier!.id,
                        name: titleController.text.trim(),
                        phone: phoneController.text.trim(),
                        email: emailController.text.trim(),
                        location: widget.suplier!.location!,
                      );
                      // GetIt.I<SuplierBloc>().add(UpdateSupliersEvent(suplier));
                      // Navigator.pop(context);
                    }
                  }),
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
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: MThemeData.raisedButtonStyleSave,
                child: Text(
                  'Save'.tr(),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final suplier = SuplierModel(
                      name: titleController.text.trim(),
                      phone: phoneController.text.trim(),
                      email: emailController.text.trim(),
                      location: SuplierModel.laayoune,
                    );
                    // GetIt.I<SuplierBloc>().add(AddSupliersEvent(suplier));
                  }
                },
              ),
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

  TextFormField buildSuplierName(WidgetRef ref) {
    return TextFormField(
      controller: titleController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      decoration: InputDecoration(
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

  TextFormField buildSuplierPhone(WidgetRef ref) {
    return TextFormField(
      controller: phoneController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      decoration: InputDecoration(
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

  TextFormField buildSuplierEmail(WidgetRef ref) {
    return TextFormField(
      controller: emailController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      decoration: InputDecoration(
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

  Row buildLocation(WidgetRef ref, BuildContext context) {
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
              border: Border.all(color: Theme.of(context).bottomAppBarColor),
              borderRadius: BorderRadius.circular(6)),
          height: 50,
          width: 160,
          child: Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.location_on_outlined),
                  color: MThemeData.accentColor,
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
