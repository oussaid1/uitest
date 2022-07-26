import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:uitest/extentions.dart';

import '../autocomplete.dart';
import '../glass_widgets.dart';
import '../models/models.dart';
import '../responssive.dart';
import '../theme.dart';
import 'date_picker.dart';
import 'number_incrementer.dart';

class AddOrEditProduct extends StatefulWidget {
  final DateTime? initialDateTime;
  final num? initialValue;

  const AddOrEditProduct(
      {Key? key, this.product, this.initialDateTime, this.initialValue})
      : super(key: key);

  final ProductModel? product;
  @override
  AddOrEditProductState createState() => AddOrEditProductState();
}

class AddOrEditProductState extends State<AddOrEditProduct> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController barcodeController =
      TextEditingController(text: '123');
  final TextEditingController productNameController =
      TextEditingController(text: 'MacBook Pro');
  final TextEditingController priceInController =
      TextEditingController(text: '1000');
  final TextEditingController priceOutController =
      TextEditingController(text: '1200');
  final TextEditingController descrController =
      TextEditingController(text: 'This is a product description');
  String productCat = 'Other';
  String suplier = 'Other';
  DateTime _pickedDateTime = DateTime.now();
  num quantity = 1;
  bool canSave = false;

  /// this method clears all the controllers
  void clear() {
    barcodeController.clear();
    productNameController.clear();
    priceInController.clear();
    priceOutController.clear();
    descrController.clear();
  }

  void initializeFields() {
    if (widget.product != null) {
      barcodeController.text = widget.product!.barcode!;
      productNameController.text = widget.product!.productName;
      priceInController.text = widget.product!.priceIn.toString();
      priceOutController.text = widget.product!.priceOut.toString();
      descrController.text = widget.product!.description!;
      _pickedDateTime = widget.product!.dateIn;
      productCat = widget.product!.category!;
      suplier = widget.product!.suplier!;
      quantity = widget.product!.quantity;
    }
    if (widget.initialDateTime != null) {
      _pickedDateTime = widget.initialDateTime!;
    }
    if (widget.initialValue != null) {
      quantity = widget.initialValue!;
    }
  }

  @override
  void initState() {
    initializeFields();
    super.initState();
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildFields(
          context,
          [],
        ),
      ],
    );
  }

  buildFields(BuildContext context, List<String> suplierList) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: Responsive.isDesktop(context) ? 600 : context.width - 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Theme.of(context).dialogBackgroundColor,
        // gradient: MThemeData.gradient1,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            //buildBarcode(ref),
            //const SizedBox(height: 8),
            Form(
              key: formKey,
              child: Column(
                children: [
                  _buildProductName(),
                  const SizedBox(height: 20),
                  _buildPriceIn(),
                  const SizedBox(height: 20),
                  _buildPriceOut(),
                  const SizedBox(height: 20),
                  _buildQuantity(context),
                  const SizedBox(height: 20),
                  _buildCategory(context, []),
                  const SizedBox(height: 20),
                  _buildDate(),
                  const SizedBox(height: 20),
                  _buildSuplier(context),
                  const SizedBox(height: 20),
                  _buildDescription(),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            _buildSaveButton(context),
            const SizedBox(height: 100) //but
          ],
        ),
      ),
    );
  }

  _buildSaveButton(BuildContext context) {
    // var prdBloc =
    //     ProductBloc(databaseOperations: GetIt.I<DatabaseOperations>());
    return widget.product == null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: MThemeData.raisedButtonStyleSave,
                onPressed: !canSave
                    ? null
                    : () {
                        final product = ProductModel(
                          barcode: barcodeController.text.trim(),
                          dateIn: _pickedDateTime,
                          description: descrController.text.trim(),
                          category: productCat,
                          productName: productNameController.text.trim(),
                          priceIn:
                              double.tryParse(priceInController.text.trim())!,
                          priceOut:
                              double.tryParse(priceOutController.text.trim())!,
                          quantity: quantity.toInt(),
                          suplier: suplier,
                        );

                        if (formKey.currentState!.validate()) {
                          setState(() {
                            canSave = false;
                          });
                          //prdBloc.add(AddProductEvent(product));
                        }
                      },
                child: Text(
                  'Save'.tr(),
                ),
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
                  'Update'.tr(),
                ),
                onPressed: !canSave
                    ? null
                    : () {
                        final product = ProductModel(
                          pId: widget.product!.pId,
                          barcode: barcodeController.text.trim(),
                          dateIn: _pickedDateTime,
                          description: descrController.text.trim(),
                          category: productCat,
                          productName: productNameController.text.trim(),
                          priceIn:
                              double.tryParse(priceInController.text.trim())!,
                          priceOut:
                              double.tryParse(priceOutController.text.trim())!,
                          quantity: quantity.toInt(),
                          suplier: suplier,
                        );

                        if (formKey.currentState!.validate()) {
                          setState(() {
                            canSave = false;
                          });
                          // prdBloc.add(
                          //   UpdateProductEvent(product),
                          // );
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

  _buildSuplier(BuildContext context) {
    return SuplierAutocompleteField(onChanged: (suplier) {
      setState(() {
        suplier = suplier;
      });
    });
  }

  _buildDescription() {
    return TextFormField(
      controller: descrController,
      validator: (text) {
        return null;
      },
      maxLines: 4,
      maxLength: 100,
      decoration: InputDecoration(
        labelText: 'Description'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: AppConstants.whiteOpacity),
        ),
        //border: InputBorder.none,
        hintText: 'description_hint'.tr(),
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        filled: true,
        contentPadding: const EdgeInsets.all(18.0),
      ),
    );
  }

  _buildCategory(BuildContext context, List<String> list) {
    return CategoryAutocompleteField(
      onChanged: (category) {
        setState(() {
          productCat = category;
        });
      },
    );
  }

  _buildDate() {
    return SizedBox(
      width: 400,
      child: SelectDate(
        initialDate: widget.initialDateTime ?? DateTime.now(),
        onDateSelected: (date) {
          toast(
            'date: $date',
            context: context,
          );
          setState(() {
            _pickedDateTime = date;
          });
        },
      ),
    );
  }

  _buildQuantity(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: NumberIncrementerWidget(
        initialValue: quantity,
        onChanged: (num number) {
          setState(() {
            quantity = number;
          });
        },
      ),
    );
  }

  _buildPriceOut() {
    return TextFormField(
      controller: priceOutController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
      ],
      textAlign: TextAlign.center,
      maxLength: 10,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        counterText: '',
        labelText: 'Price-out'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: AppConstants.whiteOpacity),
        ),
        hintText: '1434 dh',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.monetization_on),
        filled: true,
      ),
    );
  }

  _buildPriceIn() {
    return TextFormField(
      controller: priceInController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9.]+')),
      ],
      textAlign: TextAlign.center,
      maxLength: 10,
      decoration: InputDecoration(
        counterText: '',
        labelText: 'Price-in'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: AppConstants.whiteOpacity),
        ),
        //border: InputBorder.none,
        hintText: '1234 \$',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.monetization_on_outlined),
        filled: true,
      ),
    );
  }

  _buildProductName() {
    return TextFormField(
      controller: productNameController,
      validator: (text) {
        if (text!.trim().isEmpty) {
          return "error".tr();
        }
        return null;
      },
      onChanged: (String value) {
        setState(() {
          canSave = value.isNotEmpty;
        });
      },
      maxLength: 40,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        counterText: '',
        labelText: 'Product-Name'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: BorderSide(color: AppConstants.whiteOpacity),
        ),
        hintText: 'iphone-x LCD',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.tag),
        filled: true,
      ),
    );
  }

  // _buildBarcode() {
  //   return TextFormField(
  //     controller: barcodeController,
  //     validator: (text) {
  //       if (text!.trim().isEmpty) {
  //         return "error".tr();
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: 'Barcode'.tr(),
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(6.0),
  //         borderSide: BorderSide(color: AppConstants.whiteOpacity),
  //       ),
  //       //  border: InputBorder.none,
  //       hintText: 'scan-barcode',
  //       hintStyle: Theme.of(context).textTheme.subtitle2!,
  //       contentPadding: const EdgeInsets.only(top: 4),
  //       prefixIcon: const Icon(Icons.qr_code_outlined),
  //       filled: true,
  //     ),
  //   );
  // }
}
