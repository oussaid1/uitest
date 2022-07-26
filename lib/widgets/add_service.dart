import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uitest/extentions.dart';

import '../glass_widgets.dart';
import '../models/catrgory/category.dart';
import '../models/techservice/techservice.dart';
import '../theme.dart';

class AddService extends StatefulWidget {
  const AddService({Key? key, this.techService}) : super(key: key);
  final TechServiceModel? techService;
  @override
  AddServiceState createState() => AddServiceState();
}

class AddServiceState extends State<AddService> {
  final GlobalKey<FormState> mformKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceInController = TextEditingController();
  final TextEditingController priceOutController = TextEditingController();
  final TextEditingController descrController = TextEditingController();
  String serviceCat = 'Service';
  DateTime createdAt = DateTime.now();
  bool _isAvailable = true;
  String description = 'legal only';
  bool _canSave = false;
  bool _isUpdate = false;

  /// clear all text fields
  void clear() {
    titleController.clear();
    priceInController.clear();
    priceOutController.clear();
  }

  /// dispose all controllers
  void disposeControllers() {
    titleController.dispose();
    priceInController.dispose();
    priceOutController.dispose();
    descrController.dispose();
  }

  @override
  void initState() {
    if (widget.techService != null) {
      _isUpdate = true;
      titleController.text = widget.techService!.title.toString();
      serviceCat = widget.techService!.category.toString();
      createdAt = widget.techService!.createdAt;
      priceInController.text = widget.techService!.priceIn.toString();
      priceOutController.text = widget.techService!.priceOut.toString();
      description = widget.techService!.description.toString();
      _isAvailable = widget.techService!.available!;
    }
    super.initState();
  }

  @override
  void dispose() {
    clear();
    disposeControllers();
    _isUpdate = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 50),
        _buildFields(context, []),
      ],
    );
  }

  _buildFields(BuildContext context, List<String> techServiceList) {
    return Form(
      key: mformKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTechServiceName(),
            const SizedBox(height: 20),
            _buildPriceIn(),
            const SizedBox(height: 20),
            _buildPriceOut(),
            const SizedBox(height: 20),
            _buildCategory(context, []),
            const SizedBox(height: 20),
            _buildAvailability(context),
            const SizedBox(height: 20),
            _buildDescription(),
            const SizedBox(height: 40),
            _buildSaveButton(context),
            const SizedBox(
              height: 100,
            ) //but
          ],
        ),
      ),
    );
  }

  Row _buildSaveButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: MThemeData.raisedButtonStyleSave,
          onPressed: !_canSave
              ? null
              : () {
                  if (mformKey.currentState!.validate()) {
                    setState(() {
                      _canSave = false;
                    });
                    final techService = TechServiceModel(
                      seviceId: _isUpdate ? widget.techService!.seviceId : null,
                      description: descrController.text.trim(),
                      createdAt: DateTime.now(),
                      available: _isAvailable,
                      category: serviceCat,
                      title: titleController.text.trim(),
                      priceIn: double.tryParse(priceInController.text.trim())!,
                      priceOut:
                          double.tryParse(priceOutController.text.trim())!,
                      serviceDescription: description,
                    );
                    // GetIt.I<TechServiceBloc>().add(_isUpdate
                    //     ? UpdateTechServiceEvent(techService)
                    //     : AddTechServiceEvent(techService));
                    // Navigator.pop(context);
                  }
                },
          child: Text(_isUpdate ? 'Save' : 'Update').tr(),
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

  _buildCategory(BuildContext context, List<String> list) {
    return SizedBox(
      width: context.width,
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text == '') {
            return const Iterable<String>.empty();
          }
          return Category.categoriesStrings.where((String option) {
            return option
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
            onChanged: (text) {
              setState(() {
                serviceCat = text.trim();
              });
            },
            maxLength: 20,
            decoration: InputDecoration(
              counterText: '',
              labelText: 'Category'.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide(color: AppConstants.whiteOpacity),
              ),
              //border: InputBorder.none,
              hintText: 'category_hint'.tr(),
              hintStyle: Theme.of(context).textTheme.subtitle2!,
              filled: true,
              prefixIcon: Icon(
                Icons.category,
                color: AppConstants.whiteOpacity,
              ),
            ),
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            },
          );
        },
        onSelected: (String selection) {
          setState(() {
            serviceCat = selection;
          });
        },
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4),
      width: 240,
      child: TextFormField(
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
            borderSide: const BorderSide(),
          ),
          hintText: 'description_hint'.tr(),
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          filled: true,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  TextFormField _buildPriceOut() {
    return TextFormField(
        controller: priceOutController,
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(),
          ),
          hintText: '\$1434',
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          contentPadding: const EdgeInsets.only(top: 4),
          filled: true,
          labelText: 'Price-out'.tr(),
          prefixIcon: const Icon(Icons.monetization_on),
        ));
  }

  TextFormField _buildPriceIn() {
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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.0),
            borderSide: const BorderSide(),
          ),
          hintText: '1234 \$',
          hintStyle: Theme.of(context).textTheme.subtitle2!,
          contentPadding: const EdgeInsets.only(top: 4),
          filled: true,
          labelText: 'Price-in'.tr(),
          prefixIcon: const Icon(Icons.monetization_on_outlined),
        ));
  }

  TextFormField _buildTechServiceName() {
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
      maxLength: 20,
      decoration: InputDecoration(
        counterText: '',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide: const BorderSide(),
        ),
        hintText: 'name the service'.tr(),
        hintStyle: Theme.of(context).textTheme.subtitle2!,
        contentPadding: const EdgeInsets.only(top: 4),
        prefixIcon: const Icon(Icons.adb_sharp),
        filled: true,
        labelText: 'Service-Name'.tr(),
      ),
    );
  }

  _buildAvailability(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: 4, right: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: AppConstants.whiteOpacity,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              top: 8,
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, color: AppConstants.whiteOpacity),
                const SizedBox(width: 8),
                Text(
                  'Available'.tr(),
                ),
              ],
            ),
          ),
          Switch(
              activeColor: MThemeData.accentColor,
              value: _isAvailable,
              onChanged: (value) {
                setState(() {
                  _isAvailable = value;
                });
              }),
        ],
      ),
    );
  }
}
