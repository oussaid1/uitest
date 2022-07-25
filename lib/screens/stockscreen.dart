// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../models/product/product.dart';
// import '../popups.dart';

// class ProductList extends ConsumerWidget {
//   const ProductList({
//     Key? key,
//     this.product,
//   }) : super(key: key);
//   final List<ProductModel>? product;

//   @override
//   Widget build(BuildContext context, ref) {
//     return Scaffold(
//         backgroundColor: Colors.transparent,
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.only(bottom: 80.0),
//           child: FloatingActionButton.extended(
//             icon: const Icon(Icons.add),
//             onPressed: () {
//               MDialogs.dialogSimple(
//                 context,
//                 title: Text(
//                   "Add Product",
//                   style: Theme.of(context).textTheme.headline3!,
//                 ),
//                 contentWidget: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   //  gradient: MThemeData.gradient2),
//                   height: 500,
//                   width: 420,
//                   child: const AddOrEditProduct(),
//                 ),
//               );
//             },
//             label: const Text("Add Product").tr(),
//           ),
//         ),
//         body: MultiBlocListener(
//           listeners: [
//             BlocListener<ProductBloc, ProductState>(
//               listener: (context, state) {
//                 if (state.status == ProductStatus.error) {
//                   GlobalFunctions.showSuccessSnackBar(
//                       context, 'Product added successfully'.tr());
//                 }
//                 if (state.status == ProductStatus.error) {
//                   GlobalFunctions.showErrorSnackBar(
//                       context, 'Error adding product'.tr());
//                 }

//                 if (state.status == ProductStatus.updated) {
//                   GlobalFunctions.showSuccessSnackBar(
//                       context, 'Product updated successfully'.tr());
//                 }

//                 if (state.status == ProductStatus.deleted) {
//                   GlobalFunctions.showSuccessSnackBar(
//                       context, 'Product deleted successfully'.tr());
//                 }
//               },
//             ),
//             BlocListener<SellActionsBloc, SellActionsState>(
//               listener: (context, state) {
//                 if (state is SellingSuccessfulState) {
//                   GlobalFunctions.showSuccessSnackBar(
//                       context, 'Successfully Sold '.tr());
//                 }

//                 if (state is SellingFailedState) {
//                   GlobalFunctions.showErrorSnackBar(
//                       context, 'Error selling product'.tr());
//                 }
//               },
//             ),
//           ],
//           child: BlocBuilder<ProductBloc, ProductState>(
//             builder: (context, state) {
//               if (state.status == ProductStatus.loaded) {
//                 //log('loaded ${state.products.length}');
//                 var productList = state.products;
//                 FilteredProduct filteredProduct =
//                     FilteredProduct(products: productList);
//                 ProductStockData productStockData =
//                     ProductStockData(products: filteredProduct.products);

//                 return Builder(builder: (context) {
//                   return SingleChildScrollView(
//                     child: SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height,
//                       child: Column(
//                         children: [
//                           GlassContainer(
//                             child: Wrap(
//                               spacing: 20,
//                               children: [
//                                 const MyInventoryWidgetNoBlurr(),
//                                 BluredContainer(
//                                   width: 420,
//                                   height: 320,
//                                   child: PieChartCard(
//                                     // title: 'Products in stock',
//                                     data: productStockData
//                                         .productCategorySumCounts,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           const Expanded(
//                             child: ProductsDataTable(),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 });
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//         ));
//   }
// }

// class ProductsDataTable extends StatefulWidget {
//   //final List<ProductModel> products;
//   const ProductsDataTable({
//     Key? key,
//     //required this.products,
//   }) : super(key: key);

//   @override
//   State<ProductsDataTable> createState() => _ProductsDataTableState();
// }

// class _ProductsDataTableState extends State<ProductsDataTable> {
//   ProductTableDataSource? _data;

//   int _sortColumnIndex = 0;
//   bool _sortAscending = true;

