import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


final backgroundColor = Colors.white;
final accentColor = Color.fromARGB(255, 166,129,65);
final backgroundLightColor = Color.fromARGB(255,60,96,114);
final backgroundDarkColor = Color.fromARGB(255, 45,77,91);
final unselectedColor = Color.fromARGB(255,88,132,153);
final selectedColor = Color.fromARGB(255, 224,174,136);
final textHighlightColor = Color.fromARGB(255, 252,245,232);
final textColor = Color.fromARGB(255,140,174,188);
final navColor = Color.fromARGB(255,35,64,79);
final cardColor = Color.fromARGB(255, 250,225,195);

String date = "null";
String fasting = "null";
String iconAddr = "null";
List<String> saints = [];
String saintText = "null";
String epistleAddr = "null";
String gospelAddr = "null";
Reading epistle = Reading('Today\'s Epistle','subTitle','author','text');
Reading gospel = Reading('Today\'s Gospel','subTitle','author','text');


var now;

void getPrefs() async {
  final prefs = await SharedPreferences.getInstance();
  for (var prayer in prayers){
    prayer.favorited = (prefs.getBool(prayer.title+'_favorited') ?? false);
  }
}

bool needData(){
  if(date == "null") return true;
  if(fasting == "null") return true;
  if (iconAddr == "null") return true;
  if (saints.isEmpty) return true;
  if(now.day != DateTime.now().day || now.month != DateTime.now().month || now.year != DateTime.now().year) return true;
  return false;
}

class Prayer {
  String title = "";
  String author = "";
  String text = "";
  String source = "";
  bool favorited = false;

  Prayer(String title, String author, String text, String source){
    this.title = title;
    this.author = author;
    this.text = text;
    this.source = source;
  }
}

