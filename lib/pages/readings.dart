import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:orthodox_app/globals.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

import 'package:google_fonts/google_fonts.dart';

class Readings extends StatefulWidget {
  const Readings({Key? key}) : super(key: key);

  @override
  _ReadingsState createState() => _ReadingsState();
}

class _ReadingsState extends State<Readings> {

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: Duration(milliseconds: 250),
      child: Stack(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: navColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(150)),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 115.0, 15.0, 70.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Readings",
                    style: GoogleFonts.getFont(
                      'Bentham',
                      textStyle: TextStyle(
                        color: textHighlightColor,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Expanded(
                    child: Scrollbar(
                      controller: scrollController,
                      isAlwaysShown: true,
                      child: FadingEdgeScrollView.fromScrollView(
                        gradientFractionOnStart: 0.1,
                        gradientFractionOnEnd: 0.1,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          controller: scrollController,
                          padding: const EdgeInsets.all(8),
                          itemCount: readings.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                              child: ReadingCard(readings[index], index),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReadingCard extends StatefulWidget {
  const ReadingCard(this.reading, this.index, {Key? key}) : super(key: key);

  final Reading reading;
  final int index;

  @override
  _ReadingCardState createState() => _ReadingCardState();
}

class _ReadingCardState extends State<ReadingCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: (){
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ReadingPage(widget.reading),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      },
      child: Container(
        height: 115.0,
        width: 230.0,
       color: Colors.transparent,
       child: Card(
         elevation: 5.0,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(15.0),
         ),
         color: backgroundLightColor.withOpacity(0.95),
         child: Padding(
           padding: const EdgeInsets.all(15.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 widget.reading.title,
                 style: GoogleFonts.getFont(
                   'Bentham',
                   textStyle: TextStyle(
                     color: textHighlightColor,
                     fontSize: 25.0,
                     letterSpacing: 1.4,
                     fontWeight: FontWeight.bold,
                   ),
                 ),
                 overflow: TextOverflow.ellipsis,
               ),
               Container(
                 height: 2.0,
                 width: 200.0,
                 decoration: BoxDecoration(
                   color: selectedColor,
                   borderRadius: BorderRadius.circular(15),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                 child: Text(
                   widget.reading.subTitle=='' ? widget.reading.author : widget.reading.subTitle,
                   style: GoogleFonts.getFont(
                     'Roboto Slab',
                     textStyle: TextStyle(
                       color: textColor,
                       fontSize: 20.0,
                     ),
                   ),
                   overflow: TextOverflow.ellipsis,
                 ),
               ),
             ],
           ),
         ),
       ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReadingPage extends StatefulWidget {
  const ReadingPage(this.reading, {Key? key}) : super(key: key);
  final Reading reading;
  @override
  _ReadingPageState createState() => _ReadingPageState();
}

class _ReadingPageState extends State<ReadingPage> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Orthodox Life",
          style: GoogleFonts.getFont(
            'Bentham',
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.transparent,
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              // Where the linear gradient begins and ends
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              // Add one stop for each color. Stops should increase from 0 to 1
              colors: [
                // Colors are easy thanks to Flutter's Colors class.
                backgroundLightColor,
                backgroundDarkColor,
              ],
            ),
          ),
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(15.0),
                color: navColor,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.reading.title.trim(),
                      style: GoogleFonts.getFont(
                        'Bentham',
                        textStyle: TextStyle(
                          color: textColor,
                          fontSize: 45.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 15.0,
                    ),

                    Expanded(
                      flex: 1,
                      child: Scrollbar(
                        radius: Radius.circular(50.0),
                        controller: scrollController,
                        isAlwaysShown: true,
                        child: FadingEdgeScrollView.fromSingleChildScrollView(
                          gradientFractionOnEnd: 0.2,
                          gradientFractionOnStart: 0.2,
                          child: SingleChildScrollView(
                            controller: scrollController,
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.reading.subTitle != '' ? Text(
                                  widget.reading.subTitle.trim(),
                                  style: GoogleFonts.getFont(
                                    'Roboto Slab',
                                    textStyle: TextStyle(
                                      color: cardColor,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ), ) : Container(),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    child: Container(
                                      height: 2.0,
                                      color: accentColor,
                                    ),
                                  ),
                                  Text(
                                    widget.reading.author.trim(),
                                    style: GoogleFonts.getFont(
                                      'Roboto Slab',
                                      textStyle: TextStyle(
                                        color: cardColor,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    child: Container(
                                      height: 2.0,
                                      color: accentColor,
                                    ),
                                  ),
                                  Text(
                                    widget.reading.text.trim(),
                                    style: GoogleFonts.getFont(
                                      'PT Sans',
                                      textStyle: TextStyle(
                                        color: textHighlightColor,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ), // new
    );
  }
}