//   void sort<T>(Comparable<T> Function(ProductModel d) getField, int columnIndex,
//       bool ascending) {
//     _data!.sort<T>(getField, ascending);
//     setState(() {
//       _sortColumnIndex = columnIndex;
//       _sortAscending = ascending;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductBloc, ProductState>(
//       builder: (context, state) {
//         _data = ProductTableDataSource(
//           context,
//           state.products,
//           onSellPressed: (ProductModel product) => sellProduct(
//               context, product, context.read<SalesBloc>().state.sales),
//           onEditPressed: (ProductModel product) =>
//               editProduct(context, product),
//           onDeletePressed: (ProductModel product) =>
//               deleteProduct(context, product),
//         );
//         return SingleChildScrollView(
//           child: Column(
//             children: [
//               Text('* tap to sell',
//                   style: Theme.of(context).textTheme.subtitle2),
//               SearchByWidget(
//                 listOfCategories: ProductModel.fieldStrings,
//                 withCategory: true,
//                 onSearchTextChanged: (String text) {},
//                 onChanged: (String category) {},
//                 onBothChanged: (String category, String text) {
//                   _data!.filterByCategory(category, text);
//                 },
//               ),
//               PaginatedDataTable(
//                 sortColumnIndex: _sortColumnIndex,
//                 sortAscending: _sortAscending,
//                 showCheckboxColumn: false,
//                 columnSpacing: 10,
//                 checkboxHorizontalMargin: 0,
//                 horizontalMargin: 4,
//                 rowsPerPage: 10,
//                 columns: [
//                   const DataColumn(
//                     label: Text('ID'),
//                     tooltip: 'ID',
//                   ),
//                   const DataColumn(
//                     label: Text('Sell'),
//                     tooltip: 'Sell',
//                   ),
//                   // DataColumn(
//                   //   label: Text('Barcode'),
//                   //   tooltip: 'Barcode',
//                   // ),
//                   DataColumn(
//                       label: const Text('Product Name'),
//                       tooltip: 'Product Name',
//                       onSort: (int columnIndex, bool ascending) {
//                         sort<String>((ProductModel d) => d.productName,
//                             columnIndex, ascending);
//                       }),
//                   const DataColumn(
//                     label: Text('Quantity'),
//                     tooltip: 'Quantity',
//                   ),
//                   const DataColumn(
//                     label: Text('Price In'),
//                     tooltip: 'Price In',
//                   ),
//                   const DataColumn(
//                     label: Text('Price Out'),
//                     tooltip: 'Price Out',
//                   ),
//                   const DataColumn(
//                     label: Text('Suplier'),
//                     tooltip: 'Suplier',
//                   ),
//                   const DataColumn(
//                     label: Text('Date In'),
//                     tooltip: 'Date In',
//                   ),
//                   const DataColumn(
//                     label: Text('Category'),
//                     tooltip: 'Category',
//                   ),
//                   const DataColumn(
//                     label: Text('Description'),
//                     tooltip: 'Description',
//                   ),
//                   const DataColumn(
//                     label: Text('Edit'),
//                     tooltip: 'Edit',
//                   ),
//                   const DataColumn(
//                     label: Text('Delete'),
//                     tooltip: 'Delete',
//                   ),
//                 ],
//                 source: _data!,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   /// /////////////////////////////////////////////////////////////////////////////
//   /// sell product dialog
//   void sellProduct(context, ProductModel product, List<SaleModel> sales) {
//     List<String> distinctSaleClients =
//         FilteredSales(sales: sales).distinctCilentNames;
//     MDialogs.dialogSimple(
//       context,
//       title: Text(
//         "Sell Product",
//         style: Theme.of(context).textTheme.headline3!,
//       ),
//       contentWidget: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(6),
//         ),
//         //  gradient: MThemeData.gradient2),
//         height: 500,
//         width: 420,
//         child: BlocProvider(
//           create: (context) => ShopClientBloc(
//               databaseOperations: GetIt.I.get<DatabaseOperations>()),
//           child: SellProductDialoge(
//             clientNames: distinctSaleClients,
//             product: product,
//           ),
//         ),
//       ),
//     );
//   }

//   /// /////////////////////////////////////////////////////////////////////////////
//   /// edit product dialog
//   void editProduct(context, ProductModel product) {
//     MDialogs.dialogSimple(
//       context,
//       title: Text(
//         "Edit product".tr(),
//         style: Theme.of(context).textTheme.headline3!,
//       ),
//       contentWidget: SizedBox(
//         height: 400,
//         width: 400,
//         child: AddOrEditProduct(
//           product: product,
//           initialDateTime: product.dateIn,
//           initialValue: product.quantity,
//         ),
//       ),
//     );
//   }

//   /// /////////////////////////////////////////////////////////////////////////////
//   /// delete product dialog
//   void deleteProduct(context, ProductModel product) {
//     MDialogs.dialogSimple(
//       context,
//       title: Text(
//         " ${product.productName}",
//         style: Theme.of(context).textTheme.headline3!,
//       ),
//       contentWidget: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           ElevatedButton(
//             style: MThemeData.raisedButtonStyleSave,
//             child: Text(
//               'Delete'.tr(),
//               style: Theme.of(context).textTheme.bodyText1!,
//             ),
//             onPressed: () {
//               BlocProvider.of<ProductBloc>(context)
//                   .add(DeleteProductEvent(product));
//               Navigator.pop(context);
//             },
//           ),
//           ElevatedButton(
//             style: MThemeData.raisedButtonStyleCancel,
//             child: Text(
//               'Cancel'.tr(),
//               style: Theme.of(context).textTheme.bodyText1!,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
