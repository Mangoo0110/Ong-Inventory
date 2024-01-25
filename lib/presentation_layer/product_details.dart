import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ong_inventory/common/app_colors.dart';
import 'package:ong_inventory/common/app_text_styles.dart';
import 'package:ong_inventory/data_layer/product_model.dart';
import 'package:ong_inventory/presentation_layer/time_text.dart';
import 'package:ong_inventory/presentation_layer/update_product.dart';

class ProductDetailsView extends StatefulWidget {
  Product product;
  List<Product>products;
  ProductDetailsView({
    required this.products,
    required this.product,
    super.key
    });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  
  @override
  Widget build(BuildContext context) {
    int cnt =0;
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        //backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          backgroundColor: AppColors().appTextColorGrey(),
          title: Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Product Details",style: AppTextStyle().boldBigSize(),),
              )
            )
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 140,
                      width: min(200, constraints.maxWidth/2 ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green.shade200,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                               widget.product.productName,  style: AppTextStyle().boldActionNormalSize(),),
                            ),
                            const SizedBox(height: 7,),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Price : ${widget.product.price}", style: AppTextStyle().boldGreenNormalSize(),)),
                            const SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 6, 8),
                    child: Container(
                      height: 140,
                      width: min(200, constraints.maxWidth/2.4),
                      decoration: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text("Created at:", style: AppTextStyle().smallSize(),)
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: TimeText(date: widget.product.createdAt),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 12,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Price History : ", style: AppTextStyle().boldNormalSize(),),
                )),
              const SizedBox(height: 12,),
              Column(
                children: widget.product.priceHistory.entries.map(
                  (entry) {
                    cnt++;
                    var date = entry.key;
                    var price = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Container(
                        color: Colors.green.shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 200,
                                  child: TimeText(date: date)
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: 
                                (cnt == 1) ?
                                Text("${price.toString()} Tk **", style: AppTextStyle().boldGreenNormalSize(),maxLines: 3,)
                                :
                                Text("${price.toString()} Tk", style: AppTextStyle().boldGreenNormalSize(),maxLines: 3,),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  ).toList()
              )
            ],
          ),
        ), 
      ),
    );
  }
}