// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:game_rpg/component/databaseSQLite/db-manager.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/getx/character-controller.dart';
import 'package:game_rpg/model/item.dart';
import 'package:get/get.dart';

class ItemController extends GetxController{
  static ItemController get to => Get.find<ItemController>();

  RxBool lifeNecklaceOn = false.obs;
  Item? itemGet;
  List<Item> itemShowUp = [];
  RxString itemToGet = ''.obs;
  RxInt itemToGetWeight = 0.obs;
  RxInt currentBagWeight = 0.obs;

  List<Item> tempItemList = [];
  List<int> deletedItem = [];

  generateItem() async {
    //item ID
    List normalRarity = [1, 4, 5, 10];
    List rareRarity = [2, 7, 8];
    List superRareRarity = [6, 9];

    int min = 1;
    int max = 10;
    int itemGenerated = 0;
    int itemID = 0;
    String itemRarity = '';

    /*Note:
      N rarity = 60%
      R rarity = 30%
      SR rarity = 10%
     */
    List chanceRate = ['Normal', 'Normal', 'Normal', 'Normal', 'Normal', 'Normal', 'Rare', 'Rare', 'Rare', 'Super Rare'];
    
    for(var i = 0; i < 3; i++){
      var rarityInt = Random().nextInt(max - min + 1) + min;
      itemRarity = chanceRate[rarityInt];
      
      switch (itemRarity) {
        case 'Normal':
          itemGenerated = Random().nextInt(normalRarity.length);
          itemID = normalRarity[itemGenerated];
          break;
        case 'Rare':
          itemGenerated = Random().nextInt(rareRarity.length);
          itemID = rareRarity[itemGenerated];
          break;
        case 'Super Rare':
          itemGenerated = Random().nextInt(superRareRarity.length);
          itemID = superRareRarity[itemGenerated];
          break;
        default:
          if(kDebugMode){
            debugPrint('Error: getting item rarity');
          }
      }

      itemGet = await DBManager.db.getItem(itemID: itemID);
      itemShowUp.add(itemGet!);
    }
  }

  addItem({required int itemID}) async {
    itemGet = await DBManager.db.getItem(itemID: itemID);
    if(CharacterController.to.itemList.isEmpty){
      CharacterController.to.itemList.add(itemGet!);
    }else{
      int count = 1;
      for(var i = 0; i < CharacterController.to.itemList.length; i++){
        var element = CharacterController.to.itemList[i];
        if(element.id == itemID){
          element.quantity++;
        }else{
          count++;
        }
        currentBagWeight.value = currentBagWeight.value + element.weight; 
      }

      if(count == CharacterController.to.itemList.length){
        CharacterController.to.itemList.add(itemGet!);
      } 
    }
    itemShowUp.clear();
  }

