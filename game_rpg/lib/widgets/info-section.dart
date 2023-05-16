// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:game_rpg/component/ui-components/spacing.dart';
import 'package:game_rpg/component/ui-components/text-size.dart';

class InfoSection extends StatefulWidget{
  const InfoSection({super.key, required this.content, required this.onPress, required this.boolVar});

  final String content;
  final Function() onPress;
  final bool boolVar;

  @override
  State<InfoSection> createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _infoSection();
  }

  Widget _infoSection(){
    if (widget.boolVar) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.all(Spacing.smallSpacing),
        decoration: BoxDecoration(
          color: Colors.yellow.shade100,
          border: const Border(
            left: BorderSide(color: Colors.black45, width: 2),
            right: BorderSide(color: Colors.black45, width: 2),
            bottom: BorderSide(color: Colors.black45, width: 2),
          )
        ),
        child:  Text(widget.content,
          textAlign: TextAlign.justify,
          style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(
              fontFamily: 'Scada',
              fontWeight: FontWeight.w500,
              fontSize: smallText,
              color: Colors.black87
            ),
          )
      );
    } else {
      return GestureDetector(
        onTap: widget.onPress,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(Spacing.smallSpacing),
          decoration: BoxDecoration(
            color: Colors.yellow.shade100,
            border: const Border(
              left: BorderSide(color: Colors.black45, width: 2),
              right: BorderSide(color: Colors.black45, width: 2),
              bottom: BorderSide(color: Colors.black45, width: 2),
            )
          ),
          child: Center(
            child: Text('Sentuh untuk melihat',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(
                  fontFamily: 'Scada',
                  fontWeight: FontWeight.w500,
                  fontSize: smallText,
                  color: Colors.black
                ),
            ),
          ),
        ),
      );
    }
  }
}