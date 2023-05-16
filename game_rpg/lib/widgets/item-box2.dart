// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:game_rpg/getx/item-controller.dart';
import 'package:get/get.dart';

class ItemBox2 extends StatefulWidget{
  final String itemIcon;
  final String itemName;
  final String itemDesc;
  final String itemQuantity;
  final String itemWeight;
  final String itemIDRow;

  final String itemId;

  const ItemBox2({super.key, required this.itemIcon, required this.itemName, required this.itemDesc, required this.itemQuantity, required this.itemId, required this.itemIDRow, required this.itemWeight});

  @override
  State<ItemBox2> createState() => _ItemBox2State();
}

class _ItemBox2State extends State<ItemBox2> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CharacterController.to.selectedItemID.value = widget.itemId;
        ItemController.to.itemToGet.value = widget.itemIDRow;
      },
      child: Obx(() => Container(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          border: Border.all(color: ItemController.to.itemToGet.value == widget.itemIDRow ?Colors.green : Colors.white70, width: 2),
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: ItemController.to.itemToGet.value == widget.itemIDRow ?Colors.green : Colors.white70, width: 2))
              ),
              child: SvgPicture.asset('assets/images/item/${widget.itemIcon}.svg', fit: BoxFit.fill,),
            ),
            SizedBox(height: Spacing.smallSpacing),
            Center(
              child: Text(widget.itemName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Scada',
                  fontSize: smallText,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                  color: Colors.black
                )
              )
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: Spacing.smallSpacing),
                width: MediaQuery.of(context).size.width * 0.25,
                child: SingleChildScrollView(
                  child: Text(widget.itemDesc,
                    style: const TextStyle(
                      fontFamily: 'Scada',
                      fontSize: smallerText,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.none,
                      color: Colors.black54
                    )
                  )
                )
              )
            ),
            // Text('Berat: ${widget.itemWeight}',
            //   style: Theme.of(context)
            //     .textTheme
            //     .headline6!
            //     .copyWith(
            //       fontFamily: 'Scada',
            //       fontSize: smallText,
            //       fontWeight: FontWeight.w500,
            //       color: Colors.white
            //     ),
            // ),
          ],
        ),
      )),
    );
  }
}