List<Prayer> prayers = [
  Prayer("The Lord's Prayer","","Our Father, who art in heaven, hallowed be Thy name. \n\nThy Kingdom come, Thy will be done, on earth as it is in heaven. \n\nGive us this day our daily bread; \n\nand forgive us our trespasses \n\nas we forgive those who trespass against us; \n\nand lead us not into temptation, \n\nbut deliver us from evil.",""),
  Prayer("The Nicene Creed","","I believe in one God, Father Almighty, Creator of heaven and earth, and of all things visible and invisible. \n\nAnd in one Lord Jesus Christ, the only-begotten Son of God, begotten of the Father before all ages; Light of Light, true God of true God, begotten, not created, of one essence with the Father through Whom all things were made. Who for us men and for our salvation came down from heaven and was incarnate of the Holy Spirit and the Virgin Mary and became man. He was crucified for us under Pontius Pilate, and suffered and was buried; And He rose on the third day, according to the Scriptures. He ascended into heaven and is seated at the right hand of the Father; And He will come again with glory to judge the living and dead. His kingdom shall have no end. \n\nAnd in the Holy Spirit, the Lord, the Creator of life, Who proceeds from the Father, Who together with the Father and the Son is worshipped and glorified, Who spoke through the prophets. \n\nIn one, holy, catholic, and apostolic Church. I confess one baptism for the forgiveness of sins. \n\nI look for the resurrection of the dead, and the life of the age to come. \n\nAmen.",""),
  Prayer("A Prayer for All Times","St. Mardarios","O Master and God, Father almighty, Lord, and only-begotten Son, Jesus Christ, and Holy Spirit, one divinity and power, have mercy on me a sinner, and save me, your unworthy servant, in any way you know; for you are blessed unto the ages of ages. Amen.","Voices in the Wilderness: An Anthology of Patristic Prayers by Nikolaos S. Hatzinikolaou. Published by Holy Cross Orthodox Press, Brookline, MA."),
  Prayer("Morning Prayer","","In the name of the Father and the Son and the Holy Spirit. Amen. \n\nGlory to you, our God, glory to you. \n\nHeavenly King, Comforter, the Spirit of truth, who are present everywhere filling all things, Treasury of good things and Giver of life, come and dwell in us. Cleanse us of every stain, and save our souls, gracious Lord. \n\nHoly God, Holy Mighty, Holy Immortal, have mercy on us (3). \n\nGlory to the Father and the Son and the Holy Spirit, now and forever and to the ages of ages. Amen. \n\nAll holy Trinity, have mercy on us. Lord, forgive our sins. Master, pardon our transgressions. Holy One, visit and heal our infirmities for your name\'s sake. \n\nLord, have mercy. Lord, have mercy. Lord, have mercy. \n\nGlory to the Father and the Son and the Holy Spirit, now and forever and to the ages of ages. Amen. \n\nOur Father, who art in heaven, hallowed be Thy name. Thy kingdom come, Thy will be done, on earth as it is in heaven. Give us this day our daily bread; and forgive us our trespasses, as we forgive those who trespass against us. And lead us not into temptation, but deliver us from evil. \n\nFor yours is the kingdom and the power and the glory, of the Father and the Son and the Holy Spirit, now and forever and to the ages of ages. Amen. \n\n(Then the following prayers to the Holy Trinity:) \n\nHaving risen from sleep, we fall before you, O good One, and sing to you, mighty One, the angelic hymn: Holy, holy, holy are you, O God. Through the prayers of the Theotokos, have mercy on us. \n\nGlory to the Father and the Son and the Holy Spirit. \n\nHaving aroused me from sleep and bed, O Lord, enlighten my mind and open my heart and lips that I may sing to you, Holy Trinity: Holy, holy, holy are you, O God. Through the prayers of the Theotokos, have mercy on us. \n\nNow and forever and to the ages of ages. Amen. \n\nSuddenly the Judge will come and everyones deeds will be revealed. But with awe we cry out in the middle of the night: Holy, holy, holy are you, O God. Through the prayers of the Theotokos, have mercy on us. \n\nLord, have mercy (12).","Edited by N. Michael Vaporis. Liturgical Texts courtesy and copyright of Holy Cross Press, Brookline, MA"),
  Prayer("Psalm 120 (121)","","I will lift, up my eyes to the hills. From where comes my help? My help comes from the Lord, who made heaven and earth. He will not allow your foot to be moved; he who keeps you will not slumber. Behold, he who watches over Israel shall neither slumber nor sleep. The Lord shall protect you; the Lord is your shelter at your right hand. The sun shall not burn you by day, nor the moon by night. The Lord shall preserve you from all evil; the Lord shall preserve your soul. The Lord shall preserve your going out and your coming in from this time forth, and forevermore.","Edited by N. Michael Vaporis. Liturgical Texts courtesy and copyright of Holy Cross Press, Brookline, MA"),
  Prayer("A Prayer Of Thanksgiving","","As I rise from sleep, I thank you, Holy Trinity, for because of your great goodness and patience, you were not angry with me, an idler and sinner, nor have you destroyed me in my sins, but have shown your usual love for me. And when I was prostrate in despair, you raised me to glorify with your power. Enlighten now my mind\'s eye, open my mouth to study your words and understand your commandments, to do your will and sing to you in heartfelt adoration, and praise your most holy name, of the Father and the Son and the Holy Spirit, now and forever and to the ages of ages. Amen.","Edited by N. Michael Vaporis. Liturgical Texts courtesy and copyright of Holy Cross Press, Brookline, MA"),
  Prayer("Prayer of Saint Basil","St. Basil","We bless you, O God, most high and Lord of mercy. You are always doing great and inscrutable things with us, glorious and wonderful, and without number. You grant us sleep for rest from our infirmities, and repose from the burdens of our much toiling flesh. We thank you, for you have not destroyed us with our sins, but have continued to love us; and though we were sunk in despair, you have raised us up to glorify your power. Therefore, we implore your incomparable goodness. Enlighten the eyes of our understand and raise up our minds from the heavy sleep of indolence. Open our mouth and fill it with your praise, that we may be able without distraction to sing and confess that you are God, glorified in all and by all, the eternal Father, with your only begotten Son, and your all holy, good, and life giving Spirit, now and forever and to the ages of ages. Amen.",""),
  Prayer("Prayer Of Saint Eustratios","St. Eustratios","Most highly do I praise you, Lord, for you have taken notice of my lowliness and have not delivered me into the hands of my enemies but have relieved my soul of its needs. Now, Master, let your hand shelter me, and let your grace descend upon me, for my soul is distracted and pained at the departure from this, my miserable and sordid body, that the end design of the adversary may not overtake her and make her stumble into the darkness for the unknown and known sins amassed by me in this life. Be gracious to me, Master, and do not let my soul see the dark countenance of the evil spirits, but let her be received by your angels bright and shining. Glorify your holy name, and by your might set me before your divine judgment seat. When I am being judged, do not allow the hand of the prince of this world to take hold of me, to throw me, a sinner, into the depths of hell, but stand by me and be a savior and mediator to me. Have mercy, Lord, on my soul, defiled through the passions of this life, and receive her cleansed by penitence and confession, for you are blessed to the ages of ages. Amen","Edited by N. Michael Vaporis. Liturgical Texts courtesy and copyright of Holy Cross Press, Brookline, MA"),
  Prayer("Before Breakfast","","Glory to the Father and the Son and the Holy Spirit, now and forever and to the ages of ages. Amen. Lord, have mercy. Lord, have mercy. Lord, have mercy. Our Father, who are in heaven, hallowed be your name. Your kingdom come, your will be done, on earth as it is in heaven. Give us this day our daily bread; and forgive us our trespasses, as we forgive those who trespass against us. And lead us not into temptation, but deliver us from evil. For yours is the kingdom and the power and the glory, of the Father and the Son and the Holy Spirit, now and forever and to the ages of ages. Amen. Christ our God, bless the food and drink of your servants, for you are holy always, now and forever and to the ages of ages. Amen.",""),
  Prayer("Thanksgiving After Breakfast", "", "We thank you, Christ our God, for you have satisfied us with earthly gifts. Do not deprive us of your heavenly kingdom, but as you, O Savior, came among your disciples and gave them peace, come among us also and save us.", ""),
  Prayer("Before Lunch","","Glory to the Father and the Son and the Holy Spirit, now and forever and to the ages of ages. Amen. Lord, have mercy. Lord, have mercy. Lord, have mercy. Our Father, who are in heaven, hallowed be your name. Your kingdom come, your will be done, on earth as it is in heaven. Give us this day our daily bread; and forgive us our trespasses, as we forgive those who trespass against us. And lead us not into temptation, but deliver us from evil. For yours is the kingdom and the power and the glory, of the Father and the Son and the Holy Spirit, now and forever and to the ages of ages. Amen. Christ our God, bless the food and drink of your servants, for you are holy always, now and forever and to the ages of ages. Amen.",""),
  Prayer("Thanksgiving After Lunch","","We thank you, Christ our God, for you have satisfied us with earthly gifts. Do not deprive us of your heavenly kingdom, but as you, O Savior, came among your disciples and gave them peace, come among us also and save us.",""),
  Prayer("Prayers Before Dinner","","The poor shall eat and be satisfied, and they who seek the Lord shall praise him; their hearts shall live to the ages of ages. Glory to the Father and the Son and the Holy Spirit, now and forever and to the ages of ages. Amen. Lord, have mercy. Lord, have mercy. Lord, have mercy. Christ our God, bless the food and drink of your servants, for you are holy always, now and forever and to the ages of ages. Amen.",""),
  Prayer("Thanksgiving After Dinner","","Glory to the Father and to the Son and to the Holy Spirit, now and forever and to the ages of ages. Amen. Lord, have mercy. Lord, have mercy. Lord, have mercy. Lord, you have gladdened our hearts in your creation, and we have rejoiced in the work of your hands. The light of your countenance has shined upon us, Lord. You have gladdened our hearts. We have been satisfied with the good things of the earth. We shall sleep in peace and repose in you, for you alone, Lord, have sustained us in hope.",""),
  Prayer("Before Sleep","","In the name of the Father and the Son and the Holy Spirit. Amen. \n\nGlory to you, our God, glory to you. Heavenly King, Comforter, the Spirit of truth, who are present everywhere filling all things, Treasury of good things and Giver of life, come and dwell in us. Cleanse us of every stain, and save our souls, gracious Lord. \n\nHoly God, Holy and Mighty, Holy Immortal, have mercy on us (3). \n\nGlory to the Father and the Son and the Holy Spirit, now and forever and to the ages of ages. Amen. \n\nAll holy Trinity, have mercy on us. Lord, forgive our sins. Master, pardon our transgressions. Holy One, visit and heal our infirmities for your name\'s sake. \n\nLord, have mercy. Lord, have mercy. Lord, have mercy. \n\nGlory to the Father and the Son and the Holy Spirit, now and forever and to the ages of ages. Amen. \n\nOur Father, who are in heaven, hallowed be your name. Your kingdom come, your will be done, on earth as it is in heaven. Give us this day our daily bread; and forgive us our trespasses, as we forgive those who trespass against us. And lead us not into temptation, but deliver us from evil. For yours is the kingdom and the power and the glory, of the Father and the Son and the Holy Spirit, now and forever and to the ages of ages. Amen. \n\nNow that the day has come to a close, I thank you, Lord, and entreat that the eve­ning and the night be sinless. Grant this to me, Savior, and save me. Glory to the Father and the Son and the Holy Spirit. Now that the day has passed, I glorify you, Master, and I entreat that the evening with the night be without offense. Grant this to me, Savior, and save me. Now and forever and to the ages of ages. Amen. \n\nNow that the day has ended, I praise you, Holy One, and entreat that the evening and the night be undisturbed. Grant this to me, Savior, and save me. \n\nLord, have mercy (12).",""),
  Prayer("A Child's Evening Prayer","","Lord Jesus Christ, you received the child­ren who came to you, receive also from the lips of your child this evening prayer. Shel­ter me under the protection of your wings that I may lie down in peace and sleep. Awaken me in due time that I may glorify you, for you alone are good and love all people.\n\nInto Your hands, O Lord Jesus Christ, I commend my spirit and body; bless me, save me, and grant me eternal life.\n\nThe Father is my hope, the Son is my refuge, the Holy Spirit is my shelter. Holy Trinity, glory to You. Lord, Jesus Christ, Son of God, have mercy on me.",""),
  Prayer("Adult's Evening Prayer","","Lord our God, whatever sins I have com­mitted this day, in word, deed or thought, forgive me, for you are good and love all people. Grant me a peaceful and undisturbed sleep. Protect me from every abuse and plot of the evil one. Raise me up in due time that I may glorify you, for you are blessed, to­gether with your only begotten Son, and your all holy Spirit, now and forever and to the ages of ages. Amen. \n\nI believe in one God, the Father, the Almighty, Creator of heaven and earth and of all things visible and invisible. And in one Lord Jesus Christ, the only begotten Son of God, begotten of the Father before all ages. Light of Light, true God of true God, begotten not created, of one essence with the Father through whom all things were made. For us and for our salvation he came down from heaven and was incarnate by the Holy Spirit and the Virgin Mary and became man. He was crucified for us under Pontius Pilate, and he suffered and was buried. On the third day he rose according to the Scriptures. He ascended into heaven and is seated at the right hand of the Father. He will come again in glory to judge the living and dead. His kingdom will have no end. And in the Holy Spirit, the Lord, the Giver of life, who proceeds from the Father, who together with the Father and the Son is worshiped and glorified, who spoke through the prophets. In one, holy, catholic, and apostolic Church. I acknowledge one baptism for the forgiveness of sins. I expect the resurrection of the dead. And the life of the ages to come. Amen. \n\nAt all times and in every hour, you are worshiped and glorified in heaven and on earth, Christ our God. Long in patience, great in mercy and compassion, you love the righteous and show mercy to sinners. You call all to salvation through the prom­ise of good things to come. Lord, receive our prayers at the present time. Direct our lives according to your commandments. Sanctify our souls. Purify our bodies. Set our minds aright. Cleanse our thoughts and deliver us from all sorrow, evil, and distress. Surround us with your holy an­gels that, guarded and guided by their host, we may arrive at the unity of the faith and the understanding of your ineffable glory. For you are blessed to the ages of ages. Amen.",""),
  Prayer("A Child’s Morning Prayer","","Lord Jesus, I thank You for the gift of this new day. When You came to earth for us, You grew as a child in wisdom and grace. As Lord, You received children in Your arms. You blessed them and said that Your kingdom belongs to them. Dear Jesus, receive me also on this day and hear my morning prayer. Bless my parents, teachers, and all those who love and care for me.\n\nBless me, also, and protect me from danger and evil. Give me strength to be truthful, honest, kind, and helpful to others. Guide me to grow as a member of Your kingdom. You are my Lord and King, and to You I give praise and thanks forever.",""),
  Prayer("Prayer for Parents","","O Lord, Heavenly Father, You have blessed us with the gift of family and have entrusted us with their spiritual upbringing. You commanded that we should teach our children about You in our lives: when we sit in our house, when we walk by the way, when we lie down and when we rise. Guide us O Lord every moment of the day as we work toward this awesome task.\n\nLet the words of Christ dwell in us, so that we may teach and guide our family, through our words and deeds, to the saving knowledge of Your everlasting kingdom. Help us, O Lord, be compassionate, kind, and patient throughout our days. If one of us has a complaint against another, help us to forgive each other; as You have forgiven us. Let the peace of Christ rule in our hearts. Above all, help us to remember to put on love which binds everything together in perfect harmony.\n\nWe thank You, Lord for the many blessings and mercies You continually bestow on us. In everything we do, in word or deed, may we always do so in the name of the Lord Jesus, giving thanks to God the Father through His Holy Spirit. Amen.",""),
  Prayer("From the Sacrament of Marriage","","From the Sacrament of Holy Matrimony:\n\nO God, our God, Who was present in Cana of Galilee and blessed the marriage there, do You also bless these Your servants, who, by Your providence, are joined in the community of marriage. Bless their comings-in and their goings-out. Replenish their life with all good things. Accept their crowns in Your Kingdom unsoiled and undefiled, and preserve them without offense to the ages of ages.\n\nAnother Prayer from the Sacrament of Holy Matrimony:\n\nO Lord our God, who in Your saving dispensation declared marriage honorable by Your presence in Cana of Galilee, keep in peace and concord your servants, whom you have joined together as one. Make their marriage honorable. Preserve their union undefiled; grant that they may live together blamelessly; and make them worthy to attain to a ripe old age, fulfilling Your commandments with a pure heart.\n\nFor You are our God, the God of mercy and salvation, and to You we send up glory, together with Your Father Who is without beginning, and Your all-holy, good, and life-creating Spirit, always, now and forever, and to the ages of ages. Amen.",""),
  Prayer("Lenten Prayer of St. Ephrem the Syrian","St. Ephrem","O Lord and Master of my life!\n\nTake from me the spirit of sloth,\nfaint-heartedness, lust of power, and idle talk.\n\nBut give rather the spirit of chastity,\nhumility, patience, and love to Thy servant.\n\nYea, Lord and King! Grant me to see my own errors\nand not to judge my brother,\nfor Thou art blessed unto ages of ages. Amen.",""),
];

