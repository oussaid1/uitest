import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:uitest/models/models.dart';

import 'glass_widgets.dart';

class ProductsAutocompleteField extends StatelessWidget {
  final Function(ProductModel) onChanged;
  const ProductsAutocompleteField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

//  static String _displayStringForOption(User option) => option.name;
  static String _displayStringForOption(ProductModel option) =>
      option.productName;
  @override
  Widget build(BuildContext context) {
    /// TODO: implement provide a list of products to autocomplete from ProductsBloc
    var list = ProductModel.fakeData;
    return Autocomplete<ProductModel>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<ProductModel>.empty();
        }
        return list.where((ProductModel option) {
          return option.productName
              .toLowerCase()
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          maxLength: 20,
          decoration: InputDecoration(
            counterText: '',
            labelText: 'Product'.tr(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: AppConstants.whiteOpacity),
            ),
            //border: InputBorder.none,
            hintText: 'find product'.tr(),
            hintStyle: Theme.of(context).textTheme.subtitle2!,
            filled: true,
          ),
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
        );
      },
      onSelected: onChanged,
    );
  }
}

class ClientAutocompleteField extends StatefulWidget {
  final Function(ShopClientModel) onChanged;
  //final String? Function(String?)? validator;
  const ClientAutocompleteField({
    Key? key,
    required this.onChanged,
    // required this.validator,
  }) : super(key: key);

//  static String _displayStringForOption(User option) => option.name;
  static String _displayStringForOption(ShopClientModel option) =>
      option.clientName!;

  @override
  State<ClientAutocompleteField> createState() =>
      _ClientAutocompleteFieldState();
}

class _ClientAutocompleteFieldState extends State<ClientAutocompleteField> {
  ShopClientModel? client;
  @override
  Widget build(BuildContext context) {
    /// TODO: implement provide a list of products to autocomplete from ProductsBloc
    var list = ShopClientModel.fakeClients;
    list = [ShopClientModel.client, ...list];

    return Autocomplete<ShopClientModel>(
      displayStringForOption: ClientAutocompleteField._displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const [];
        }
        return list.where((ShopClientModel option) {
          return option.clientName!
              .toLowerCase()
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          onChanged: (value) {
            setState(() {
              client = null;
            });
            // print(value);
          },
          controller: textEditingController,
          maxLength: 20,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person_outline_outlined),
            counterText: '',
            labelText: 'Client'.tr(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: AppConstants.whiteOpacity),
            ),
            //border: InputBorder.none,
            hintText: 'find client'.tr(),
            hintStyle: Theme.of(context).textTheme.subtitle2!,
            filled: true,
          ),
          focusNode: focusNode,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) {
            if (client == null) {
              return 'Client is required'.tr();
            }
            return null;
          },
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
        );
      },
      onSelected: (option) {
        setState(() {
          client = option;
        });
        widget.onChanged(option);
      },
    );
  }
}

class SuplierAutocompleteField extends StatelessWidget {
  final Function(SuplierModel) onChanged;
  const SuplierAutocompleteField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

//  static String _displayStringForOption(User option) => option.name;
  static String _displayStringForOption(SuplierModel option) => option.name!;
  @override
  Widget build(BuildContext context) {
    /// TODO: implement provide a list of products to autocomplete from ProductsBloc
    var list = SuplierModel.fakeData;
    return Autocomplete<SuplierModel>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<SuplierModel>.empty();
        }
        return list.where((SuplierModel option) {
          return option.name!
              .toLowerCase()
              .toString()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          maxLength: 20,
          decoration: InputDecoration(
            counterText: '',
            labelText: 'Suplier'.tr(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: AppConstants.whiteOpacity),
            ),
            //border: InputBorder.none,
            hintText: 'find suplier'.tr(),
            hintStyle: Theme.of(context).textTheme.subtitle2!,
            filled: true,
          ),
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
        );
      },
      onSelected: onChanged,
    );
  }
}

class CategoryAutocompleteField extends StatelessWidget {
  final Function(String) onChanged;
  const CategoryAutocompleteField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

//  static String _displayStringForOption(User option) => option.name;
  static String _displayStringForOption(String option) => option;
  @override
  Widget build(BuildContext context) {
    /// TODO: implement provide a list of products to autocomplete from ProductsBloc
    var list = ['A', 'B', 'C'];
    return Autocomplete<String>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return list.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          maxLength: 20,
          decoration: InputDecoration(
            counterText: '',
            labelText: 'Category'.tr(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: AppConstants.whiteOpacity),
            ),
            //border: InputBorder.none,
            hintText: 'find category'.tr(),
            hintStyle: Theme.of(context).textTheme.subtitle2!,
            filled: true,
          ),
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
        );
      },
      onSelected: onChanged,
    );
  }
}
