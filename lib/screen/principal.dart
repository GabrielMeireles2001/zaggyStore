///import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zaggyproject/screen/login.dart';
import 'package:zaggyproject/screen/paginacliente.dart';
import 'package:zaggyproject/screen/product.dart';
import 'package:zaggyproject/screen/sobre.dart';
import 'package:zaggyproject/screen/finalizarcompra.dart';
import 'package:intl/intl.dart';

import '../database/db_helper.dart';


class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  List<Map<String, dynamic>> _produtos = [];
  bool _estaAtualizando = true;
  int log=0;

  final formatCurrency = NumberFormat.simpleCurrency();

  final brl = NumberFormat.currency(
      locale: 'br', customPattern: 'R\$ #,###', decimalDigits: 2);

  void _atualizaProdutos() async {
    final data = await SQLHelper.getAllRelogio();
    setState(() {
      _produtos = data;
      _estaAtualizando = false;
    });
  }

  void _atualizaUsuario() async{
    final usuario = await SQLHelper.getCurrentUser();
    setState(() {
      log = usuario.length;
    });
  }


@override
  void initState() {
  super.initState();
  _atualizaProdutos();
  _atualizaUsuario();
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: dynamicDrawer(context),

      appBar: dynamicAppBar(context),



      body: _estaAtualizando?
          const Center(
            child: CircularProgressIndicator(),
          )
      : ListView.builder(
                itemCount: _produtos.length,
              itemBuilder: (context, index) => Card(
                color: Colors.white,
                margin: const EdgeInsets.all(4),
                child: ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Produto(_produtos[index])),
                    );
                  },
                  title: Column(
                    children: [
                      SizedBox(
                        height: 400,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Padding(
                              padding:const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                            width: 330,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                            child: Image.network(_produtos[index]['foto1']),
                          ),
                        ),),
                          Padding(
                            padding:const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Container(
                                width: 330,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                child: Image.network(_produtos[index]['foto2']),
                              ),
                            ),),
                          Padding(
                            padding:const EdgeInsets.all(8.0),
                            child: InkWell(
                              child: Container(
                                width: 330,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                                child: Image.network(_produtos[index]['foto3']),
                              ),
                            ),),
                      ],),),
                      Text(_produtos[index]['nome']),
                      Text(brl.format(_produtos[index]['valor'])),
                    ],
                  ),

                ),
              ),

            ),



      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        onPressed: () {
          setState(() {
            SQLHelper.deletaBanco();
          });
        },
        label: const Icon(Icons.chat_rounded, color: Colors.black),
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


              print(log);

              if(log==1) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PaginaCliente())
                );
              }
              if (log==0){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Login())
                );
              }
            },
          ),



          //Cart icon
          IconButton(
            icon: const Icon(IconData(0xe759, fontFamily: 'MaterialIcons')),
            iconSize: 30,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> FinalizaCompra())
              );
            },),

        ],
      ),
    );
  }

  dynamicDrawer(BuildContext context){

    return SafeArea(
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
