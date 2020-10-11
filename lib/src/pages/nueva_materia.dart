import 'package:flutter/material.dart';
import 'package:parcelacion/src/models/materia.dart';
import 'package:parcelacion/src/pages/home_page.dart';
import 'package:parcelacion/src/pages/materia_page.dart';
import 'package:parcelacion/src/providers/materiaProvider.dart';

class NuevaMateriaForm  extends StatefulWidget {
  @override
  _NuevaMateriaFormState createState() => _NuevaMateriaFormState();
}

class _NuevaMateriaFormState extends State<NuevaMateriaForm> {

  String _nombre;
  int _codigo;

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
        title: Text('Agregar Materia'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
        children: [
          TextField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Codigo de la materia...Ejemplo->RDF35',
            ),
            onChanged: (value){
              setState(() {
                _codigo = int.parse(value) ;
              });
            },
          ),
          SizedBox(height: 20.0),
          TextField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'Digite el Nombre',
            ),
            onChanged: (value){
              setState(() {
                _nombre = value;
              });
            },
          ),
          SizedBox(height: 50.0),
          FlatButton(
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0)),
            color: Colors.orange,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(10.0),
            splashColor: Colors.blueAccent,
            onPressed: () async{
             final res = await MateriaProvider().newMateria(Materia(id:_codigo,nombre:_nombre));
             Navigator.of(context).push(MaterialPageRoute(builder: (_)=>HomePage()));
            },
            child: Text("Guardar", style: TextStyle(fontSize: 20.0),


            ),
          )
        ],
      ),
    );
  }
}
