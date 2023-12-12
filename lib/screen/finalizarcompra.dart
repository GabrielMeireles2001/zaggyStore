import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zaggyproject/database/db_helper.dart';
import 'package:zaggyproject/screen/principal.dart';
import 'package:zaggyproject/screen/sobre.dart';

final brl = NumberFormat.currency(
    locale: 'br', customPattern: 'R\$ #,###', decimalDigits: 2);

class FinalizaCompra extends StatefulWidget{

  @override
  State<FinalizaCompra> createState() => _FinalizaState();
}

class _FinalizaState extends State<FinalizaCompra> {
  List<Map<String, dynamic>> _produtos =[];
  double _valorTotal = 0.0;
  bool _estaAtualizando = true;

  void _atualizaProdutos() async{
    final data = await SQLHelper.getCarrinho();

    setState(() {
      _produtos=data;
      _valorTotal = _total(_produtos);

      if(data.isEmpty){
        _estaAtualizando = true;
      }
      else {
        _estaAtualizando = false;
      }
    });
  }

  double _total(List produtos){
    double total = 0.0;
    for(var valor in produtos){
      total += valor['valor'];
    }

    return total;
  }

  void initState(){
    super.initState();
    _atualizaProdutos();
  }

  void _apagaProduto(int id)async{
    await SQLHelper.apagaProduto(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Produto Removido!")),
    );
    _atualizaProdutos();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: dynamicAppBar(context),
      drawer: dynamicDrawer(context),
      body: _estaAtualizando
        ? const Center(
        child: Text("Carrinho vazio!",style: TextStyle(fontSize: 30),),
      )
          : ListView.builder(
          itemCount: _produtos.length,
        itemBuilder: (context,index)=> Card(
          color: Colors.white,
          margin: const EdgeInsets.all(4),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(_produtos[index]['foto1'],height: 100,),
                Text(_produtos[index]['nome'],style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 10),),
                Column(children: [
                  Text(brl.format(_produtos[index]['valor'])),
                  IconButton(onPressed: ()=> _apagaProduto(_produtos[index]['id']), icon: const Icon(Icons.delete)),
                ],),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Card(
          color: Colors.white,
          margin: const EdgeInsets.all(4),
          child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        Text(brl.format(_valorTotal),style: const TextStyle(fontSize: 20),),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                textStyle: const TextStyle(fontSize: 20),
            ), onPressed: () {  }, child: const Text("Finalizar Compra"),
            ),
      ],),
            ),
    );
  }

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
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> FinalizaCompra())
            );
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