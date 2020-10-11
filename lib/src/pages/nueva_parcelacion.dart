import 'package:flutter/material.dart';
import 'package:parcelacion/src/pages/parcelacion.dart';
import 'package:parcelacion/src/providers/parcelacion_provider.dart';

import 'home_page.dart';

class NuevaParcelacion extends StatefulWidget {

  final int corte;
  final int materia;



  NuevaParcelacion({Key key,@required this.corte, @required this.materia}) : super(key:key);

  @override
  _NuevaParcelacionState createState() => _NuevaParcelacionState();
}

class _NuevaParcelacionState extends State<NuevaParcelacion> {

  String nombre;
  double nota;
  double porcentaje;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
        },
        child: Icon(Icons.home),
        backgroundColor: Colors.orange,
      ),
      appBar: AppBar(
        title: Text('Agregar Nueva Actividad al Corte'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
        children: [
          TextField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                hintText: 'Digite la Actividad',
            ),
            onChanged: (value){
              setState(() {
                this.nombre = value;
              });
            },
          ),
          SizedBox(height: 20.0),
          TextField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                hintText: 'Porcentaje de la Actividad',
            ),
            onChanged: (value){
              setState(() {
                this.porcentaje = int.parse(value)/100;
              });

            },
          ),
          SizedBox(height: 20.0),
          TextField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                 hintText: 'Nota de la actividad',
            ),
            onChanged: (value){
              setState(() {
               this.nota = double.parse(value)/1;
              });
            },
          ),
          SizedBox(height: 20.0),
          FlatButton(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
            color: Colors.orange,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(20.0),
            splashColor: Colors.blueAccent,
            onPressed: () async{
                print(this.nota);
                final res = await ParcelacionProvider().newParcelacion(nombre,porcentaje,nota,widget.corte,widget.materia);
               if(res != -1){
                 Navigator.of(context).push(
                     MaterialPageRoute(builder: (_) => ParcelacionPage(corte:widget.corte,materia: widget.materia))
                 );
               }else{
                 showDialog(context: context,barrierDismissible: true,
                   builder: (context){
                     return AlertDialog(
                       title: Text('Warning'),
                       content: Text('El porcentaje de de las notas del corte no pueden super el 100%'),
                     );
                 });
               }
            },
            child: Text(
              "Guardar",
              style: TextStyle(fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }
}
