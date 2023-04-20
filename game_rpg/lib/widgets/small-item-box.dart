// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/item-controller.dart';

class SmallItemBox extends StatefulWidget{
  const SmallItemBox({super.key, required this.itemName, required this.itemImage, required this.itemID, required this.itemWeight, required this.itemIndex});

  final String itemName;
  final String itemImage;
  final String itemID;
  final String itemWeight;
  final int itemIndex;

  @override
  State<SmallItemBox> createState()=> _SmallItemBoxState();
}

class _SmallItemBoxState extends State<SmallItemBox> {
  bool deleted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.1,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color: !deleted ? Colors.grey : Colors.grey.shade800
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.width * 0.1,
            decoration: const BoxDecoration(
              border: Border(right: BorderSide(color: Colors.black87))
            ),
            child: SvgPicture.asset('assets/images/item/${widget.itemImage}.svg'),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: [
                Text(widget.itemName,
                  style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(
                      fontFamily: 'Scada',
                      fontSize: smallText,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                    ),
                ),
                Text('Berat: ${widget.itemWeight}',
                  style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(
                      fontFamily: 'Scada',
                      fontSize: smallText,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54
                    ),
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: GestureDetector(
              onTap: (){
                if (!deleted) {
                  setState(() {
                    deleted = true;
                  });
                  ItemController.to.deletedItem.add(widget.itemIndex);
                  ItemController.to.currentBagWeight.value = ItemController.to.currentBagWeight.value - int.parse(widget.itemWeight);
                } else {
                  setState(() {
                    deleted = false;
                  });
                  ItemController.to.deletedItem.remove(widget.itemIndex);
                  ItemController.to.currentBagWeight.value = ItemController.to.currentBagWeight.value + int.parse(widget.itemWeight);
                }
              },
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: !deleted ? Colors.red.shade900 : Colors.blue.shade900),
                    borderRadius: BorderRadius.circular(5),
                    color: !deleted ? Colors.red : Colors.blue.shade300
                  ),
                  child: SvgPicture.asset(!deleted ? 'assets/icons/trash-icon.svg' : 'assets/icons/cancel-remove-icon.svg', color: Colors.white),
                )
              )
            ),
          )
          //item quantity + add & remove btn
        ],
      ),
    );
  }
}