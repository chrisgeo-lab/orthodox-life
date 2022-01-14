import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:orthodox_app/globals.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  WebScraper webScraper = WebScraper('https://www.goarch.org');
  bool loaded = false;

  final ScrollController screenScrollController = ScrollController();
  final ScrollController textScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (needData()) {
      _getData();
    }
    else {
      loaded = true;
    }
  }

  _getData() async {
    if (await webScraper.loadWebPage('/chapel')) {
      List<Map<String, dynamic>> getDate = webScraper.getElement(
          'div.commemorate-header > h3', ['title']);
      List<Map<String, dynamic>> getFasting = webScraper.getElement(
          'div.oc-fasting p', ['title']);
      List<Map<String, dynamic>> getIcon = webScraper.getElement(
          'div.commemorate-left > div.img-wrapper > img', ['src']);
      List<Map<String, dynamic>> getSaints = webScraper.getElement(
          'ul.oc-saints > li', ['title']);
      List<Map<String, dynamic>> getReadings = webScraper.getElement(
          'ul.oc-readings > li > a', ['href']);
      setState(() {
        now = DateTime.now();
        date = getDate[0]['title'];
        fasting = getFasting[0]['title'];
        iconAddr = getIcon[0]['attributes']['src'];
        for (Map<String, dynamic> mapped in getSaints) {
          String temp = mapped['title'].trimRight();
          saints.add(temp.trimLeft());
        }
        saintText = "";
        for (var saint in saints) {
          saintText = saintText + "- " + saint + '\n';
        }
        epistleAddr = getReadings[0]['attributes']['href'];
        gospelAddr = getReadings[1]['attributes']['href'];
        print(saints);
      });
      if (await webScraper.loadWebPage(
          epistleAddr.replaceAll(r'http://www.goarch.org', ''))) {
        List<Map<String, dynamic>> getSubtitle = webScraper.getElement(
            'section.readings-wrapper > h3', ['title']);
        List<Map<String, dynamic>> getSource = webScraper.getElement(
            'section.readings-wrapper > h1', ['title']);
        List<Map<String, dynamic>> getText = webScraper.getElement(
            'div.details', ['title']);
        setState(() {
          epistle.author = getSource[0]['title'];
          epistle.subTitle = getSubtitle[0]['title'];
          epistle.text = getText[0]['title'];
        });
      }
      if (await webScraper.loadWebPage(
          gospelAddr.replaceAll(r'http://www.goarch.org', ''))) {
        List<Map<String, dynamic>> getSubtitle = webScraper.getElement(
            'section.readings-wrapper > h3', ['title']);
        List<Map<String, dynamic>> getSource = webScraper.getElement(
            'section.readings-wrapper > h1', ['title']);
        List<Map<String, dynamic>> getText = webScraper.getElement(
            'div.details', ['title']);
        setState(() {
          gospel.author = getSource[0]['title'];
          gospel.subTitle = getSubtitle[0]['title'];
          gospel.text = getText[0]['title'];
        });
      }
      Future.delayed(
          Duration(milliseconds: 1000),
              () {
            setState(() {
              loaded = true;
            });
          }
      );
    }
    // if(await webScraper.loadWebPage('/chapel/search?month=' + now.month.toString() + '&day=' + now.day.toString())){
    //   List<Map<String, dynamic>> getSaints = webScraper.getElement('li.ss-result-element', ['title']);
    //   print(getSaints);
    //   setState(() {
    //     for (Map<String, dynamic> mapped in getSaints){
    //       saints.add(mapped['title']);
    //     }
    //     print(saints);
    //   });
    // }
  }


  Widget display() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(iconAddr),
            ),
          ),
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.black.withOpacity(0.7)),
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 100.0,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      date,
                      style: GoogleFonts.getFont(
                        'Bentham',
                        textStyle: TextStyle(
                          color: textHighlightColor,
                          fontSize: 45.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Text(
                          'Fasting | ' + fasting.substring(fasting.indexOf(
                              '|') + 2),
                          style: GoogleFonts.getFont(
                            'Roboto Slab',
                            textStyle: TextStyle(
                              color: textColor.withAlpha(255),
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 25.0,
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: navColor.withAlpha(5).withOpacity(0.7),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      25, 20, 25, 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        'Today we commemorate:',
                                        style: GoogleFonts.getFont(
                                          'Roboto Slab',
                                          textStyle: TextStyle(
                                            color: textHighlightColor,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 20, 5, 0),
                                          child: Scrollbar(
                                            isAlwaysShown: true,
                                            controller: textScrollController,
                                            child: FadingEdgeScrollView
                                                .fromSingleChildScrollView(
                                              gradientFractionOnEnd: 0.5,
                                              gradientFractionOnStart: 0.5,
                                              child: SingleChildScrollView(
                                                controller: textScrollController,
                                                child: Text(
                                                  saintText,
                                                  style: GoogleFonts.getFont(
                                                    'Roboto Slab',
                                                    textStyle: TextStyle(
                                                      color: textColor,
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight
                                                          .normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Container(
                                      //   height: 100.0,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return loaded ? FadeIn(
        child: display(), duration: Duration(milliseconds: 500)) : Center(
      child: CircularProgressIndicator(),
    );
  }
}

