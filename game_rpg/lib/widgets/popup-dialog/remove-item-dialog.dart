// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:game_rpg/getx/item-controller.dart';
import 'package:game_rpg/model/item.dart';
import 'package:game_rpg/widgets/small-item-box.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class RemoveItemDialog extends StatefulWidget{
  const RemoveItemDialog({super.key});

  @override
  State<RemoveItemDialog> createState() => _RemoveItemDialogState();
}

class _RemoveItemDialogState extends State<RemoveItemDialog> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var newItem = ItemController.to.tempItemList.last;
    return Center(
      child: GlassContainer(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: glassWhiteBorder, width: 2),
        blur: 3,
        child: Padding(
          padding: EdgeInsets.all(Spacing.mediumSpacing),
          child: Column(
            children: [
              Text('Item yang akan diambil: ',
                style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontSize: smallText,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87
                  ),
              ),
              SmallItemBox(
                itemName: newItem.itemName, 
                itemImage: newItem.image, 
                itemID: newItem.id.toString(), 
                itemWeight: newItem.weight.toString(), 
                itemIndex: ItemController.to.tempItemList.length - 1
              ),
              const Divider(color: Colors.black),
              Expanded(
                child: SizedBox(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(height: Spacing.smallSpacing), 
                    itemCount: (ItemController.to.tempItemList.length - 1),
                    itemBuilder: (context, index) {
                      Item item = ItemController.to.tempItemList[index];
                      return SmallItemBox(
                        itemImage: item.image, 
                        itemName: item.itemName,
                        itemID: item.id.toString(), 
                        itemWeight: item.weight.toString(), 
                        itemIndex: index
                      );
                    }
                  ),
                )
              ),
              Center(
                child: Obx(() => ElevatedButton(
                  onPressed: () {
                    if(ItemController.to.currentBagWeight.value <= CharacterController.to.maxBagCapacity.value){
                      //update item list
                    }
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CharacterController.to.selectedItemID.value != '' && CharacterController.to.selectedItemID.value != '2' ? Colors.green.shade600 : Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: (ItemController.to.currentBagWeight.value <= CharacterController.to.maxBagCapacity.value) ? Colors.white : Colors.grey.shade700)
                    )
                  ),
                  child: Text('Konfirmasi',
                    style: TextStyle(
                      fontFamily: 'Scada',
                      fontSize: smallText,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                      color: (ItemController.to.currentBagWeight.value <= CharacterController.to.maxBagCapacity.value) ? Colors.black : Colors.white
                    )
                  ),
                )),
              ),
            ],
          )
        ),
      ),
    );
  }
}