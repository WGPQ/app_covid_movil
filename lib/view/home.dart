import 'package:app_covid19/view/constant.dart';
import 'package:app_covid19/model/provincia.dart';
import 'package:app_covid19/view/counter.dart';
import 'package:app_covid19/view/my_header.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ViewHome extends StatelessWidget {
  final List<Provincia> provncia;
  final List provcasos;
  ViewHome({Key key, this.provncia, this.provcasos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme()),
      home: HomeScreen(prov: provncia, cas: provcasos),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final List<Provincia> prov;
  final List cas;
  const HomeScreen({Key key, this.prov, this.cas}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final controller = ScrollController();

  double offset = 0;
  int valuelist;
  String imaurl =
      "https://i.pinimg.com/originals/83/91/9a/83919a4d3f2d3808ee7d2e386eab0e30.png";
  int confirmados = 0;
  int recuperados = 0;
  int muertos = 0;
  DateTime now = new DateTime.now();

  Widget CasosCovid() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Counter(
            color: kInfectedColor,
            number: confirmados,
            title: "Infectados",
          ),
          Counter(
            color: kDeathColor,
            number: muertos,
            title: "Muertos",
          ),
          Counter(
            color: kRecovercolor,
            number: recuperados,
            title: "Recuperados",
          ),
        ]);
  }

  Widget ImgMapa() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 30,
            color: kShadowColor,
          ),
        ],
      ),
      child: Image.network(
        imaurl,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "Quedate",
              textBottom: "     en casa.",
              offset: offset,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFE5E5E5),
                ),
              ),
              child: Selector(widget.prov, widget.cas),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Casos Actualizados\n",
                              style: kTitleTextstyle,
                            ),
                            TextSpan(
                              text:
                                  "Actualización más reciente ${formatDate(DateTime(now.year, now.month, now.day), [
                                M,
                                ',',
                                d
                              ])}",
                              style: TextStyle(
                                color: kTextLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Ver detalles",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 30,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: CasosCovid()),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Propagación",
                        style: kTitleTextstyle,
                      ),
                      Text(
                        "Ver detalles",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  ImgMapa(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Selector(List<Provincia> list_prov, List casos) {
    return Row(
      children: <Widget>[
        SvgPicture.asset("assets/icons/maps-and-flags.svg"),
        SizedBox(width: 20),
        Expanded(
          child: DropdownButton<int>(
            isExpanded: true,
            hint: new Text("Selecione una provincia"),
            underline: SizedBox(),
            icon: SvgPicture.asset("assets/icons/dropdown.svg"),
            value: valuelist,
            items: list_prov.map((Provincia provincia) {
              return DropdownMenuItem<int>(
                value: provincia.id,
                child: Text(provincia.nombre),
                onTap: () {
                  //print(provincia.casos);
                  changeimage(provincia);
                },
              );
            }).toList(),
            onChanged: (int value) {
              setState(() {
                valuelist = value;
              });

              ImprimirCasoso(casos, value);
            },
          ),
        ),
      ],
    );
  }

  void ImprimirCasoso(List list_caso, int id) {
    List h;
    list_caso.forEach((element) {
      if (element['id'] == id) {
        h = element['casos'];
      }
    });
    if (!h.isEmpty) {
      h.forEach((element) {
        confirmados = element['confirmados'];
        muertos = element['fallecidos'];
        recuperados = element['recuperados'];
      });
    } else {
      confirmados = 0;
      muertos = 0;
      recuperados = 0;
    }
  }

  void changeimage(Provincia p) {
    imaurl = p.imageurl;
  }
}
