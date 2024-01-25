import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ong_inventory/common/app_colors.dart';
import 'package:ong_inventory/common/app_text_styles.dart';

typedef OptionDeleteCallBack = void Function();
typedef OptionUpdateCallBack = void Function();

class OptionsBottomSheet extends StatefulWidget {
  OptionDeleteCallBack onDelete;
  OptionUpdateCallBack onUpdate;
  OptionsBottomSheet({
    required this.onDelete,
    required this.onUpdate,
    super.key
    });

  @override
  State<OptionsBottomSheet> createState() => _OptionsBottomSheetState();
}

class _OptionsBottomSheetState extends State<OptionsBottomSheet> {
  //variables ::
  bool delete = false;
  //controllers:::
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      //backgroundColor: 
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: 160,
            color: Colors.black26,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 6,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8)
                  ),
                ),
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Text("Options", style: AppTextStyle().actionNormalSize(),),
                //   ),
                // ),
                // const Divider(thickness: .5,),
                SizedBox(
                  height: 50,
                  //color: Colors.black38,
                  child: InkWell(
                    onTap: () {
                      widget.onUpdate();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.edit, color: AppColors().appAccentColor(), size: 30,),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Text(
                                "Update",
                                style: AppTextStyle().boldActionNormalSize(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    
                    setState(() {
                      delete = !delete;
                    });
                    //widget.onDelete();
                  },
                  hoverColor: Colors.black,
                  splashColor: Colors.black,
                  
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      height: 50,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                  child: Icon(Icons.delete, color: AppColors().appAccentColor(), size: 30,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                                  child: Text(
                                    "Delete",
                                    style: AppTextStyle().boldActionNormalSize(),
                                  ),
                                ),
                              ],
                            ),
                            (!delete) ?
                            const Text("")
                            :
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors().appAccentColor())
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          delete = !delete;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors().appActionColor(),
                                          border: Border.all(color: AppColors().appAccentColor())
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 6),
                                          child: Icon(Icons.cancel_sharp, color: AppColors().appAccentColor(),)
                                        ),
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: InkWell(
                                      onTap: () {
                                        widget.onDelete();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors().appActionColor(),
                                          border: Border.all(color: AppColors().appAccentColor())
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 6),
                                          child: Icon(Icons.done, color: AppColors().appAccentColor(), weight: 10000,)
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
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      )
      );
  }
}