import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'telaAddEvento.dart';
import 'meusEventos.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';




class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double longitude;
  double latitude;
  List<Marker> myMarker = [];
  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getCurrentLocation() async {
    final position = await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = double.parse('${position.latitude}');
      longitude = double.parse('${position.longitude}');
    });
  }

  @override
  Widget build(BuildContext context) {
    String query;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sextou"),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                color: Colors.redAccent,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://www.meiahora.com.br/_midias/jpg/2020/11/27/700x930/1_mc_poze-20603451.jpg"),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Text(
                        "Mc Poze", // Nomeusuario
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      Text(
                        "mcpoze@mopaz.com", // Emailsuario
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.list_rounded),
                title: Text("Meus eventos",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20.0)),
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => meusEventos()));
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.add_location_alt),
                title: Text("Criar Novo evento",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20.0)),
                onTap: () {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => addEventos()));
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text("Adicionar evento",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20.0)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.zoom_in),
                title: Text("Eventos em destaque",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20.0)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout",
                    style: new TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20.0)),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: Container(
          child: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (latitude == null) {
                myMarker.add(new Marker(
                    width: 45.0,
                    height: 45.0,
                    point: new LatLng(37.42, -122.08),
                    builder: (context) => new Container(
                            child: IconButton(
                          icon: Icon(Icons.location_on),
                          color: Colors.red,
                          iconSize: 45.0,
                          onPressed: () {
                            print("Clicou ein 1");
                          },
                        ))));
                myMarker.add(new Marker(
                    width: 45.0,
                    height: 45.0,
                    point: new LatLng(37.427877, -122.090115),
                    builder: (context) => new Container(
                            child: IconButton(
                          icon: Icon(Icons.location_on),
                          color: Colors.red,
                          iconSize: 45.0,
                          onPressed: () {
                            print("Clicou ein 2");
                          },
                        ))));
                myMarker.add(new Marker(
                    width: 80.0,
                    height: 80.0,
                    point: new LatLng(37.406555, -122.078291),
                    builder: (context) => new Container(
                            child: IconButton(
                          icon: Icon(Icons.location_on),
                          color: Colors.red,
                          iconSize: 45.0,
                          onPressed: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {

                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height*1,
                                    width: double.infinity,
                                    color: Colors.transparent,
                                    child: Container(
                                        decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: const Radius.circular(40.0),
                                              topRight: const Radius.circular(40.0),
                                            )),
                                        child: Column(
                                          children: <Widget>[
                                            Text("Hu"),
                                            MaterialApp(
                                              title: 'Search Widget',
                                              theme: ThemeData(
                                                primarySwatch: Colors.blueGrey,
                                              )),
                                            ],
                                          )),
                                  );
                                },
                              );

                            print("Clicou ein 3");
                          },
                        ))));
                return Container(
                    child: Center(
                  child: SpinKitThreeBounce(
                    color: Colors.redAccent,
                    size: 50.0,
                  ),
                ));
              }
              return FlutterMap(
                options: new MapOptions(
                    center: new LatLng(latitude, longitude), minZoom: 0.0),
                layers: [
                  new TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                  new MarkerLayerOptions(markers: myMarker),
                ],
              );
            },
          ),
        ));
  }
}
