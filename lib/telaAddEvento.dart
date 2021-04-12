import 'dart:io';
import 'package:flutter/material.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:image_picker/image_picker.dart';

class newAddress {
  String address;
  double latitude;
  double longitude;
  newAddress(String address , double latitude, double longitude) {
    this.address = address;
    this.latitude = latitude;
    this.longitude = longitude;
  }
}

class newEvent {
  String nome;
  newAddress address1;
  newAddress address2;
  DateTime data1;
  DateTime data2;
  TimeOfDay hora1;
  TimeOfDay hora2;
  File imagem;
  String description;
  newEvent(String nome, newAddress address1, newAddress address2, DateTime data1,
      DateTime data2, TimeOfDay hora1, TimeOfDay hora2, File imagem, String description) {
    this.nome = nome;
    this.address1 = address1;
    this.address2 = address2;
    this.data1 = data1;
    this.data2 = data2;
    this.hora1 = hora1;
    this.hora2 = hora2;
    this.imagem = imagem;
    this.description = description;
  }
  printEvent() {
    print('{'+ "\n" +
    '"nome" : "${this.nome},"'+ "\n" +
    '"address1" : { "rua" : "${this.address1.address},"latitude" : "${this.address1.latitude},"longitude" : "${this.address1.longitude}, },"'+ "\n" +
    '"address2" : { "rua" : "${this.address2.address},"latitude" : "${this.address2.latitude},"longitude" : "${this.address2.longitude}, },"'+ "\n" +
    '"data1" : "${this.data1..toString().replaceAll('DateTime(', '').replaceAll(')', '')}","'+ "\n" +
    '"data2" : "${this.data2..toString().replaceAll('DateTime(', '').replaceAll(')', '')}","'+ "\n" +
    '"hora1" : "${this.hora1..toString().replaceAll('TimeOfDay(', '').replaceAll(')', '')}","'+ "\n" +
    '"hora2" : "${this.hora2..toString().replaceAll('TimeOfDay(', '').replaceAll(')', '')}","'+ "\n" +
    '"description" : "${this.description},"'+ "\n" +
    '}');
  }
}

class addEventos extends StatefulWidget{
  @override
  _addEventos createState() => _addEventos();
}
// ignore: camel_case_types
class _addEventos extends State<addEventos> {
  final description = TextEditingController();
  final eventName = TextEditingController();
  File imagem;
  File imagemTemporaria;
  newAddress address1;
  newAddress address2;
  DateTime data1;
  DateTime data2;
  TimeOfDay hora1;
  TimeOfDay hora2;

