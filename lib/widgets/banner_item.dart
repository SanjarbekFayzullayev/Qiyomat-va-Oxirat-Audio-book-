import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:qiyomat_va_oxirat/moduls/book_muduls.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BannerItem extends StatefulWidget {
   Widget messeg;
   dynamic color;
   BoxDecoration boxDecoration;
   Widget widget;
   Widget? iconButton;
    BannerItem( this.messeg,this.widget,this.iconButton,this.boxDecoration,this.color,{Key? key}) : super(key: key);

  @override
  State<BannerItem> createState() => _BannerItemState();
}

class _BannerItemState extends State<BannerItem> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData=MediaQuery.of(context);
    var size=mediaQueryData.size;
    return Container(
      margin: const EdgeInsets.all(12),
      height:size.height*0.3,
      width: double.infinity,
      decoration: widget.boxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
               Padding(
                padding:  EdgeInsets.only(left: size.height*0.02,),
                child:widget.messeg,
              ),
             widget.widget,
            ],
          ),
          Expanded(
            child: Padding(
              padding: const  EdgeInsets.only(right: 8, left: 8),
              child:

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimSearchBar(
                    color: widget.color,
                    helpText: "search".tr(),
                    width: size.width*0.7,
                    textController: textEditingController,
                    onSuffixTap: () {
                      setState(() {
                        textEditingController.clear();
                      });
                    }, onSubmitted: (String ) {  },
                  ),
  widget.iconButton!
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
