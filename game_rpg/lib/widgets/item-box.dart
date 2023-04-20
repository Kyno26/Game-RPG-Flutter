// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:get/get.dart';

class ItemBox extends StatefulWidget{
  final String itemIcon;
  final String itemName;
  final String itemDesc;
  final String itemQuantity;
  final String itemWeight;

  final String itemId;

  const ItemBox({super.key, required this.itemIcon, required this.itemName, required this.itemDesc, required this.itemQuantity, required this.itemId, required this.itemWeight});

  @override
  State<ItemBox> createState() => _ItemBoxState();
}

class _ItemBoxState extends State<ItemBox> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CharacterController.to.selectedItemID.value = widget.itemId;
      },
      child: Obx(() =>Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          border: Border.all(color: CharacterController.to.selectedItemID.value == widget.itemId ?Colors.green : Colors.white70, width: 1),
          color: CharacterController.to.selectedItemID.value == widget.itemId ? Colors.lightGreen.shade400 : Colors.black45,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Colors.white70))
              ),
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.15,
                      child: SvgPicture.asset('assets/images/item/${widget.itemIcon}.svg'),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white70))
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(widget.itemName,
                            style: const TextStyle(
                              fontFamily: 'Scada',
                              fontSize: smallText,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none,
                              color: Colors.white
                            )
                          ),
                          Text('Jumlah: ${widget.itemQuantity}',
                            style: const TextStyle(
                              fontFamily: 'Scada',
                              fontSize: smallerText,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                              color: Colors.white
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: Spacing.smallSpacing),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(widget.itemDesc,
                            style: const TextStyle(
                              fontFamily: 'Scada',
                              fontSize: smallerText,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.none,
                              color: Colors.white70
                            )
                          ),
                          Text('Berat: ${widget.itemWeight}',
                            style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                fontFamily: 'Scada',
                                fontSize: smallText,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),
                          ),
                        ],
                      )
                    )
                  )
                )
              ],
            ),
            Container(),Container(),
          ],
        ),
      ),
    ));
  }
}