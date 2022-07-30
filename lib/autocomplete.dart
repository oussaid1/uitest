import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uitest/models/models.dart';

import 'glass_widgets.dart';
import 'stats_widget.dart';

class ProductsAutocompleteField extends StatelessWidget {
  final Function(ProductModel) onChanged;
  final ProductModel? initialValue;
  const ProductsAutocompleteField({
    Key? key,
    required this.onChanged,
    this.initialValue,
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
      initialValue: TextEditingValue(text: initialValue?.productName ?? ''),
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ProductModel> onSelected,
          Iterable<ProductModel> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final ProductModel option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Builder(builder: (BuildContext context) {
                      final bool highlight =
                          AutocompleteHighlightedOption.of(context) == index;
                      if (highlight) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        });
                      }
                      return Container(
                        color: highlight ? Theme.of(context).focusColor : null,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          RawAutocomplete.defaultStringForOption(
                              option.productName),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        );
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
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////

class ClientAutocompleteField extends StatefulWidget {
  final Function(ShopClientModel) onChanged;
  //final String? Function(String?)? validator;
  final ShopClientModel? initialClient;
  const ClientAutocompleteField({
    Key? key,
    required this.onChanged,
    this.initialClient,
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
  void initState() {
    if (widget.initialClient != null) {
      client = widget.initialClient;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      initialValue: TextEditingValue(
        text: widget.initialClient?.clientName ?? '',
      ),
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<ShopClientModel> onSelected,
          Iterable<ShopClientModel> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final ShopClientModel option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Builder(builder: (BuildContext context) {
                      final bool highlight =
                          AutocompleteHighlightedOption.of(context) == index;
                      if (highlight) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        });
                      }
                      return Container(
                        color: highlight ? Theme.of(context).focusColor : null,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          RawAutocomplete.defaultStringForOption(
                              option.clientName),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        );
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

//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
class SuplierAutocompleteField extends StatelessWidget {
  final Function(SuplierModel) onChanged;
  final SuplierModel? initialSuplier;
  const SuplierAutocompleteField({
    Key? key,
    required this.onChanged,
    this.initialSuplier,
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
      initialValue: TextEditingValue(
        text: initialSuplier?.name ?? '',
      ),
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<SuplierModel> onSelected,
          Iterable<SuplierModel> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final SuplierModel option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Builder(builder: (BuildContext context) {
                      final bool highlight =
                          AutocompleteHighlightedOption.of(context) == index;
                      if (highlight) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        });
                      }
                      return Container(
                        color: highlight ? Theme.of(context).focusColor : null,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          RawAutocomplete.defaultStringForOption(option.name),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        );
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          maxLength: 20,
          decoration: InputDecoration(
            prefixIcon: const Icon(FontAwesomeIcons.peopleLine),
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
  final List<String>? categories;
  const CategoryAutocompleteField({
    Key? key,
    this.categories,
    required this.onChanged,
  }) : super(key: key);

//  static String _displayStringForOption(User option) => option.name;
  static String _displayStringForOption(String option) => option;
  @override
  Widget build(BuildContext context) {
    /// TODO: implement provide a list of products to autocomplete from ProductsBloc
    var list = categories ?? ['Phone', 'Accessoir', 'Laptop', 'Tablet'];
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
            prefixIcon: const Icon(FontAwesomeIcons.tag),
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

// class ExpenseCategoryAutocompleteField extends StatelessWidget {
//   final Function(String) onChanged;

//   const ExpenseCategoryAutocompleteField({
//     Key? key,
//     required this.onChanged,
//   }) : super(key: key);

// //  static String _displayStringForOption(User option) => option.name;
//   static String _displayStringForOption(String option) => option;
//   @override
//   Widget build(BuildContext context) {
//     /// TODO: implement provide a list of products to autocomplete from ProductsBloc
//     var list = ExpenseCategory.values.map((e) => e.toString()).toList();
//     return Autocomplete<String>(
//       displayStringForOption: _displayStringForOption,
//       optionsBuilder: (TextEditingValue textEditingValue) {
//         if (textEditingValue.text == '') {
//           return const Iterable<String>.empty();
//         }
//         return list.where((String option) {
//           return option
//               .toLowerCase()
//               .contains(textEditingValue.text.toLowerCase());
//         });
//       },
//       fieldViewBuilder: (BuildContext context,
//           TextEditingController textEditingController,
//           FocusNode focusNode,
//           VoidCallback onFieldSubmitted) {
//         return TextFormField(
//           controller: textEditingController,
//           maxLength: 20,
//           decoration: InputDecoration(
//             prefixIcon: const Icon(FontAwesomeIcons.tag),
//             counterText: '',
//             labelText: 'Category'.tr(),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(6.0),
//               borderSide: BorderSide(color: AppConstants.whiteOpacity),
//             ),
//             //border: InputBorder.none,
//             hintText: 'find category'.tr(),
//             hintStyle: Theme.of(context).textTheme.subtitle2!,
//             filled: true,
//           ),
//           focusNode: focusNode,
//           onFieldSubmitted: (String value) {
//             onFieldSubmitted();
//           },
//         );
//       },
//       onSelected: onChanged,
//     );
//   }
// }

class SalesByCategoryWidget extends StatefulWidget {
  final List<TaggedSales> taggedSales;

  const SalesByCategoryWidget({
    Key? key,
    required this.taggedSales,
  }) : super(key: key);

  @override
  State<SalesByCategoryWidget> createState() => _SalesByCategoryWidgetState();
}

class _SalesByCategoryWidgetState extends State<SalesByCategoryWidget> {
  TaggedSales? taggedSales1;
  @override
  void initState() {
    if (widget.taggedSales.isNotEmpty) {
      taggedSales1 = widget.taggedSales[0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitleSearch(context),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildAmountSold(context),
                const SizedBox(height: 8),
                buildItemsSold(context),
                const SizedBox(height: 8),
                buildQntity(context),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          buildProft(context),
        ],
      ),
    );
  }

  buildProft(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Profit',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          PriceNumberZone(
            price: taggedSales1?.salesData.totalNetProfit ?? 4350,
            priceStyle: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(color: Theme.of(context).colorScheme.primary),
            withDollarSign: true,
          ),
        ],
      ),
    );
  }

  buildQntity(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Qnt',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        PriceNumberZone(
          price: taggedSales1?.salesData.totalQuantitySold ?? 0434,
          priceStyle: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Theme.of(context).colorScheme.onSecondary),
          withDollarSign: true,
        ),
      ],
    );
  }

  buildItemsSold(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Items',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        PriceNumberZone(
          price: taggedSales1?.salesData.totalQuantitySold ?? 0,
          // style: Theme.of(context)
          //     .textTheme
          //     .headline5!
          //     .copyWith(
          //         color:
          //             Theme.of(context).colorScheme.onPrimary),
          withDollarSign: true,
        ),
      ],
    );
  }

  buildAmountSold(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Amount',
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        PriceNumberZone(
          price: taggedSales1?.salesData.totalSoldAmount ?? 0,
          // style: Theme.of(context)
          //     .textTheme
          //     .headline5!
          //     .copyWith(
          //         color:
          //             Theme.of(context).colorScheme.onPrimary),
          withDollarSign: true,
        ),
      ],
    );
  }

  buildTitleSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.search),
              const SizedBox(width: 8),
              Text(
                "Sales By Category",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          Autocomplete<TaggedSales>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<TaggedSales>.empty();
              }
              return widget.taggedSales.where((TaggedSales option) {
                return option.tag
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            initialValue: TextEditingValue(
              text: taggedSales1?.tag ?? '',
            ),
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<TaggedSales> onSelected,
                Iterable<TaggedSales> options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4.0,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxHeight: 200, maxWidth: 200),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: options.length,
                      itemBuilder: (BuildContext context, int index) {
                        final TaggedSales option = options.elementAt(index);
                        return InkWell(
                          onTap: () {
                            onSelected(option);
                          },
                          child: Builder(builder: (BuildContext context) {
                            final bool highlight =
                                AutocompleteHighlightedOption.of(context) ==
                                    index;
                            if (highlight) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((Duration timeStamp) {
                                Scrollable.ensureVisible(context,
                                    alignment: 0.5);
                              });
                            }
                            return Container(
                              color: highlight
                                  ? Theme.of(context).focusColor
                                  : null,
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                RawAutocomplete.defaultStringForOption(
                                    option.tag),
                              ),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            fieldViewBuilder: (BuildContext context,
                TextEditingController textEditingController,
                FocusNode focusNode,
                VoidCallback onFieldSubmitted) {
              return SizedBox(
                width: 140,
                height: 40,
                child: TextFormField(
                  controller: textEditingController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          width: 0.5, color: AppConstants.whiteOpacity),
                    ),
                    // labelText: 'Category',

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: AppConstants.whiteOpacity),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          width: 0.1, color: AppConstants.whiteOpacity),
                    ),
                    // border: InputBorder.none,
                    //hintText: 'category_hint',
                    hintStyle: Theme.of(context).textTheme.subtitle2!,
                    filled: true,
                  ),
                  focusNode: focusNode,
                ),
              );
            },
            onSelected: (TaggedSales selection) {
              setState(() {
                taggedSales1 = selection;
              });
              //log('Selected: $selection');
            },
          ),
        ],
      ),
    );
  }
}
