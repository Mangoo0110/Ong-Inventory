import 'package:flutter/material.dart';
import 'package:ong_inventory/common/app_colors.dart';
import 'package:ong_inventory/common/app_text_styles.dart';
import 'package:ong_inventory/data_layer/inventory_storage.dart';
import 'package:ong_inventory/data_layer/product_model.dart';
import 'package:ong_inventory/presentation_layer/bottom_sheet.dart';
import 'package:ong_inventory/presentation_layer/product_details.dart';
import 'package:ong_inventory/presentation_layer/update_product.dart';
typedef ReloadCallBack = void Function();
class ProductList extends StatefulWidget {
  List<Product> products;
  ReloadCallBack onReload;
  ProductList({
    required this.onReload,
    required this.products,
    super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: (constraints.maxWidth/196.36).floor(),
            ),
          itemCount: widget.products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetailsView(
                    product: widget.products[index],
                    products: widget.products,
                  )));
                },
                onLongPress: () {
                  showModalBottomSheet(context: context, builder:(context)=>  OptionsBottomSheet(
                    onDelete: () async{
                      Navigator.of(context).pop();
                      await InventorySqlFlite().deleteProduct(widget.products[index].productName);
                      widget.onReload();
                    }, 
                    onUpdate: (){
                      Navigator.of(context).pop();
                      showModalBottomSheet(context: context, builder:(context)=>  UpdateProductView(
                        productX: widget.products[index],
                        products: widget.products,
                        onUpdate: () {
                          Navigator.of(context).pop();                                },
                      ));
                    }
                  ));
                },
                child: Container(
                  height: 140,
                  //width: constraints.maxWidth/2 - 15,
                  decoration: BoxDecoration(
                    color: AppColors().appActionColor(),
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(4,4),
                      ),
                      
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Text("Tk. ${widget.products[index].price}", style: AppTextStyle().boldGreenSmallSize(),)
                            ),
                            const SizedBox(height: 15,),
                            Text(widget.products[index].productName, style: AppTextStyle().normalSize(),)
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text("Tap and hold for options", style: AppTextStyle().extraSmallSize(),))
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  
  }
}