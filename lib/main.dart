import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marquee/marquee.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(canvasColor: Colors.white),
      darkTheme: ThemeData(canvasColor: Colors.black),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String str = 'Flutter Demo';

  int _currentIndex = 0;

  List imgList = [
    'images/s1.jpg',
    'images/s2.jpg',
    'images/s3.jpg',
  ];

  ThemeMode tm = ThemeMode.light;
  bool _swVal = false;

  int? _radioValue = 0;
  String result = '';
  Color resultColor = Colors.green;

  bool js = false;
  bool cSharp = false;
  bool python = false;

  String get txt {
    String str = 'You Selected:\n';
    if (js == true) str += 'Javascript\n';
    if (cSharp == true) str += 'C#\n';
    if (python == true)
      str += 'Python\n';
    else
      str += 'None\n';

    return str;
  }

  String? _selectedLetter;
  final List<String> _letterList = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];

  double _value = 0.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // tm : يمثل ال الثيم مود
      themeMode: tm,
      // يتغيير الثيم تاع التطبيق حسب الجهاز الخاص بالمستخدم
      //themeMode: ThemeMode.system,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 1),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_circle),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.account_circle),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.deepPurpleAccent,
                Colors.pink,
                Colors.deepPurpleAccent,
              ],
            )),
          ),
          centerTitle: true,
          title: Text(
            str,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: InteractiveViwer(),
        //buildRadioListTile

        // Container(
        //  color: _radioValue == 0 ? Colors.brown : Colors.green,
        //  padding: EdgeInsets.all(32),
        //  child: Column(
        //    children: [
        //      buildRadioListTile(0, "Brown", "change bg to Brown"),
        //      buildRadioListTile(1, "Green", "change bg to Green"),
        //    ],
        //  ),
        // ),

        // Center(
        // child: ElevatedButton(
        //  child: Text('show FlushBar'),
        // onPressed: () {
        //buildFlushbar(context);
        // someTextProperty();
        //},
        //  ),
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => buildSnackBar(context),
          child: const Icon(Icons.add),
        ),
      ),
    );
    //);
  }

  //Lesson #1 Toast
  void buildToast(BuildContext ctx) {
    showToast(
      //يوفر ملاحظات بسيطة حول عملية في نافذة منبثقة صغيرة. إنه يملأ فقط مقدار المساحة المطلوبة للرسالة ويظل النشاط الحالي مرئيا وتفاعليا. تختفي تلقائيا بعد انتهاء المهلة.
      'Pink/Amber',
      backgroundColor: Colors.amber,
      textStyle: const TextStyle(color: Colors.pink),
      context: ctx,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.center,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

  //Lesson #3 AlertDialog
  void buildDialog(BuildContext ctx) {
    final AlertDialog alert = AlertDialog(
      title: const Text('Dialog Title'),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            const Divider(color: Colors.black),
            const Text(
                'Dialog Text Appear Here You Can type AnyThing You Want!'),
            const SizedBox(height: 7),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: const Text('Close !',
                    style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: ctx,
      builder: (_) => alert,
      barrierDismissible: false,
      barrierColor: Colors.red.withOpacity(0.3),
    );
  }

  //Lesson #4 SnackBar
  void buildSnackBar(BuildContext ctx) {
    final sBar = SnackBar(
      action: SnackBarAction(
        textColor: Colors.black,
        label: 'Undo!',
        onPressed: () {
          setState(() {
            str = 'Flutter Demo';
          });
        },
      ),
      content: const Text('SnackBar Text'),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    );
    ScaffoldMessenger.of(ctx).showSnackBar(sBar);
  }

  //Lesson #5 Flushbar
  void buildFlushbar(BuildContext ctx) {
    Flushbar(
      //لعرض معلومات معينة
      // وقت محدد لظهور الفلاش بار
      duration: const Duration(seconds: 2),
      // موقع ال الفلاش بار
      flushbarPosition: FlushbarPosition.TOP,
      mainButton: TextButton(
        child: const Text(
          'Close',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.of(ctx).pop();
        },
      ),
      backgroundColor: Colors.deepPurpleAccent,
      icon: Icon(
        Icons.info,
        color: Colors.white,
      ),
      title: 'This is the title',
      //message: 'This is the message',
      messageText: const Text(
        'This is the message',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
      ),
    ).show(ctx);
  }

  //Lesson #6 Overflow & softWrap & SelectableText
  Widget someTextProperty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // اي ان النص قابل للتحديد
        const SelectableText(
          "I'm A Copiable Text Select Me And See What Gonna Happen!",
          // مؤشر
          showCursor: true,
          //لون المؤشر
          cursorColor: Colors.green,
          //عرض المؤشر
          cursorWidth: 10,
          toolbarOptions: ToolbarOptions(
            //cut: true,
            copy: true,
            selectAll: true,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 200,
          height: 40,
          color: Colors.green,
          child: const Text(
            'This Is A Clipped Text,This Is A Clipped Text,This Is A Clipped Text,This Is A Clipped Text',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            // طريقة ظهور النصوص
            overflow: TextOverflow.clip,
            // عشان النص ما ينزل سطر جديد
            softWrap: false,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 200,
          height: 40,
          color: Colors.green,
          child: const Text(
            'This Is A Ellipsis Text,This Is A Ellipsis Text,This Is A Ellipsis Text,This Is A Ellipsis Text',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 200,
          height: 40,
          color: Colors.green,
          child: const Text(
            'This Is A Faded Text,This Is A Faded Text,This Is A Faded Text,This Is A Faded Text',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            overflow: TextOverflow.fade,
            softWrap: false,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 200,
          height: 40,
          color: Colors.green,
          child: const Text(
            'This Is A Visible Text,This Is A Visible Text,This Is A Visible Text,This Is A Visible Text',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            overflow: TextOverflow.visible,
            softWrap: false,
          ),
        ),
      ],
    );
  }

  //Lesson #7 & 8 Image Slider
  Widget buildCarousel() {
    Widget buildContainer(index) {
      return Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index ? Colors.redAccent : Colors.green,
        ),
      );
    }

    return ListView(
      children: [
        SizedBox(height: 30),
        Text(
          'Slider 1 : Initial page Index 0 \n\n',
          textAlign: TextAlign.center,
        ),
        // بنستخدم معها ماب
        CarouselSlider(
          // initialPage : الصورة الابتدائية
          options: CarouselOptions(
              height: 186,
              initialPage: 0,
              // تكبير الصورة الموجودة بالسنتر
              enlargeCenterPage: true,
              //يقوم بعرض تلقائي للصور
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              // انو تحريك الصور يكون دائم حتى لو خلصو الصور يرجع الي الصورة الاولى
              enableInfiniteScroll: true,
              // حتى لو استمريت بالضغط على عنصر معين هيتم الانتقال بدون اي مشكلة
              pauseAutoPlayOnTouch: false,
              // انو يرجع من الصورة الاخيرة الي الصورة الاولى
              reverse: true,
              // انو تحريك الصور هيكون بشكل عمودي وليس افقي
              scrollDirection: Axis.vertical,
              // حتى نعرف الاندكس المعروف حالبا
              onPageChanged: (index, _) {
                setState(() {
                  _currentIndex = index;
                });
              }),
          items: imgList.map((imageUrl) {
            return Container(
              width: double.infinity,
              //margin: EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fill,
              ),
            );
          }).toList(),
        ),
        // ما بنستخدم معها ماب
        //CarouselSlider.builder(itemCount: itemCount, itemBuilder: itemBuilder, options: options)
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildContainer(0),
            buildContainer(1),
            buildContainer(2),
          ],
        ),
        SizedBox(height: 30),
        Text(
          'Slider 2 : Initial page Index 1 \n\n',
          textAlign: TextAlign.center,
        ),
        // بنستخدم معها ماب
        CarouselSlider(
          // initialPage : الصورة الابتدائية
          options: CarouselOptions(
              height: 186, initialPage: 0, enlargeCenterPage: true),
          items: imgList.map((imageUrl) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fill,
              ),
            );
          }).toList(),
        ),
        // ما بنستخدم معها ماب
        //CarouselSlider.builder(
        //  itemCount: imgList.length,
        //  itemBuilder: (_, int index) {
        //    return Container(
        //     width: double.infinity,
        //       margin: EdgeInsets.symmetric(horizontal: 10),
        //     child: Image.asset(
        //     imgList[index],
        //      fit: BoxFit.fill,
        //        ),
        //        );
        //     },
        //      options: CarouselOptions(height: 186, initialPage: 0)),

        SizedBox(height: 30),
        Text(
          'Slider 3 : Initial page Index 2\n\n',
          textAlign: TextAlign.center,
        ),
        // بنستخدم معها ماب
        CarouselSlider(
          // initialPage : الصورة الابتدائية
          options: CarouselOptions(height: 186, initialPage: 0),
          items: imgList.map((imageUrl) {
            return Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.fill,
              ),
            );
          }).toList(),
        ),
        // ما بنستخدم معها ماب
        //CarouselSlider.builder(itemCount: itemCount, itemBuilder: itemBuilder, options: options)
      ],
    );
  }

  //Lesson #9 Radio Button
  Widget buildRadio(BuildContext ctx) {
    Widget buildRow(int value) {
      myDialog() {
        var ad = AlertDialog(
          content: SizedBox(
            height: 100,
            child: Column(
              children: [
                Text(result, style: TextStyle(color: resultColor)),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text('Answer Is:4'),
                ),
              ],
            ),
          ),
        );
        showDialog(context: ctx, builder: (BuildContext context) => ad);
      }

      return Row(
        children: [
          Radio(
            value: value,
            groupValue: _radioValue,
            onChanged: (value) {
              setState(() {
                _radioValue = int.parse(value.toString());
                result = value == 4 ? 'Correct Answer!' : 'Wrong Answer!';
                resultColor = value == 4 ? Colors.green : Colors.redAccent;
                myDialog();
              });
            },
          ),
          Text('$value'),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            ' Guess The Answer : 2+2=?',
            style: TextStyle(
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
          buildRow(3),
          buildRow(4),
          buildRow(5),
        ],
      ),
    );
  }

  //Lesson #10 RadioListTile
  Widget buildRadioListTile(int val, String txt, String subTxt) {
    return RadioListTile<int>(
      value: val,
      groupValue: _radioValue,
      // مكان الراديو اذا البداية او النهاية
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (int? value3) {
        setState(() {
          _radioValue = value3!;
        });
      },
      title: Text(txt),
      subtitle: Text(subTxt, style: const TextStyle(color: Colors.white)),
    );
  }

  //Lesson #11 CheckBox
  Widget buildCheckBox() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text('Select All the programing languages you know : '),
          Row(
            children: [
              Checkbox(
                value: js,
                onChanged: (value) {
                  setState(() {
                    js = value!;
                  });
                },
              ),
              Text('JS'),
            ],
          ),
          //Checkbox طريقة اخري ل
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            value: cSharp,
            onChanged: (value) {
              setState(() {
                cSharp = value!;
              });
            },
            title: Text('C#'),
          ),
          Row(
            children: [
              Checkbox(
                value: python,
                onChanged: (value) {
                  setState(() {
                    python = value!;
                  });
                },
              ),
              Text('python'),
            ],
          ),
          ElevatedButton(
            child: Text('Apply !'),
            onPressed: () {
              var ad = AlertDialog(
                title: Text('Thanks you for Applying'),
                content: Text(txt),
              );
              showDialog(
                context: context,
                builder: (context) {
                  return ad;
                },
              );
            },
          )
        ],
      ),
    );
  }

  //Lesson #12 Switch (ThemeMode)
  Widget buildSwitch() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(40),
            child: Text('Light'),
          ),
          Switch(
            value: _swVal,
            onChanged: (bool value) {
              setState(() {
                _swVal = value;

                if (_swVal == false)
                  tm = ThemeMode.light;
                else
                  tm = ThemeMode.dark;
              });
            },
            // activeColor: Colors.white,
            // activeTrackColor: Colors.white,
            inactiveThumbColor: Colors.blue,
          ),
          const Padding(
            padding: EdgeInsets.all(40),
            child: Text('Dark'),
          ),
        ],
      ),
    );
  }

