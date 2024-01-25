import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ong_inventory/common/app_colors.dart';
import 'package:ong_inventory/common/app_text_styles.dart';
import 'package:ong_inventory/data_layer/product_model.dart';
import 'package:ong_inventory/domain_layer/product_domain.dart';
import 'package:ong_inventory/presentation_layer/create_product.dart';
import 'dart:developer' as devtools show log;

import 'package:ong_inventory/presentation_layer/product_list.dart';
import 'package:ong_inventory/presentation_layer/search_product.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  //variables ::
  List<Product>products = [];
  int currPageIndex = 0;

  //controllers::

  //methods :::
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>Scaffold(
        backgroundColor: AppColors().appBackgroundColor(),
        appBar: AppBar(
          backgroundColor: AppColors().appTextColorGrey(),
          title: Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors().appTextColorGrey(),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Ong's Inventory",style: AppTextStyle().boldBigSize(),),
              ))),
          actions: [
            InkWell(
              onTap: () {
                showModalBottomSheet(context: context, builder:(context)=>  CreateProductView(
                  products: products,
                  onUpdate: () {
                    Navigator.of(context).pop();
                  },
                ));
              },
              
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors().appAccentColor(),
                    borderRadius: BorderRadius.circular(7)
                  ),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 4
                          ),
                          child: Icon(Icons.add, color: AppColors().appActionColor(), size: 20,),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(2, 0, 8, 0),
                            child: Text("New", style: AppTextStyle().boldActionNormalSize(),),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          color: AppColors().appAccentColor(),
          onRefresh: () async{
            Future.delayed(const Duration(seconds: 5));
            setState(() {
              
            });
          },
          child: FutureBuilder(
            future: ProductDomain().getAllProducts(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator());
              }
              if(snapshot.hasError) {
                devtools.log(snapshot.error.toString());
                return Center(
                  child: Text(
                    "Internal error", 
                    style: AppTextStyle().boldSmallSizeGrey(),
                  )
                );
              }
              else if(snapshot.hasData) {
                products = snapshot.data as List<Product>;
                if(products.isEmpty) {
                  return Center(
                  child: SizedBox(
                    width: 240,
                    child: Text(
                      "You have 0 products. Tap on 'New' button to create a new product", 
                      style: AppTextStyle().boldGreyBigSize(),
                    ),
                  )
                );
                }
                return [
                  ProductList(
                    products: products, 
                    onReload: () {
                    setState(() {
                      
                    });
                  },), 
                  SearchProduct(
                    products: products,
                    onReload: () {
                      setState(() {
                        
                      });
                  },)
                  ][currPageIndex];
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 30,
            horizontal: (constraints.maxWidth - 280)/2
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white30,
              
            ),
            child: NavigationBar(
              animationDuration: const Duration(milliseconds: 1000),
              selectedIndex: currPageIndex,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              indicatorColor: AppColors().appAccentColor(),
              destinations:  [
                 NavigationDestination(
                  icon:  Icon(Icons.done_all, size: 30, color: AppColors().appTextColor(),),
                  label: "All",
                  selectedIcon: Icon(Icons.done_all, size: 30, color: AppColors().appActionColor(),),
                ),
                NavigationDestination(
                  icon: Icon(Icons.search, size:  30, color: AppColors().appTextColor(),),
                  label: "Search",
                  selectedIcon: Icon(Icons.search, size:  30, color: AppColors().appActionColor(),),
                ),
              ],
              onDestinationSelected: (value) {
                setState(() {
                  currPageIndex = value;
                });
              },
            ),
          ),
        )
      ),
    );
  
  }
}