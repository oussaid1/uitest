import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uitest/autocomplete.dart';
import 'package:uitest/spinner.dart';

import '../../../models/models.dart';
import '../theme.dart';
import 'date_picker.dart';

class AddOrEditSaleWidget extends ConsumerStatefulWidget {
  final SaleModel? sale;
  final ProductModel? product;
  final DateTime? initialDate;
  final int? initialQuantity;
  const AddOrEditSaleWidget({
    Key? key,
    this.sale,
    this.product,
    this.initialDate,
    this.initialQuantity,
  }) : super(key: key);

  @override
  UpdateSaleState createState() => UpdateSaleState();
}

class UpdateSaleState extends ConsumerState<AddOrEditSaleWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController priceController = TextEditingController();
  DateTime pickedDate = DateTime.now();
  String clientID = '';
//////////////////////////////////////////////////////////////////////////////////////////////
  void clear() {
    priceController.clear();
  }

//////////////////////////////////////////////////////////////////////////////////////////////
  void _handleDatePicked(DateTime date) {
    setState(() {
      pickedDate = date;
    });
  }

//////////////////////////////////////////////////////////////////////////////////////////////
  void initialize() {
    if (widget.sale != null) {
      priceController.text = widget.sale!.priceSoldFor.toString();
      pickedDate = widget.sale!.dateSold;
    }
  }

  @override
  void dispose() {
    priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: 20),
          buildClientName([]),
          const SizedBox(height: 10),
          //buildQuantity(context, ref),
          Form(key: formKey, child: buildPrice(ref, priceController)),
          const SizedBox(height: 10),
          buildDate(widget.initialDate ?? pickedDate),
          const SizedBox(height: 30),
          buildSaveButton(context, ref),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  buildSaveButton(
    BuildContext context,
    WidgetRef ref,
  ) {
    return widget.sale != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                child: Text(
                  'Cancel'.tr(),
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                child: Text(
                  'Save'.tr(),
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
                onPressed: () {
                  SaleModel sale = SaleModel(
                    shopClientId: widget.sale!.shopClientId,
                    priceSoldFor: double.parse(priceController.text),
                    type: widget.sale!.type,
                    quantitySold: widget.sale!.quantitySold,
                    dateSold: pickedDate,
                    productId: widget.sale!.productId,
                  );
                  if (formKey.currentState!.validate()) {
                    //  GetIt.I.get<SalesBloc>().add(UpdateSalesEvent(sale));
                  }
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
                onPressed: () {
                  //check the form is valid
                  SaleModel sale = SaleModel(
                    shopClientId: widget.sale!.shopClientId,
                    priceSoldFor: double.parse(priceController.text),
                    type: widget.sale!.type,
                    quantitySold: widget.sale!.quantitySold,
                    dateSold: pickedDate,
                    productId: widget.sale!.productId,
                  );
                  if (formKey.currentState!.validate()) {
                    // GetIt.I.get<SalesBloc>().add(UpdateSalesEvent(sale));
                  }
                },
              ),
              const SizedBox(
                width: 10,
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

  Container buildDate(DateTime initialDate) {
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4),
      decoration: BoxDecoration(
          border: Border.all(color: MThemeData.hintTextColor),
          borderRadius: BorderRadius.circular(6)),
      height: 50,
      width: 220,
      child: SelectDate(
        initialDate: initialDate,
        onDateSelected: (date) {
          _handleDatePicked(date);
        },
      ),
    );
  }

  TextFormField buildPrice(
      WidgetRef ref, TextEditingController textEditingController) {
    return TextFormField(
      controller: textEditingController,
      onChanged: (value) {},
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
      decoration: InputDecoration(
        labelText: 'Price'.tr(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: '1234 \$',
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.monetization_on_outlined),
        filled: false,
      ),
    );
  }

  Widget buildClientName(
    List<ShopClientModel> list,
  ) {
    return ClientAutocompleteField(
      // validator: (value) {
      //   return null;
      // },
      onChanged: (value) {
        setState(() {
          clientID = value.id!;
        });
      },
    );
  }
}
