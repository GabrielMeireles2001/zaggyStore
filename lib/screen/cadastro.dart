import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zaggyproject/screen/principal.dart';
import 'package:zaggyproject/screen/sobre.dart';
import '../database/db_helper.dart';


class Cadastro extends StatefulWidget{


  Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final tEmailUsuario = TextEditingController();

  final tEnderecoUsuario = TextEditingController();

  final tNomeUsuario = TextEditingController();

  final tSenhaUsuario = TextEditingController();

  final tLogradouro = TextEditingController();

  final tBairro = TextEditingController();

  final tNumero = TextEditingController();

  final tCidade = TextEditingController();

  final tEstado = TextEditingController();

  final tComplemento = TextEditingController();

  final tDDD = TextEditingController();

  final tTelefone = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? errorMessage = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: dynamicDrawer(context),
      appBar: dynamicAppBar(context),
      body: dynamicBody(context),
    );
  }

  dynamicBody(BuildContext context){
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            const Center(child: Text("Dados pessoais",style: TextStyle(fontSize: 18),),),
            const SizedBox(height: 40,),
            TextFormField(
              validator: (text){
                if(text!.isEmpty)return "Informe seu nome";

                return null;
              },
              controller: tNomeUsuario,
              decoration: const InputDecoration(
                labelText: "Nome",
                hintText: "Digite seu nome",
              ),
            ),
            const SizedBox(height: 10,),

            TextFormField(
              validator: (text){
                if(text!.isEmpty)return "Informe a senha";

                return null;
              },
              controller: tSenhaUsuario,
              decoration: const InputDecoration(
                labelText: "Senha",
                hintText: "Digite sua senha",
              ),
              obscureText: true,
            ),

            TextFormField(
              validator: (text){
                if(text!.isEmpty)return "Informe seu email";

                return null;
              },
              controller: tEmailUsuario,
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Digite seu email",
              ),
            ),

            const SizedBox(height: 80,),

            Container(height: 2,color: Colors.black,),
            const Center(child: Text("Endereço",style: TextStyle(fontSize: 18),),),
            const SizedBox(height: 40,),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text){
                    if(text!.isEmpty) {
                      return "Informe seu CEP";
                    } else if(text.length>8){
                      return "Digite apenas números";
                    }
                    else if(text.length<8) {
                      return "Digite os números do CEP";
                    }
                    else {
                      _recuperaCep();
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  controller: tEnderecoUsuario,
                  decoration: const InputDecoration(
                    labelText: "CEP",
                    hintText: "Digite seu CEP",
                  ),
            ),
            const SizedBox(height: 10,),

            TextFormField(
              validator: (text){
                if(text!.isEmpty)return "Informe seu Logradouro";

                return null;
              },
              controller: tLogradouro,
              decoration: const InputDecoration(
                labelText: "Logradouro",
                hintText: "Digite seu Logradouro",
              ),
            ),

            const SizedBox(height: 10,),

            TextFormField(
              validator: (text){
                if(text!.isEmpty)return "Informe o número";

                return null;
              },
              keyboardType: TextInputType.number,
              controller: tNumero,
              decoration: const InputDecoration(
                labelText: "Número",
                hintText: "Digite o número",
              ),
            ),

            const SizedBox(height: 10,),

            TextFormField(
              validator: (text){
                if(text!.isEmpty)return "Informe seu Bairro";

                return null;
              },
              controller: tBairro,
              decoration: const InputDecoration(
                labelText: "Bairro",
                hintText: "Digite seu Bairro",
              ),
            ),

            const SizedBox(height: 10,),

            TextFormField(
              validator: (text){
                if(text!.isEmpty)return "Informe a cidade";

                return null;
              },
              controller: tCidade,
              decoration: const InputDecoration(
                labelText: "Cidade",
                hintText: "Digite o nome da cidade",
              ),
            ),

            const SizedBox(height: 10,),

            TextFormField(
              validator: (text){
                if(text!.isEmpty) {
                  return "Informe o Estado";
                } else if(text.length>2) {
                  return "Informe apenas a sigla";
                }
                  return null;
              },
              controller: tEstado,
              decoration: const InputDecoration(
                labelText: "Estado",
                hintText: "Digite a sigla do estado",
              ),
            ),

            const SizedBox(height: 10,),

            TextFormField(
              controller: tComplemento,
              decoration: const InputDecoration(
                labelText: "Complemento",
                hintText: "Pontos de referência, bloco, dicas, etc",
              ),
            ),

            const SizedBox(height: 80,),

            Container(height: 2,color: Colors.black,),
            const Center(child: Text("Contato",style: TextStyle(fontSize: 18),),),

            const SizedBox(height: 40,),

            TextFormField(
              validator: (text){
                if(text!.isEmpty) {
                  return "Informe o telefone de contato";
                } else if(text.length>9){
                  return "Informe apenas números e sem DDD";
                }
                else if(text.length<9){
                  return "Informe o número completo e sem DDD";
                }
                else {
                  return null;
                }
              },
              keyboardType: TextInputType.number,
              controller: tTelefone,
              decoration: const InputDecoration(
                labelText: "Telefone",
                hintText: "Digite o seu número de telefone, sem DDD",
              ),
            ),

            const SizedBox(height: 10,),

            TextFormField(
              validator: (text){
                if(text!.isEmpty) {
                  return "Informe o DDD do telefone";
                } else if(text.length>2){
                  return "Informe apenas o DDD do telefone acima";
                }
                else if(text.length<2){
                  return "Informe o DDD do telefone acima";
                }
                else {
                  return null;
                }
              },
              keyboardType: TextInputType.number,
              controller: tDDD,
              decoration: const InputDecoration(
                labelText: "DDD",
                hintText: "Digite o DDD",
              ),
            ),



            const SizedBox(height: 20,),
            SizedBox(
              height: 46,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 30),
                ),
                child: const Text("Cadastrar"),

                onPressed: (){
                  bool formOk = _formKey.currentState!.validate();
                  if(! formOk){
                    return;
                  }

                 SQLHelper.inserirUsuario(tNomeUsuario.text, tEmailUsuario.text, tSenhaUsuario.text, tEnderecoUsuario.text, tLogradouro.text, tNumero.text, tBairro.text, tCidade.text, tEstado.text, tComplemento.text, tDDD.text, tTelefone.text);
                  SQLHelper.inserirUsuarioAtual(tNomeUsuario.text, tEmailUsuario.text, tSenhaUsuario.text, tEnderecoUsuario.text, tLogradouro.text, tNumero.text, tBairro.text, tCidade.text, tEstado.text, tComplemento.text, tDDD.text, tTelefone.text);


                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=> const Principal()),
                  );

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _recuperaCep() async{
    String cep = tEnderecoUsuario.text;
    var uri = Uri.parse("https://viacep.com.br/ws/$cep/json/");
    http.Response response;

    response = await http.get(uri);

    Map<String, dynamic> retorno = json.decode(response.body);

    tLogradouro.text = retorno["logradouro"];
    tCidade.text = retorno["localidade"];
    tBairro.text = retorno["bairro"];
    tEstado.text = retorno["uf"];
    tDDD.text = retorno["ddd"];



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
                      MaterialPageRoute(builder: (context)=> Sobre())
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
}

