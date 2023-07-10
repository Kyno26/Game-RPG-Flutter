// ignore_for_file: sized_box_for_whitespace

import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:game_rpg/component/ui-components/color.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';
import 'package:game_rpg/getx/battlefield-controller.dart';
import 'package:game_rpg/getx/shop-controller.dart';
import 'package:game_rpg/getx/profile-controller.dart';
import 'package:game_rpg/widgets/confirm-dialog/dialog-core.dart';
import 'package:game_rpg/widgets/glass-button.dart';
import 'package:game_rpg/widgets/small-icon-btn.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:lottie/lottie.dart';

class MainMenuScreen extends StatefulWidget{
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen>{
  bool continueGame = false;
  bool isLoading = false;

  late Image imageBG;
  String coin = '';

  final CarouselController _Imgcontroller = CarouselController();
  final CarouselController _Textcontroller = CarouselController();
  int pageIndex = 1;
  List<String> imgList = [
    'assets/images/tutorial/tutorial-2.jpg',
    'assets/images/tutorial/tutorial-4.jpg',
    'assets/images/tutorial/tutorial-1.jpg',
    'assets/images/tutorial/tutorial-3.jpg',
    'assets/images/tutorial/tutorial-5.jpg',
    'assets/images/tutorial/tutorial-6.jpg',
    'assets/images/tutorial/tutorial-7.jpg',
    'assets/images/tutorial/tutorial-8.jpg',
  ];

  List<String> tutorialTextList = [
    'Pada bagian atas kiri terdapat informasi terkait giliran siapa saat ini. Sedangkan pada bagian atas kanan terdapat sebuah informasi yang menampilkan level atau stage saat ini. \n Disamping informasi tentang stage saat ini terdapat pula tombol pause yang dapat digunakan untuk keluar dari pertempuran dan kembali ke menu utama (Pemain tidak dapat mengklik tombol ini selain pada saat giliran "waiting turn"). \n Dibawah tombol pause terdapat tombol log atau catatan riwayat tentang tindakan yang dipilih pemain, lawan beserta kerusakan yang diterima dari serangan yang diterima.',
    'Pada bagian tengah terlihat lawan yang saat ini sedang aktif. Dibawah gambar lawan terdapat informasi nama lawan beserta jumlah nyawa (HP) yang dimiliki lawan saat ini dan tombol "detail" untuk melihat status tentang lawan. Kalahkan lawan dengan membuat nyawa (HP) mereka menjadi 0 untuk lanjut ke level berikutnya.',
    'Pada bagian bawah, terdapat informasi terkait berapa nyawa (HP) yang dimiliki pemain tersisa. Jika HP pemain mencapai 0 maka permainan akan berakhir. \n Pada bagian bawah HP pemain terdapat tombol detail yang dapat diklik untuk melihat STATUS karakter beserta tampilan untuk MENINGKATKAN karakter pemain. \n Terdapat pula tombol "Mulai" yang dapat diklik untuk memulai giliran, saat diklik sebuah pertanyaan akan muncul.',
    'Saat tombol mulai diklik, akan muncul sebuah pertanyaan beserta 4 buah pilihan. Pilih opsi jawaban yang benar lalu tekan tombol "konfirmasi jawaban" untuk melihat hasilnya. \n Dibawah tombol "konfirmasi jawaban" terdapat informasi terkait waktu tersisa untuk menjawab pertanyaan. Apabila waktu habis maka otomatis akan ditampilkan hasil dari jawaban yang dipilih pemain apakah benar atau tidak. \n Jika jawaban BENAR maka KESEMPATAN BERHASIL menyerang lawan akan meningkat, akan tetapi jika jawaban SALAH maka KESEMPATAN GAGAL akan meningkat. \n Setelah mengalahkan lawan maka akan muncul 3 pilihan item yang dapat dipilih untuk diambil.',
    'Setelah menjawab pertanyaan, maka pemain dapat melakukan beberapa aksi yang tersedia seperti "serang", "bertahan", dan "item". \n Tombol "serang" akan menyerang lawan, tingkatkan kemungkinan serangan berhasil dengan menjawab pertanyaan dengan benar. Tombol "bertahan" digunakan untuk meningkatkan pertahanan selama 2 ronde untuk mengurangi kerusakan yang diterima dari lawan. \n Tombol "item" akan menampilkan item yang dimiliki pemain saat ini. Pilih item yang akan digunakan lalu klik "gunakan" untuk menggunakan item. Item dapat didapatkan dengan cara mengalahkan lawan. \n Permainan ini menggunakan sistem Turn-Based Combat sehingga setelah giliran pemain maka selanjutnya akan giliran lawan.',
    'Saat tombol "detail" diklik maka akan tampilan tentang status pemain atau lawan sesuai dengan detail siapa yang ingin dilihat. Pada tampilan detail pemain, terdapat tombol dibawah untuk mengganti halaman status menjadi halaman tingkatkan status.',
    'Pada tampilan halaman status, akan muncul informasi berapa poin upgrade yang tersisa. Poin upgrade ini dapat digunakan untuk meningkatkan status pemain dengan cara mengklik tombol +, jika pemain ingin menarik kembali poin alokasi dapat dengan cara mengklik tombol -.',
    'Jika ingin menkonfirmasi alokasi poin, dan meningkatkan status karakter dapat dengan cara mengklik "Tingkatkan". Poin upgrade yang telah di alokasikan tidak dapat di tarik kembali setelah tombol ini di klik oleh karena itu tingkatkan dengan hati-hati.'
  ];

  startMainMenuSystem() async {
    setState(() {
      isLoading = true;
      continueGame = ProfileController.to.continueGameStatus.value;
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  startNewGame() async {
    if(continueGame){
      var newGame = false;
      newGame = await newGameDialog(context);
      return newGame;
    }
  }

  @override
  void initState() {
    imageBG = Image.asset('assets/images/background/back-up-bg.jpeg');
    startMainMenuSystem();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(imageBG.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var userExit = false;
        userExit = await exitDialoguePopup(context);
        return userExit;
      },
      child: Scaffold(
        body: SafeArea(
          child: mainContent(),
        )
      )
    );
  }

  Widget mainContent() {
    if(!isLoading){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: plainBlackBackground,
          image: DecorationImage(
            image: AssetImage('assets/images/background/back-up-bg.jpeg'),
            fit: BoxFit.fill
          )
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.pinkAccent,
                  child: Stack(
                    children: [
                      // Positioned(
                      //   left: 10,
                      //   top: 10,
                      //   child: GlassContainer(
                      //     width: MediaQuery.of(context).size.width * 0.3,
                      //     height: MediaQuery.of(context).size.width * 0.1,
                      //     blur: 3,
                      //     border: Border.all(color: glassWhiteBorder, width: 1),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Padding(
                      //           padding: EdgeInsets.only(left: Spacing.smallSpacing),
                      //           child: Container(
                      //             width: MediaQuery.of(context).size.width * 0.075,
                      //             height: MediaQuery.of(context).size.width * 0.075,
                      //             child: SvgPicture.asset('assets/icons/gold-coin-icon.svg', fit: BoxFit.fill,),
                      //           ),
                      //         ),
                      //         Container(
                      //           width: MediaQuery.of(context).size.width * 0.2,
                      //           child: Center(
                      //             child: Obx(() => Text(ShopController.to.formatCoins(),
                      //               overflow: TextOverflow.ellipsis,
                      //               style: Theme.of(context)
                      //                 .textTheme
                      //                 .headline6!
                      //                 .copyWith(
                      //                   fontFamily: 'Scada',
                      //                   fontSize: smallText,
                      //                   fontWeight: FontWeight.w600,
                      //                   color: Colors.white
                      //                 ),
                      //             ))
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   )
                      // ),
                      Column(
                        children: [
                          SizedBox(height: Spacing.largeSpacing * 3),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.width * 0.25,
                              // color: Colors.blueGrey,
                              child: Image.asset('assets/images/bios-logo-mainscreen.png'),
                            ),
                          ),
                        ],
                      ),
                      // Positioned(
                      //   right: 0,
                      //   child: Container(
                      //     width: MediaQuery.of(context).size.width * 0.2,
                      //     // color: Colors.yellow,
                      //     padding: EdgeInsets.all(Spacing.smallSpacing),
                      //     child: Column(
                      //       children: [
                      //         GestureDetector(
                      //           onTap: () {},
                      //           child: const IconBtnSmall(
                      //             title: 'Pengaturan', 
                      //             txtColor: Colors.white, 
                      //             iconFile: 'assets/icons/setting-icon.svg'
                      //           ),
                      //         ),
                      //         // SizedBox(height: Spacing.smallSpacing),
                      //         SizedBox(height: Spacing.smallSpacing),
                      //         GestureDetector(
                      //           onTap: () {},
                      //           child: const IconBtnSmall(
                      //             title: 'Cara Bermain', 
                      //             txtColor: Colors.white, 
                      //             iconFile: 'assets/icons/help-icon.svg'
                      //           ),
                      //         ),
                      //         SizedBox(height: Spacing.smallSpacing),
                      //         GestureDetector(
                      //           onTap: () {},
                      //           child: const IconBtnSmall(
                      //             title: 'Toko', 
                      //             txtColor: Colors.white, 
                      //             iconFile: 'assets/icons/shop-icon.svg'
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                const Spacer(),
                GlassButton(
                  title: 'Mulai Permainan Baru', 
                  subTitle: (continueGame) ? 'Permainan yang dimainkan sebelumnya akan hilang jika memulai permainan baru' : 'Mainkan permainan, jawab pertanyaan, dan kalahkan musuh', 
                  iconFile: 'sword-home-icon', 
                  onPress: () async {
                    debugPrint('New Game Pressed');
                    
                    // if(continueGame){
                    //   var newGame = false;
                    //   newGame = await newGameDialog(context);
                    //   if(newGame){
                    //     ProfileController.to.setContinueGameStatus(gameStatus: false);
                    //   }
                    // }else{
                      Navigator.pushNamed(context, 'characterSelectScreen');
                    // }
                  }, 
                  redSubtitle: continueGame,
                ),
                SizedBox(height: Spacing.mediumSpacing),
                if(ProfileController.to.continueGameStatus.value)
                  Obx(() =>GlassButton(
                    title: 'Lanjutkan Permainan', 
                    subTitle: 'Melanjutkan permainan dari titik terakhir dimainkan (stage: ${BattleFieldController.to.stageText.value})', 
                    iconFile: 'flag-icon', 
                    onPress: () {
                      Navigator.pushNamed(context, 'battlefield');
                      debugPrint('Continue Game Pressed');
                    }, 
                  )),
                if(ProfileController.to.continueGameStatus.value)
                  SizedBox(height: Spacing.mediumSpacing),
                GlassButton(
                  title: 'Pelajari Materi', 
                  subTitle: 'Pelajari tentang materi dan tentang apa yang akan muncul sebagai pertanyaan', 
                  iconFile: 'book-icon', 
                  onPress: () {
                    debugPrint('Learn Subject Pressed');
                    Navigator.pushNamed(context, 'lessonMainMenu');
                  }, 
                ),
                SizedBox(height: Spacing.mediumSpacing),
                GlassButton(
                  title: 'Cara Bermain', 
                  subTitle: 'Pelajari cara bermain untuk dapat mengalahkan musuh', 
                  iconFile: 'question-mark-icon', 
                  onPress: () {
                    debugPrint('How To Play Pressed');
                    showDialog(
                      context: context, 
                      barrierDismissible: false,
                      builder: (context) {
                        return howToPlayPopup(); 
                      }
                    );
                  }, 
                ),
                SizedBox(height: Spacing.mediumSpacing),
                GlassButton(
                  title: 'Keluar dari Permainan',
                  subtitleOn: false, 
                  subTitle: '', 
                  iconFile: 'exit-off-icon', 
                  onPress: () async {
                    debugPrint('Exit Pressed');

                    var userExit = false;
                    userExit = await exitDialoguePopup(context);
                    if(userExit){
                      SystemNavigator.pop();
                    }
                  }, 
                  btnColor: glassRedColor,
                  btnBorderColor: glassRedBorder,
                ),
                const Spacer(flex: 2),
              ],
            )
          ],
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: plainBlackBackground,
        child: Center(
          child: FadeIn(
            delay: const Duration(milliseconds: 500),
            duration: const Duration(seconds: 1),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              child: Lottie.asset('assets/images/lottie/load-animation.json', 
                fit: BoxFit.fill, 
                repeat: true
              ),
            ),
          )
        ),
      );
    }
  }

  Widget howToPlayPopup(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.transparent,
      child: Column(
        children: [
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.all(Spacing.mediumSpacing),
            decoration: BoxDecoration(
              color: Colors.brown.shade400,
              border: Border.all(color: Colors.black54, width: 2),
              borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black87, width: 1)
                  ),
                  child: CarouselSlider(
                    carouselController: _Imgcontroller,
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      height: MediaQuery.of(context).size.height * 0.55
                    ),
                    items: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Center(
                                child: Image.asset(imgList[0], fit: BoxFit.cover),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  child: Center(
                                    child: Text(tutorialTextList[0],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontFamily: 'Scada',
                                          fontWeight: FontWeight.w400,
                                          fontSize: smallText,
                                          color: Colors.black
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Center(
                                child: Image.asset(imgList[1], fit: BoxFit.cover),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  child: Center(
                                    child: Text(tutorialTextList[1],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontFamily: 'Scada',
                                          fontWeight: FontWeight.w400,
                                          fontSize: smallText,
                                          color: Colors.black
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Center(
                                child: Image.asset(imgList[2], fit: BoxFit.cover),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  child: Center(
                                    child: Text(tutorialTextList[2],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontFamily: 'Scada',
                                          fontWeight: FontWeight.w400,
                                          fontSize: smallText,
                                          color: Colors.black
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Center(
                                child: Image.asset(imgList[3], fit: BoxFit.cover),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  child: Center(
                                    child: Text(tutorialTextList[3],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontFamily: 'Scada',
                                          fontWeight: FontWeight.w400,
                                          fontSize: smallText,
                                          color: Colors.black
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Center(
                                child: Image.asset(imgList[4], fit: BoxFit.cover),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  child: Center(
                                    child: Text(tutorialTextList[4],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontFamily: 'Scada',
                                          fontWeight: FontWeight.w400,
                                          fontSize: smallText,
                                          color: Colors.black
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Center(
                                child: Image.asset(imgList[5], fit: BoxFit.cover),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  child: Center(
                                    child: Text(tutorialTextList[5],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontFamily: 'Scada',
                                          fontWeight: FontWeight.w400,
                                          fontSize: smallText,
                                          color: Colors.black
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Center(
                                child: Image.asset(imgList[6], fit: BoxFit.cover),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  child: Center(
                                    child: Text(tutorialTextList[6],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontFamily: 'Scada',
                                          fontWeight: FontWeight.w400,
                                          fontSize: smallText,
                                          color: Colors.black
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.65,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: Center(
                                child: Image.asset(imgList[7], fit: BoxFit.cover),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  child: Center(
                                    child: Text(tutorialTextList[7],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontFamily: 'Scada',
                                          fontWeight: FontWeight.w400,
                                          fontSize: smallText,
                                          color: Colors.black
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ] 
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Spacing.mediumSpacing),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: (){
                    _Imgcontroller.previousPage();
                    _Textcontroller.previousPage();
                    if(pageIndex != 1){
                      setState(() {
                        pageIndex--;
                      });
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.symmetric(vertical: Spacing.smallSpacing),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black87)
                    ),
                    child: Center(
                      child: Text('Sebelumnya',
                        style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontWeight: FontWeight.w400,
                            fontSize: smallText,
                            color: Colors.white
                          ),
                      ),
                    )
                  )
                ),
                GestureDetector(
                  onTap: (){
                    _Imgcontroller.nextPage();
                    _Textcontroller.nextPage();
                    if(pageIndex != 8){
                      setState(() {
                        pageIndex++;
                      });
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    padding: EdgeInsets.symmetric(vertical: Spacing.smallSpacing),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black87)
                    ),
                    child: Center(
                      child: Text('Selanjutnya',
                        style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(
                            fontFamily: 'Scada',
                            fontWeight: FontWeight.w400,
                            fontSize: smallText,
                            color: Colors.white
                          ),
                      ),
                    )
                  )
                ),
              ],
            )
          ),
          Padding(
            padding: EdgeInsets.only(top: Spacing.largeSpacing),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: redColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Spacing.smallSpacing),
                    child: Icon(Icons.close_rounded, color: Colors.white, size: MediaQuery.of(context).size.width * 0.1,),
                  ),
                ),
              )
            ),
          ),
          const Spacer(),
        ]
      )
    );
  }
}