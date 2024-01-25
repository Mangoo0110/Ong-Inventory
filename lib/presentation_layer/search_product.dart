import 'package:flutter/material.dart';
import 'package:ong_inventory/common/app_text_styles.dart';
import 'package:ong_inventory/common/search_textfield.dart';
import 'package:ong_inventory/data_layer/product_model.dart';
import 'package:ong_inventory/presentation_layer/product_list.dart';

class SearchProduct extends StatefulWidget {
  List<Product> products;
  ReloadCallBack onReload;
  SearchProduct({
    required this.onReload,
    required this.products,
    super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {

  // list variables ::
  List<Product> searchedProducts = [];

  // controllers ::
  TextEditingController _controller = TextEditingController();

  // methods ::

  getSearchedProducts({
    required String searchedText
  }) {
    searchedProducts = [];
    if(searchedText.isNotEmpty) {
      searchedText = searchedText.toLowerCase();
      for(int index = 0; index < widget.products.length; index ++) {
        String productName = (widget.products[index].productName).toLowerCase();
        if(productName.startsWith(searchedText)) {
          searchedProducts.add(widget.products[index]);
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("search");
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 70,
                width: constraints.maxWidth,
                child: SearchTextfield(
                  maxLines: 2, 
                  obscureText: false, 
                  onChanged: (text){
                    setState(() {
                      getSearchedProducts(searchedText: text);
                    });
                  }, 
                  controller: _controller, 
                  hintText: "Search by product name"
                )
              ),
            ),
            (_controller.text.isEmpty) ? 
            Text(" Type your product name in the search field", style: AppTextStyle().normalGreySize(),)
            :
            
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("${searchedProducts.length} results ", style: AppTextStyle().smallSize(),)),
                  ),
                  Expanded(child: ProductList(
                    products: searchedProducts,
                    onReload: () => widget.onReload(),
                    )),
                ],
              ),
            )
          ],
        )
      ),
    );
  
  }
}