  useItem({required String itemID}) {
    switch (itemID) {
      case '1':
        //GREEN HERB HEAL 20 HP
        CharacterController.to.playerHealth.value = CharacterController.to.playerHealth.value + 20;
        if(CharacterController.to.playerHealth.value > CharacterController.to.playerMaxHealth.value){
          CharacterController.to.playerHealth.value = CharacterController.to.playerMaxHealth.value;
        }
        removeItemFromItemList(itemID: int.parse(itemID));
        BattleFieldController.to.addBattleLog(message: '${CharacterController.to.playerName.value} menggunakan item Green Herb.', type: 'USE ITEM');
        break;
      case '5':
        //WHETSTONE ADD ATK BUFF 5R
        BattleFieldController.to.addBuff(buff: 'Attack Up', receiver: 'player');
        removeItemFromItemList(itemID: int.parse(itemID));
        BattleFieldController.to.addBattleLog(message: '${CharacterController.to.playerName.value} menggunakan item Whetstone.', type: 'USE ITEM');
        break;
      case '6':
        //ELIXIR FULL HEAL
        CharacterController.to.playerHealth.value = CharacterController.to.playerMaxHealth.value;
        
        removeItemFromItemList(itemID: int.parse(itemID));
        BattleFieldController.to.addBattleLog(message: '${CharacterController.to.playerName.value} menggunakan item Elixir.', type: 'USE ITEM');
        break;
      case '7':
        //FIRST AID SPRAY HEAL 75 HP
        CharacterController.to.playerHealth.value = CharacterController.to.playerHealth.value + 75;
        if(CharacterController.to.playerHealth.value > CharacterController.to.playerMaxHealth.value){
          CharacterController.to.playerHealth.value = CharacterController.to.playerMaxHealth.value;
        }
        removeItemFromItemList(itemID: int.parse(itemID));
        BattleFieldController.to.addBattleLog(message: '${CharacterController.to.playerName.value} menggunakan item First Aid Spray.', type: 'USE ITEM');
        break;
      case '8':
        //VITAMIN PILS ADD DEF BUFF 5R
        BattleFieldController.to.addBuff(buff: 'Defense Up', receiver: 'player');
        removeItemFromItemList(itemID: int.parse(itemID));
        BattleFieldController.to.addBattleLog(message: '${CharacterController.to.playerName.value} menggunakan item Vitamin Pils.', type: 'USE ITEM');
        break;
      case '10':
        //ENERGY DRINK ADD SPD BUFF 5R
        BattleFieldController.to.addBuff(buff: 'Speed Up', receiver: 'player');
        removeItemFromItemList(itemID: int.parse(itemID));
        BattleFieldController.to.addBattleLog(message: '${CharacterController.to.playerName.value} menggunakan item Energy Drink.', type: 'USE ITEM');
        break;
      case '14':
        //MIX HERB G+R HEAL 75 HP
        CharacterController.to.playerHealth.value = CharacterController.to.playerHealth.value + 75;
        if(CharacterController.to.playerHealth.value > CharacterController.to.playerMaxHealth.value){
          CharacterController.to.playerHealth.value = CharacterController.to.playerMaxHealth.value;
        }
        removeItemFromItemList(itemID: int.parse(itemID));
        BattleFieldController.to.addBattleLog(message: '${CharacterController.to.playerName.value} menggunakan item ramuan herb (G+R).', type: 'USE ITEM');
        break;
      case '16':
        //MED KIT ADD MAX HP 15
        CharacterController.to.playerMaxHealth.value = CharacterController.to.playerMaxHealth.value + 15;
        CharacterController.to.playerHealth.value = CharacterController.to.playerHealth.value + 15;
        if(CharacterController.to.playerHealth.value > CharacterController.to.playerMaxHealth.value){
          CharacterController.to.playerHealth.value = CharacterController.to.playerMaxHealth.value;
        }
        removeItemFromItemList(itemID: int.parse(itemID));
        BattleFieldController.to.addBattleLog(message: '${CharacterController.to.playerName.value} menggunakan item Medkit.', type: 'USE ITEM');
        break;
      default:
        if(kDebugMode){
          debugPrint('Error: using item');
        }
    }
    CharacterController.to.selectedItemID.value = '';
  }

  removeItemFromItemList({required int itemID}) {
    for(var i = 0; i < CharacterController.to.itemList.length; i++){
      var element = CharacterController.to.itemList[i];
      if(element.id == itemID){
        if (element.quantity > 1) {
          element.quantity--;
        } else {
          CharacterController.to.itemList.removeWhere((element) => element.id == itemID);
        }
      }
    }
  }

  prepareItemToDelete({required Item item}){
    for(var i = 0; i < CharacterController.to.itemList.length; i++){
      var element = CharacterController.to.itemList[i];
      if (element.quantity != 1) {
        for (var i = 0; i < element.quantity; i++) {
          tempItemList.add(Item(
            id: element.id, 
            image: element.image, 
            itemName: element.itemName, 
            desc: element.desc, 
            quantity: 1, 
            weight: element.weight
          ));
        }
      } else {
        tempItemList.add(element);
      }
    }
    tempItemList.add(item);
  }

  confirmDeletedItem() {
    for (var i = 0; i < deletedItem.length; i++) {
      tempItemList.removeAt(deletedItem[i]);
    }
    for (var i = 0; i < tempItemList.length; i++) {
      var item = tempItemList[i];
      if(tempItemList.isEmpty){
        CharacterController.to.itemList.add(item);
      }else{
        var count = 1;
        for (var i = 0; i < CharacterController.to.itemList.length; i++) {
          var element = CharacterController.to.itemList[i];
          if(item.id == element.id){
            element.quantity++;
          }else{
            count++;
          }

          if(count == CharacterController.to.itemList.length){
            CharacterController.to.itemList.add(item);
          }
        }
      }
    }
  }

}