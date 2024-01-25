import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ong_inventory/common/app_colors.dart';
import 'package:ong_inventory/common/app_text_styles.dart';
import 'package:ong_inventory/common/custom_textfield.dart';
import 'package:ong_inventory/common/price_textfield.dart';
import 'package:ong_inventory/data_layer/product_model.dart';
import 'package:ong_inventory/domain_layer/product_domain.dart';

typedef OnUpdateCallBack = void Function();
class UpdateProductView extends StatefulWidget {
  List<Product>products;
  Product productX;
  OnUpdateCallBack onUpdate;
  UpdateProductView({
    required this.productX,
    required this.products,
    required this.onUpdate,
    super.key
    });

  @override
  State<UpdateProductView> createState() => _UpdateProductViewState();
}

class _UpdateProductViewState extends State<UpdateProductView> {
  //controllers:::
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();

  //formKeys::
  final _formKey = GlobalKey<FormState>();
  final _productNameformKey = GlobalKey<FormState>();
  final _priceFormKey = GlobalKey<FormState>();

  //maps ::
  Set<String> existingProductSet = {};

  //variables ::
  double priceFieldHeight = 80, nameFieldHeight = 80, buttonHeight = 60, actionIndicationHeight = 60;
  double priceFieldPadding = 6, nameFieldPadding = 6, buttonOuterPadding = 6, buttonInnerPadding = 6, actionIndicationPadding = 8;
  
  //methods :::
  createExistingProductSet(){
    for(int index = 0; index < widget.products.length; index++) {
      existingProductSet.add(widget.products[index].productName);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _productNameController.text = widget.productX.productName;
    _productPriceController.text = widget.productX.price.toString();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _productNameController.dispose();
    _productPriceController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    createExistingProductSet();
    var totalHeight = 100 + priceFieldHeight + nameFieldHeight + buttonHeight + actionIndicationHeight +
                      priceFieldPadding + nameFieldPadding + buttonOuterPadding + buttonInnerPadding + actionIndicationPadding;
    return CupertinoPageScaffold(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            height: min(constraints.maxHeight, totalHeight),
            width: constraints.maxWidth,
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 6,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8)
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Update Product", style: AppTextStyle().boldNormalSize(),),
                      ),
                    ),
                    const Divider(thickness: .5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      child: Column(
                        children: [
                          SizedBox(
                            height: nameFieldHeight,
                            width: constraints.maxWidth,
                            child: Form(
                              key: _productNameformKey,
                              child: CustomTextfield(
                                onValidate: (text) {
                                  
                                  if(existingProductSet.contains(text) && text != widget.productX.productName){
                                    print(existingProductSet.contains(text));
                                    return "Already exist";
                                  }
                                  if(text.isEmpty) {
                                    return "This field can not be empty";
                                  }
                                  return null;
                                },
                                maxLines: 1, 
                                obscureText: false, 
                                onChanged: (value){
                                   _productNameformKey.currentState!.validate();
                                }, 
                                controller: _productNameController, 
                                hintText: "Product name", 
                                labelText: "Name"
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                            height: priceFieldHeight,
                            width: constraints.maxWidth,
                            child: Form(
                              key: _priceFormKey,
                              child: PriceTextfield(
                                maxLines: 1, 
                                obscureText: false, 
                                onChanged: (value){
                                  _priceFormKey.currentState!.validate();
                                }, 
                                controller: _productPriceController, 
                                hintText: "Product price", 
                                labelText: "Price"
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors().appActionColor(),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:  EdgeInsets.all(buttonOuterPadding),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: constraints.maxWidth/2 - 20,
                                      height: buttonHeight,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors().appTextColorGrey(),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(buttonInnerPadding),
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: AppTextStyle().boldNormalSize(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.all(buttonOuterPadding),
                                  child: InkWell(
                                    onTap: () async{
                                      if(_priceFormKey.currentState!.validate() && _productNameformKey.currentState!.validate()) {
                                        await ProductDomain().updateProduct(
                                          productName: _productNameController.text.trim(), 
                                          price: double.parse(_productPriceController.text.trim()),
                                          productBefore: widget.productX,
                                        );
                                        widget.onUpdate();
                                      }
                                    },
                                    child: Container(
                                      width: min(250, constraints.maxWidth/2 - 20),
                                      height: buttonHeight,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: AppColors().appAccentColor(),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(buttonInnerPadding),
                                        child: Center(
                                          child: Text(
                                            "Update",
                                            style: AppTextStyle().boldActionNormalSize(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          );
        },
      )
      );
  }
}