class Reading {

  String title = "";
  String subTitle = "";
  String author = "";
  String text = "";

  Reading(String title, String subTitle, String author, String text){
    this.title = title;
    this.subTitle = subTitle;
    this.author = author;
    this.text = text;
  }
}

List<Reading> readings = [
  epistle,
  gospel,
  Reading('Title','subTitle','author','asjflajd ajsdlbjfas dbfadjlbfal djlfadjseucbe ablcebal djhafluebcjda dbclauehlfakdjbs fdblajchbdlab dlfelufhla b djlcjdbla lsudhflueadb cbdlajbdlkjs ueflbuadl acdjabdljfaldbf euflhaudblc djlablsuehluflakjsb d cbjdlbaksjlduehfula bcdjaljsdlfkeuga bcjdlag fue cbdjlajljdlf eguald cjdlajdbflauef  djalfujdbfljdalkuegfl adjbcdljafglegfbanx mb,ahbdlcaudhlfad fe albjxbv,dj asijbdla sldjbf aljsbdlf jaksblkdjblkjlbkjblka bcxb,znb,ncb uwal kjdsba nxb,cznjcblvkaldkjafbl dbaljdlfbakjeb cjxlczblvkdblksj adbljafkbseuhg bjlbjdalkjxbcl aluealebclajdbclakjdbal jdb lcuakdblaueblufbeidbcalkjcbd alkjdblkajbdflkfualubfakljdbclkjab dkjblckajbdluaeblaubdlca abdjlcbalkjdbclkuealbudjlab cbdjlabdljalbeucbla bjlcbdlkjableubclkjdb bclkjdbakljbdlkuabeubc bdljablbleub cbljdbalueb'),
  Reading('Title','subTitle','author','text'),
  Reading('Title','subTitle','author','text'),
  Reading('Title','subTitle','author','text'),
  Reading('Title','subTitle','author','text'),
  Reading('Title','subTitle','author','text'),
  Reading('Title','subTitle','author','text'),
  Reading('Title','subTitle','author','text'),
  Reading('Title','subTitle','author','text'),
  Reading('Title','subTitle','author','text'),
  Reading('Title','subTitle','author','text'),
];


