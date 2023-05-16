// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:game_rpg/model/item.dart';
import 'package:game_rpg/widgets/item-box.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class UseItemDialog extends StatefulWidget{
  const UseItemDialog({super.key});

  @override
  State<UseItemDialog> createState() => _UseItemDialogState();
}

class _UseItemDialogState extends State<UseItemDialog> {

  @override
  void initState() {
    print('Number of Item in Bag: ${CharacterController.to.itemList.length}');
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
              Expanded(
                child: SizedBox(
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(height: Spacing.smallSpacing), 
                    itemCount: CharacterController.to.itemList.length,
                    itemBuilder: (context, index) {
                      Item item = CharacterController.to.itemList[index];
                      return ItemBox(
                        itemIcon: item.image, 
                        itemName: item.itemName, 
                        itemDesc: item.desc, 
                        itemQuantity: item.quantity.toString(), 
                        itemId: item.id.toString(), 
                        itemWeight: item.weight.toString(), 
                      );
                    }
                  ),
                )
              ),
              Center(
                child: Obx(() => ElevatedButton(
                  onPressed: () {
                    if(CharacterController.to.selectedItemID.value != '' && CharacterController.to.selectedItemID.value != '9'){
                      CharacterController.to.playerPhase(actionSelected: 'Use Item');
                      Navigator.pop(context);
                    }
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CharacterController.to.selectedItemID.value != '' && CharacterController.to.selectedItemID.value != '2' ? Colors.green.shade600 : Colors.grey.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: CharacterController.to.selectedItemID.value != '' && CharacterController.to.selectedItemID.value != '2' ? Colors.white : Colors.grey.shade700)
                    )
                  ),
                  child: Text('Gunakan Item',
                    style: TextStyle(
                      fontFamily: 'Scada',
                      fontSize: smallText,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                      color: CharacterController.to.selectedItemID.value != '' && CharacterController.to.selectedItemID.value != '2' ? Colors.white : Colors.black54
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