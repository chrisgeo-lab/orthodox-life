import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orthodox_app/globals.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrayerBook extends StatefulWidget {
  const PrayerBook({Key? key}) : super(key: key);

  @override
  _PrayerBookState createState() => _PrayerBookState();
}

class _PrayerBookState extends State<PrayerBook> {
  SwiperController swiperController = new SwiperController();

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: Duration(milliseconds: 250),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 100, 0, 50),
        child: Swiper(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context,int index){
            return PrayerCard(prayers[index], swiperController);
          },
          itemCount: prayers.length,
          controller: swiperController,
          itemHeight: 600.0,
          itemWidth: 375.0,
          layout: SwiperLayout.STACK,
        ),
      ),
    );
  }
}

class PrayerCard extends StatefulWidget {
  const PrayerCard(this.prayer, this.swiperController, {Key? key}) : super(key: key);

  final Prayer prayer;
  final SwiperController swiperController;

  @override
  _PrayerCardState createState() => _PrayerCardState();
}

class _PrayerCardState extends State<PrayerCard> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadFavorite();
  }

  //Loading counter value on start
  void loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.prayer.favorited = (prefs.getBool(widget.prayer.title+'_favorited') ?? false);
    });
  }

  //Incrementing counter after click
  void changeFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.prayer.favorited = !widget.prayer.favorited;
      prefs.setBool(widget.prayer.title+'_favorited', widget.prayer.favorited);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 600.0,
          width: 400.0,
        child: Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(
                      widget.prayer.title,
                    style: GoogleFonts.getFont(
                      'Bentham',
                      textStyle: TextStyle(
                        color: backgroundDarkColor,
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                    child: Container(
                      height: 2,
                      width: 300.0,
                      decoration: BoxDecoration(
                        color: selectedColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(30,0,30,0),
                                child: Text(
                                  widget.prayer.text,
                                  style: GoogleFonts.getFont(
                                    'Roboto Slab',
                                    textStyle: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        iconSize: 28.0,
                        icon: widget.prayer.favorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                        color: Colors.red[400],
                        onPressed: (){
                          changeFavorite();
                        }
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 30.0,
                        ),
                        flex: 1,
                      ),
                      IconButton(
                          icon: Icon(Icons.arrow_back),
                          color: backgroundDarkColor,
                          onPressed: (){
                            widget.swiperController.previous();
                          }
                      ),
                      IconButton(
                          icon: Icon(Icons.arrow_forward),
                          color: backgroundDarkColor,
                          onPressed: (){
                            widget.swiperController.next();
                          }
                      ),
                    ],
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