  @override
  void initState(){
    super.initState();
      data1 = DateTime.now();
      data2 = DateTime.now();
      hora1 = TimeOfDay.now();
      hora2 = TimeOfDay.now();
  }
  void pegarImagemGaleria() async {
    // ignore: deprecated_member_use
    imagemTemporaria = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagem = imagemTemporaria;
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        //Here is the preferred height.
        preferredSize: Size.fromHeight(120.0),
        child: SafeArea(
          child : ListView(
              children: <Widget>[
                Container(
                  child: AppBar(
                    title: Text(''),
                    centerTitle: true,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30.0, 30.0, 0.0, 10.0),
                  color: Colors.red,
                  child : Text("Criar evento", style: TextStyle(fontSize: 25, color: Colors.white),),
                )
              ]
          ),
        ),
      ),
        body : ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: TextFormField(
                controller: eventName,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  labelStyle: TextStyle(color: Colors.redAccent),
                    labelText: 'Nome do Evento *'
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
              child: Center(
                child: Text("Opções de endereço", style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.normal,
                  fontSize: 15,
                )),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: SearchMapPlaceWidget(
                apiKey :'AIzaSyCi7Bm7jDmmY9APxb-p25B7mFZydRbUsFc',
                hasClearButton: true,
                placeholder: "1º endereço *",
                onSelected: (Place place) async {
                  Geolocation geolocation = await place.geolocation;
                  String cordernadas = geolocation.coordinates.toString().replaceAll('LatLng(', '').replaceAll(')', '');
                  var cordernadasList = cordernadas.split(",");
                  address1 = newAddress(place.description.toString(),
                      double.parse(cordernadasList[0]),
                      double.parse(cordernadasList[1]));
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: SearchMapPlaceWidget(
                apiKey :'AIzaSyCi7Bm7jDmmY9APxb-p25B7mFZydRbUsFc',
                hasClearButton: true,
                placeholder: "2º endereço",
                onSelected: (Place place) async {
                  Geolocation geolocation = await place.geolocation;
                  String cordernadas = geolocation.coordinates.toString().replaceAll('LatLng(', '').replaceAll(')', '');
                  var cordernadasList = cordernadas.split(",");
                  address2 = newAddress(place.description.toString(),
                      double.parse(cordernadasList[0]),
                      double.parse(cordernadasList[1]));
                },
              ),
            ),SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Container(
                  height: 150.0,
                  width: 195.0,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        Text("Opções de datas"),
                        ListTile(
                          title: Text("* Data: ${data1.day}/${data1.month}/${data1.year}", style: TextStyle(fontSize: 14, color: Colors.redAccent),),
                          trailing: Icon(Icons.calendar_today_outlined),
                          onTap: _pickDate,
                        ),
                        ListTile(
                          title: Text("* Data: ${data2.day}/${data2.month}/${data2.year}",style: TextStyle(fontSize: 14, color: Colors.redAccent)),
                          trailing: Icon(Icons.calendar_today_outlined),
                          onTap: _pickDate2,
                        )
                      ],
                    ),
                  ),
                ),
                  Container(
                    height: 150.0,
                    width: 175.0,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget> [
                          Text("Opções de horas"),
                          ListTile(
                            title: Text("* Hora: ${hora1.toString().replaceAll('TimeOfDay(', '').replaceAll(')', '')}", style: TextStyle(fontSize: 14, color: Colors.redAccent)),
                            trailing: Icon(Icons.access_time),
                            onTap: _pickTime1,
                          ),
                          ListTile(
                            title: Text("* Hora: ${hora2.toString().replaceAll('TimeOfDay(', '').replaceAll(')', '')}", style: TextStyle(fontSize: 14, color: Colors.redAccent)),
                            trailing: Icon(Icons.access_time),
                            onTap: _pickTime2,
                          )
                        ],
                      ),
                    ),
                  ),
              ],
              )
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
              child: Text("Adicionar imagem *", style  : TextStyle(color: Colors.redAccent) )
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 3.0),
              child: Center(
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black12)
                    ),
                    color: Colors.grey,
                    child: Container(
                      child: Text("Selecionar imagem", style: TextStyle(color: Colors.white),),
                    ),
                    onPressed : (){
                      pegarImagemGaleria();
                    }),
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 30.0),
              child: TextFormField(
                controller: description,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                    labelStyle: TextStyle(color: Colors.redAccent),
                    labelText: 'Descrição do Evento *'
                ),
                ),
            ),
            // ignore: deprecated_member_use
            Center(

              child: RaisedButton(
                  color: Colors.green,
                  child: Container(
                    child: Text("      Criar evento      ", style: TextStyle(color: Colors.white, ),),
                  ),
                  onPressed : (){
                    if (address1 == null || eventName == "" || imagem == null || description.text == null){
                      showAlertDialog1(context);
                    }else {
                      newEvent evento = new newEvent(eventName.text, address1, address2, data1, data2, hora1, hora2, imagem, description.text);
                      evento.printEvent();
                    }
                    print(description.text);
                    print(eventName.text);
                  }),
            )
          ],
        ),
    );

  }
   _pickDate() async {
    DateTime data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (data != null){
      setState(() {
        data1 = data;
      });
    }
  }
  _pickDate2() async {
    DateTime data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (data != null){
      setState(() {
        data2 = data;
      });
    }
  }
  _pickTime1() async {
    TimeOfDay _time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (_time != null){
      setState(() {
        hora1 = _time;
        print(_time.toString());
      });
    }
  }
  _pickTime2() async {
    TimeOfDay _time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (_time != null){
      setState(() {
        hora2 = _time;
      });
    }
  }
  showAlertDialog1(BuildContext context)
  {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Informações incompletas"),
      content: Text("Por favor preencar todos os campos com * "),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }
}