//Lesson #13 DropdownButton (Combo Box)
  Widget buildDropdownButton() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Select a Letter!'),
          const SizedBox(width: 10),
          DropdownButton(
            hint: const Text('A!!!'),
            value: _selectedLetter,
            items: _letterList.map((String item) {
              return DropdownMenuItem(
                child: Text(item),
                value: item,
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                _selectedLetter = newVal.toString();
              });
            },
          ),
        ],
      ),
    );
  }

  //Lesson #14 ExpansionTile
  Widget buildExpansionTile(BuildContext ctx) {
    //ليست قابلة للتوسع
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ExpansionTile(
            backgroundColor: Colors.blueGrey,
            leading: const Icon(Icons.perm_identity),
            title: const Text('Account'),
            children: [
              const Divider(color: Colors.grey),
              Card(
                color: Colors.grey,
                child: ListTile(
                  //start
                  leading: const Icon(Icons.add),
                  //end
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('Sign Up!'),
                  subtitle: const Text('Where You Can Register An Account'),
                  onTap: () => buildSnackBar(ctx),
                ),
              ),
              Card(
                color: Colors.grey,
                child: ListTile(
                  leading: const Icon(Icons.account_circle),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('Sign In!'),
                  subtitle: const Text('Where You Can Login With Your Account'),
                  onTap: () => buildSnackBar(ctx),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ExpansionTile(
            backgroundColor: Colors.blueGrey,
            leading: const Icon(Icons.message),
            title: const Text('MoreInfo'),
            children: [
              const Divider(color: Colors.grey),
              Card(
                color: Colors.grey,
                child: ListTile(
                  leading: const Icon(Icons.phone),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: const Text('Contact'),
                  subtitle: const Text('Where You Can Call Us'),
                  onTap: () => buildSnackBar(ctx),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //Lesson #15 Marquee
  Widget buildMarquee() {
    return Marquee(
      //مثل شريط يمرر
      text: 'Some sample text that takes some space.',
      style: const TextStyle(fontWeight: FontWeight.bold),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      // المسافات بين الكلمات
      blankSpace: 20.0,
      // يخلي الكلام بشكل عمودي يظهر
      velocity: 100.0,
      // وقت التوقف
      pauseAfterRound: const Duration(seconds: 1),
      startPadding: 10.0,
      // سرعته
      accelerationDuration: const Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: const Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
    );
  }

  //Lesson #16 ImagePicker
  var _selectedImage = null;
  Widget buildImagePicker(BuildContext ctx) {
    Future getImage(ImageSource src) async {
      final XFile? pickedFile = await ImagePicker().pickImage(source: src);

      if (pickedFile != null) {
        print('Image selected.');
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        return _selectedImage;
      } else {
        print('No image selected.');
      }
    }

    Builder buildDialogItem(
        BuildContext context, String text, IconData icon, ImageSource src) {
      return Builder(
        builder: (innerContext) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: Icon(icon, color: Colors.white),
            title: Text(text),
            onTap: () async {
              getImage(src);
              Navigator.of(innerContext).pop();
            },
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: double.infinity,
          //height: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.indigo),
            ),
            child: const Text('Choose Image'),
            onPressed: () {
              var ad = AlertDialog(
                title: const Text('Choose Picture from:'),
                content: SizedBox(
                  height: double.infinity,
                  child: Column(
                    children: [
                      const Divider(color: Colors.black),
                      buildDialogItem(ctx, 'Camera', Icons.add_a_photo_outlined,
                          ImageSource.camera),
                      const SizedBox(height: 10),
                      buildDialogItem(ctx, 'Gallery', Icons.image_outlined,
                          ImageSource.gallery),
                    ],
                  ),
                ),
              );
              showDialog(
                  context: ctx,
                  builder: (BuildContext context) {
                    return ad;
                  });
            },
          ),
        ),
        _selectedImage == null ? const Center() : Image.file(_selectedImage),
      ],
    );
  }

  //Lesson #17 Color Picker
  Color currentColor = Colors.teal;
  void changeColor(Color color) => setState(() => currentColor = color);
  final List<Color> _defaultColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];
  Widget buildColorPicker(BuildContext ctx) {
    return Center(
      child: ElevatedButton(
          child: Text('Change My Colors !'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(currentColor),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext ctx) {
                  return AlertDialog(
                    title: Text('Select a color'),
                    content: Column(
                      // ياخد الارتفاع المناسب فقط Dialog عشان ال
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SingleChildScrollView(
                          child: BlockPicker(
                            pickerColor: currentColor,
                            onColorChanged: changeColor,
                            // حتى نصير نحدد الالوان بشكل عشوائي
                            availableColors: _defaultColors,
                          ),
                        ),
                        ElevatedButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.pop(ctx);
                          },
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }

  //Lesson #17 Color Picker part 2
  Color currentColor2 = Colors.amber;
  void changeColor2(Color color) => setState(() => currentColor = color);
  Widget buildColorPickerEx(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Color Picker Example'),
          bottom: TabBar(
            tabs: [
              const Tab(text: 'HSV'),
              const Tab(text: 'Material'),
              const Tab(text: 'Block'),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: RaisedButton(
                elevation: 3.0,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titlePadding: const EdgeInsets.all(0.0),
                        contentPadding: const EdgeInsets.all(0.0),
                        content: SingleChildScrollView(
                            child: ColorPicker(
                                pickerColor: currentColor2,
                                onColorChanged: changeColor2)

                            //SlidePicker(
                            //  pickerColor: currentColor2,
                            //  onColorChanged: changeColor2,
                            // حتى نبين اسماء الالوان
                            //  enableAlpha: true,
                            //  displayThumbColor: true,
                            //  showLabel: true,
                            //   showIndicator: true,
                            //   indicatorBorderRadius: BorderRadius.vertical(
                            //        top: Radius.circular(25.0)),
                            ),
                      );
                    },
                  );
                },
                child: const Text('Change me'),
                color: currentColor,
                // لون النص بتغيير حسب اللوان
                textColor: useWhiteForeground(currentColor)
                    ? const Color(0xffffffff)
                    : const Color(0xff000000),
              ),
            ),
            Center(
              child: RaisedButton(
                elevation: 3.0,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titlePadding: const EdgeInsets.all(0.0),
                        contentPadding: const EdgeInsets.all(0.0),
                        content: SingleChildScrollView(
                          child: MaterialPicker(
                            pickerColor: currentColor,
                            onColorChanged: changeColor,
                            enableLabel: true,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Change me'),
                color: currentColor,
                textColor: useWhiteForeground(currentColor)
                    ? const Color(0xffffffff)
                    : const Color(0xff000000),
              ),
            ),
            Center(
              child: RaisedButton(
                elevation: 3.0,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Select a color'),
                        content: SingleChildScrollView(
                          child: BlockPicker(
                            pickerColor: currentColor,
                            onColorChanged: changeColor,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Change me'),
                color: currentColor,
                textColor: useWhiteForeground(currentColor)
                    ? const Color(0xffffffff)
                    : const Color(0xff000000),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Lesson #18 Dismissible
  // لتوليد العناصر في الليست
  final li = List<String>.generate(
      // عدد العناصر
      20,
      (index) => 'Item Num ${index + 1}');
  Widget buildDismisible() {
    return ListView.builder(
      itemCount: li.length,
      itemBuilder: (BuildContext context, int index) {
        final item = li[index];
        return Dismissible(
          //يعطي قيمة معينة
          key: Key(item),
          onDismissed: (DismissDirection dir) {
            // لحذف عناصر داخل الليست
            setState(() => li.removeAt(index));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                action: SnackBarAction(
                  label: 'Undo!',
                  onPressed: () => setState(() => li.insert(index, item)),
                ),
                content: Text(
                  dir == DismissDirection.startToEnd
                      ? '$item  Deleted'
                      : '$item Liked',
                ),
              ),
            );
          },
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.startToEnd)
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Confirmation'),
                    content: Text('Are you sure you want to delete $item?'),
                    actions: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          setState(() => li.removeAt(index));
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Delete'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                    ],
                  );
                },
              );
            else
              return true;
          },
          child: ListTile(title: Center(child: Text(item))),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 20),
                Icon(Icons.delete, color: Colors.white),
                Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: Colors.green,
            alignment: Alignment.centerRight,
            child: const Icon(Icons.thumb_up),
          ),
        );
      },
    );
  }

  //Lesson #19 percent indicator
  Widget buildpercentindicator() {
    // لعرض نسبة معينة
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Circular Percent Indicators"),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          new CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            percent: 0.8,
            header: new Text("Icon header"),
            center: new Icon(
              Icons.person_pin,
              size: 50.0,
              color: Colors.blue,
            ),
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
          ),
          new CircularPercentIndicator(
            radius: 130.0,
            animation: true,
            animationDuration: 1200,
            lineWidth: 15.0,
            percent: 0.4,
            center: new Text(
              "40 hours",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            circularStrokeCap: CircularStrokeCap.butt,
            backgroundColor: Colors.yellow,
            progressColor: Colors.red,
          ),
          new CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 13.0,
            animation: true,
            percent: 0.7,
            center: new Text(
              "70.0%",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            footer: new Text(
              "Sales this week",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: Colors.purple,
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: new CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 5.0,
              percent: 1.0,
              center: new Text("100%"),
              progressColor: Colors.green,
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 4.0,
                  percent: 0.10,
                  center: new Text("10%"),
                  progressColor: Colors.red,
                ),
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                new CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 4.0,
                  percent: 0.30,
                  center: new Text("30%"),
                  progressColor: Colors.orange,
                ),
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                new CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 4.0,
                  percent: 0.60,
                  center: new Text("60%"),
                  progressColor: Colors.yellow,
                ),
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                new CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 4.0,
                  percent: 0.90,
                  center: new Text("90%"),
                  progressColor: Colors.green,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  //Lesson #19 percent indicator part 2
  Widget buildpercentindicatorpart2() {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Linear Percent Indicators"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: new LinearPercentIndicator(
                width: 140.0,
                lineHeight: 14.0,
                percent: 0.5,
                center: Text(
                  "50.0%",
                  style: new TextStyle(fontSize: 12.0),
                ),
                trailing: Icon(Icons.mood),
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: new LinearPercentIndicator(
                width: 170.0,
                animation: true,
                animationDuration: 1000,
                lineHeight: 20.0,
                leading: new Text("left content"),
                trailing: new Text("right content"),
                percent: 0.2,
                center: Text("20.0%"),
                linearStrokeCap: LinearStrokeCap.butt,
                progressColor: Colors.red,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: new LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2000,
                percent: 0.9,
                center: Text("90.0%"),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.greenAccent,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: new LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20.0,
                animationDuration: 2500,
                percent: 0.8,
                center: Text("80.0%"),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.green,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  new LinearPercentIndicator(
                    width: 100.0,
                    lineHeight: 8.0,
                    percent: 0.2,
                    progressColor: Colors.red,
                  ),
                  new LinearPercentIndicator(
                    width: 100.0,
                    lineHeight: 8.0,
                    percent: 0.5,
                    progressColor: Colors.orange,
                  ),
                  new LinearPercentIndicator(
                    width: 100.0,
                    lineHeight: 8.0,
                    percent: 0.9,
                    progressColor: Colors.blue,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Lesson #20 ListWheelScrollView
  Widget buildListWheelScrollView() {
    const List<String> nameList = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    List<Color> colorList =
        List.generate(nameList.length, (index) => Colors.primaries[index]);

    int _i = 0;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: ListWheelScrollView(itemExtent: 100,
          // من خلال المابWidget الي ليست اوف String لتحويل ال الليست اوف
          children: [
            //... طؤيقة اخرى لارجاع ال ليست وهي نضع
            ...nameList.map((String name) {
              return Container(
                decoration: BoxDecoration(
                    color: colorList[_i++],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.red)),
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }),
          ]),
    );
  }

  //Lesson #21 InteractiveViwer
  Widget InteractiveViwer() {
    return Center(
      child: Container(
        height: 500,
        width: double.infinity,
        // للتحكم بالصورة من حيث تكبير وتصغير الصورة
        child: InteractiveViewer(
          // هاد انو يعني ما اسمح بعملية تكبير وتصغير الصورة
          //scaleEnabled: false,
          scaleEnabled: true,
          // يعطينا الصورة من حافيتها اليسرى
          constrained: false,
          // لا يمكن التحرك الي اليمين واليسار
          panEnabled: false,
          // من جميع الاتجاهاتMargin يعطينا
          boundaryMargin: EdgeInsets.all(42),
          // مقدار التكبير
          //maxScale: 0.3,
          // مقدار التصغير
          //minScale: 4,
          child: Image.asset(
            'images/s1.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
