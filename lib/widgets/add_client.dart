import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/client/shop_client.dart';
import '../theme.dart';

class AddClient extends StatefulWidget {
  const AddClient({
    Key? key,
    this.client,
  }) : super(key: key);
  final ShopClientModel? client;

  @override
  AddClientState createState() => AddClientState();
}

class AddClientState extends State<AddClient> {
  bool _canSave = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController =
      TextEditingController(text: 'oussaid');
  final TextEditingController phoneController =
      TextEditingController(text: '0687888888');
  final TextEditingController emailController =
      TextEditingController(text: 'oussaid.abdellatif@gmail.com');
  double _rating = 3.5;

  void clear() {
    titleController.clear();
    phoneController.clear();
    emailController.clear();
  }

  @override
  void initState() {
    if (widget.client != null) {
      titleController.text = widget.client!.clientName.toString();
      phoneController.text = widget.client!.phone.toString();
      emailController.text = widget.client!.email.toString();
      _rating = widget.client!.stars;
    }
    super.initState();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    log('add stuff ${context.widget}');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildFlexible(context),
      ],
    );
  }

  buildFlexible(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            buildClientName(),
            const SizedBox(height: 20),
            buildClientPhone(),
            const SizedBox(height: 20),
            buildClientEmail(),
            const SizedBox(height: 20),
            buildRating(context),
            const SizedBox(height: 20),
            buildSaveButton(context),
            const SizedBox(
              height: 100,
            ) //but
          ],
        ),
      ),
    );
  }

  Row buildSaveButton(BuildContext context) {
    return widget.client != null
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
                    final client = ShopClientModel(
                      id: widget.client!.id,
                      clientName: titleController.text.trim(),
                      phone: phoneController.text.trim(),
                      email: emailController.text.trim(),
                      stars: _rating,
                    );
                    // context
                    //     .read<ShopClientBloc>()
                    //     .add(AddShopClientEvent(client));
                    // Navigator.pop(context);
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
                    final client = ShopClientModel(
                      clientName: titleController.text.trim(),
                      phone: phoneController.text.trim(),
                      email: emailController.text.trim(),
                      stars: _rating,
                    );
                    // widget.pContext
                    //     .read<ShopClientBloc>()
                    //     .add(AddShopClientEvent(client));
                    // Navigator.pop(context);

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

  TextFormField buildClientName() {
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
          _canSave = true;
        });
      },
      maxLength: 20,
      decoration: InputDecoration(
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: 'Client name'.tr(),
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.person_outline),
        filled: true,
        labelText: 'Client-name'.tr(),
      ),
    );
  }

  TextFormField buildClientPhone() {
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
        counterText: '',
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

  TextFormField buildClientEmail() {
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
      ),
    );
  }

  buildRating(BuildContext context) {
    return RatingBar.builder(
      initialRating: 3,
      itemSize: 32,
      minRating: 0,
      maxRating: 5,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _canSave = true;
          _rating = rating;
        });
      },
    );
  }
}
