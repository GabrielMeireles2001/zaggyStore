import 'package:flutter/material.dart';
import 'package:zaggyproject/database/db_helper.dart';
import 'package:zaggyproject/screen/finalizarcompra.dart';
import 'package:zaggyproject/screen/principal.dart';
import 'package:zaggyproject/screen/sobre.dart';
import 'package:intl/intl.dart';

bool state=false;

class Produto extends StatefulWidget{
Map<String,dynamic> relogio;
Produto(this.relogio, {super.key});

  @override
  State<Produto> createState() => _ProdutoState();
}


class _ProdutoState extends State<Produto> {
final formatCurrency = NumberFormat.simpleCurrency();

final brl = NumberFormat.currency(
    locale: 'br', customPattern: 'R\$ #,###', decimalDigits: 2);

final pageController = PageController(viewportFraction: 0.8);
Color cor1 = Colors.grey;
Color cor2 = Colors.grey;
Color cor3 = Colors.grey;

bool _desativaBotao = false;

int opcao =0;

  @override
  Widget build(BuildContext context) {
    List<String> photos = [widget.relogio['foto1'],widget.relogio['foto2'],widget.relogio['foto3']];

    return Scaffold(
        drawer: dynamicDrawer(context),
        appBar: dynamicAppBar(context),

      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 16,right: 16),
        child: ListView(
          children: [
            ///Carousel
            Container(
              height: 270,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: PageView.builder(
                controller: pageController,
                  itemCount: photos.length,
                  itemBuilder: (context,index){
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(photos[index]),
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                  }
              ),
            ),

            const SizedBox(height: 20,),

            Center(child: Text(widget.relogio['nome'].toUpperCase(),style: const TextStyle(fontSize: 18),),),
            const SizedBox(height: 40,),

            const Center(child: Text("Opções disponíveis",style: TextStyle(fontSize: 18),),),
            const SizedBox(height: 20,),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            pageController.animateToPage(0, duration:const Duration(milliseconds: 400), curve: Curves.easeInOut);
                            cor1=Colors.blue;
                            cor2=Colors.grey;
                            cor3=Colors.grey;
                            _desativaBotao=true;
                            opcao=1;
                          });
                        },
                        child: Image.network(widget.relogio['foto1'],height: 100,),
                      ),
                      Icon(const IconData(0xe163,fontFamily: 'MaterialIcons'),color: cor1,size: 20,),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            pageController.animateToPage(1, duration:const Duration(milliseconds: 400), curve: Curves.easeInOut);
                            cor1=Colors.grey;
                            cor2=Colors.blue;
                            cor3=Colors.grey;
                            _desativaBotao=true;
                            opcao=2;
                          });
                        },
                        child: Image.network(widget.relogio['foto2'],height: 100,),
                      ),
                        Icon(const IconData(0xe163,fontFamily: 'MaterialIcons'),color: cor2,size: 20,),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            pageController.animateToPage(2, duration:const Duration(milliseconds: 400), curve: Curves.easeInOut);
                            cor1=Colors.grey;
                            cor2=Colors.grey;
                            cor3=Colors.blue;
                            _desativaBotao=true;
                            opcao=3;
                          });
                        },
                        child: Image.network(widget.relogio['foto3'],height: 100,),
                      ),
                      Icon(const IconData(0xe163,fontFamily: 'MaterialIcons'),color: cor3,size: 20,),
                    ],
                  ),
                ],
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Text(brl.format(widget.relogio['valor']),style: const TextStyle(fontSize: 28,color: Colors.green,fontWeight: FontWeight.bold),),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 25),
                ),
                onPressed: _desativaBotao? () {

                  String foto="foto$opcao";

                  SQLHelper.inserirCarrinho(widget.relogio['nome'], widget.relogio['valor'], widget.relogio['sobre'], widget.relogio[foto]);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Produto inserido no carrinho!")),
                  );

                } : () {
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Selecione uma opção!")),
                  );
                },
                child: const Text("Comprar"),
              ),
            ],),

            const SizedBox(height: 40,),

            Container(height: 2,color: Colors.black,),
            const SizedBox(height: 20,),
            const Text("Sobre",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
            const SizedBox(height: 20,),

            Text(widget.relogio['sobre']),
          ],),),
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
}