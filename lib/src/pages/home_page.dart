import 'package:flutter/material.dart';
import 'package:parcelacion/src/pages/materia_page.dart';
import 'package:parcelacion/src/pages/nueva_materia.dart';
import 'package:parcelacion/src/providers/materiaProvider.dart';
import 'package:parcelacion/src/providers/parcelacion_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
          },
          child: Icon(Icons.home),
          backgroundColor: Colors.orange,
        ),
      appBar: AppBar(
        title: Text('CACULAR CALIFICACIONES PM'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context){
                  return NuevaMateriaForm();
                })
              );
            },)
        ]

      ),
      body: FutureBuilder(
        future: MateriaProvider().getMaterias(),
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          return ListView(
            children: snapshot.data.map((e){
              return FutureBuilder(
                future: ParcelacionProvider().getDefinitiva(e.id),
                builder: (context, AsyncSnapshot<double>snapshot) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text('${e.nombre} '),
                        leading: Icon(Icons.arrow_forward),
                        trailing: Text('${snapshot.data.toStringAsFixed(2)}'),
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MateriaPage(id: e.id,)
                            )
                          );
                        },
                      ),
                      Divider(color: Colors.pink,)
                    ],
                  );
                },
              );
            }).toList(),
          );
        }
      )
    );
  }


}
