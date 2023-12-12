import 'package:flutter/material.dart';
import 'package:zaggyproject/screen/principal.dart';

import 'login.dart';

class Sobre extends StatelessWidget{
  const Sobre({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: dynamicDrawer(context),
      appBar: dynamicAppBar(context),

      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text('Sobre nós: '),
            ),
            Text(" Olá, prezado amigo(a)!\n\nQueremos te agradecer por estar aqui conhecendo nossa loja 😄\n\n A Zaggy Store é uma loja totalmente online especializada em atender o cotidiano de pessoas modernas, com relógios revolucionários e de alta qualidade. Nossa principal missão é fornecer aos nossos clientes as melhores e maiores ofertas do mercado, com produtos que possuem qualidade e segurança através do contato que temos com muitos fabricantes fora do país. Oferecemos essa oportunidade a você, futuro cliente, de poder adquirir produtos de ponta com o melhor preço do mercado.\n\nVocês, clientes, são o nosso foco principal, e por isso, somos sempre transparentes, diretos e verdadeiros. Acreditamos que o comprometimento é o que constrói nossa reputação a cada dia e nos dá tanta credibilidade. Sentimo-nos honrados em poder servi-los, lhe proporcionar a melhor experiência na hora da compra e garantia de satisfação. Agir de forma honesta e transparente é o nosso principal diferencial.\n\nA Zaggy Store é composta por uma equipe disposta e atenciosa. Trabalhamos diariamente para oferecer a você uma grande variedade de produtos que acompanham as últimas tendências do mundo. Possuímos um excelente serviço de atendimento, o que permite a aproximação total do cliente ao produto desejado.\n\nQualquer dúvida entre em contato conosco: suporte@zaggystore.com.br\n\nTeremos muito prazer em te atender e ajudar.\n\nUm abraço, equipe Zaggy Store .\n\n😄"),
          ],
        ),
        ),
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
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=> Login()),
              );
            },
          ),



          //Cart icon
          IconButton(
            icon: const Icon(IconData(0xe759, fontFamily: 'MaterialIcons')),
            iconSize: 30,
            onPressed: () {  },),

        ],
      ),
    );
  }

}