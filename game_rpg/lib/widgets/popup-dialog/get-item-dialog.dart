// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:game_rpg/getx/item-controller.dart';
import 'package:game_rpg/model/item.dart';
import 'package:game_rpg/widgets/item-box2.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class GetItemDialog extends StatefulWidget{
  const GetItemDialog({super.key});

  @override
  State<GetItemDialog> createState() => _GetItemDialogState();
}

class _GetItemDialogState extends State<GetItemDialog> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.7,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => SizedBox(width: Spacing.smallSpacing), 
                  itemCount: BattleFieldController.to.itemShowUp.length,
                  itemBuilder: (context, index) {
                    Item item = BattleFieldController.to.itemShowUp[index];
                    return ItemBox2(
                      itemIcon: item.image, 
                      itemName: item.itemName, 
                      itemDesc: item.desc, 
                      itemQuantity: item.quantity.toString(), 
                      itemId: item.id.toString(), 
                      itemIDRow: index.toString(), 
                      itemWeight: item.weight.toString(), 
                    );
                  }
                ),
              ),
              Center(
                child: Obx(() => ElevatedButton(
                  onPressed: () {
                    if(CharacterController.to.selectedItemID.value != ''){
                      if((ItemController.to.currentBagCapacity.value + ItemController.to.itemToGetWeight.value) > CharacterController.to.maxBagCapacity.value){
                        //code
                      }else{
                        ItemController.to.addItem(itemID: int.parse(CharacterController.to.selectedItemID.value));
                        Navigator.pop(context);
                        ItemController.to.generateItem();
                      }
                    }
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CharacterController.to.selectedItemID.value != '' && CharacterController.to.selectedItemID.value != '2' 
                      ? Colors.green.shade600 : Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: CharacterController.to.selectedItemID.value != '' && CharacterController.to.selectedItemID.value != '2' 
                        ? Colors.white : Colors.grey.shade700)
                    )
                  ),
                  child: Text('Ambil Item',
                    style: TextStyle(
                      fontFamily: 'Scada',
                      fontSize: smallText,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                      color: CharacterController.to.selectedItemID.value != '' && CharacterController.to.selectedItemID.value != '2' 
                        ? Colors.white : Colors.black54
                    )
                  ),
                )),
              ),
              SizedBox(height: Spacing.mediumSpacing),
              const Divider(thickness: 2, color: Colors.white),
              SizedBox(height: Spacing.mediumSpacing),
              Text('Kapasitas Tas: ${ItemController.to.currentBagCapacity} / ${CharacterController.to.maxBagCapacity}',
                style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(
                    fontFamily: 'Scada',
                    fontSize: smallText,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70
                  ),
              )
            ],
          )
        ),
      ),
    );
  }
}