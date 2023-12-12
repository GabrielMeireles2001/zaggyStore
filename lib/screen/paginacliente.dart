
import 'package:flutter/material.dart';
import 'package:zaggyproject/screen/principal.dart';
import 'package:zaggyproject/screen/sobre.dart';

import '../database/db_helper.dart';
import 'finalizarCompra.dart';
import 'login.dart';

class PaginaCliente extends StatefulWidget {
  const PaginaCliente({super.key});

  @override
  State<StatefulWidget> createState() => _PaginaClienteState();

}

class _PaginaClienteState extends State<PaginaCliente> {
  List<Map<String, dynamic>> _usuario = [];

  void _atualizarUsuario() async{
    final data = await SQLHelper.getCurrentUser();
    setState(() {
      _usuario = data;
    });
  }

  void _apagaUsuario(int id) async {
    await SQLHelper.apagaUsuario(id);
  }

  void initState() {
    super.initState();
    _atualizarUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: dynamicAppBar(context),
      drawer: dynamicDrawer(context),
      body:Center(child:Column(children: [
        const Text("Dados do Cliente",style: TextStyle(fontSize: 20),),
        Row(children: [
          const Text("Nome: ",style: TextStyle(fontSize: 20),),
          Text(_usuario[0]['nome'],style: const TextStyle(fontSize: 20),),
        ],),
        Row(children: [
          const Text("Email: ",style: TextStyle(fontSize: 20),),
          Text(_usuario[0]['email'],style: const TextStyle(fontSize: 20),),
        ],),
        Row(children: [
          const Text("Logradouro: ",style: TextStyle(fontSize: 20),),
          Text(_usuario[0]['logradouro'],style: const TextStyle(fontSize: 20),),
        ],),
        Row(children: [
          const Text("Bairro: ",style: TextStyle(fontSize: 20),),
          Text(_usuario[0]['bairro'],style: const TextStyle(fontSize: 20),),
        ],),
        Row(children: [
          const Text("Número: ",style: TextStyle(fontSize: 20),),
          Text(_usuario[0]['numero'],style: const TextStyle(fontSize: 20),),
        ],),
        Row(children: [
          const Text("CEP: ",style: TextStyle(fontSize: 20),),
          Text(_usuario[0]['cep'],style: const TextStyle(fontSize: 20),),
        ],),
        Row(children: [
          const Text("Telefone: ",style: TextStyle(fontSize: 20),),
          Text(_usuario[0]['ddd'],style: const TextStyle(fontSize: 20),),
          Text(_usuario[0]['telefone'],style: const TextStyle(fontSize: 20),),
        ],),
        Row(children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              textStyle: const TextStyle(fontSize: 20),
            ), onPressed: () {
              _apagaUsuario(_usuario[0]['id']);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> const Login())
              );
          }, child: const Text("Deslogar"),
          ),
        ],),
      ],),
      ),
    );
  }



  dynamicAppBar(BuildContext context){
    return AppBar(
      elevation: 1,
      //Image.network('https://zaggystore.com.br/cdn/shop/files/png_logo.png?v=1695857120',height: 70),

      toolbarHeight: 110,
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (BuildContext context){
          return IconButton(
            icon: const Icon(
              Icons.menu_sharp,
              size:35,
            ),
            onPressed: (){
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),


      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          //searching icon
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 30,
            onPressed: () {  },
          ),


          //logo
          Expanded(
            child: IconButton(
              constraints: const BoxConstraints(maxHeight: 150),
              icon: Image.network('https://zaggystore.com.br/cdn/shop/files/png_logo.png?v=1695857120'),
              iconSize: 230,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=> const Principal())
                );
              },
            ),
          ),

          IconButton(
            icon: const Icon(IconData(0xe743, fontFamily: 'MaterialIcons')),
            iconSize: 30,
            onPressed: () {
            },
          ),



          //Cart icon
          IconButton(
            icon: const Icon(IconData(0xe759, fontFamily: 'MaterialIcons')),
            iconSize: 30,
            onPressed: () {
            },),

        ],
      ),
    );
  }

  dynamicDrawer(BuildContext context){

    return SizedBox(
      child: Drawer(
          child: Column(
            children: [
              const ListTile(
                  title: Text('Menu')
              ),
              const Divider(),

              TextButton(
                onPressed:(){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=> const Principal())
                  );
                },
                child: const Text('Inicio'),
              ),
              const Divider(),

              TextButton(
                onPressed:(){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=> const Sobre())
                  );
                },
                child: const Text('Sobre'),
              ),
            ],
          )
      ),
    );
  }

}