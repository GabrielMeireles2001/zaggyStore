
import 'package:flutter/material.dart';
import 'package:zaggyproject/database/db_helper.dart';
import 'package:zaggyproject/screen/cadastro.dart';
import 'package:zaggyproject/screen/principal.dart';
import 'package:zaggyproject/screen/sobre.dart';




class Login extends StatefulWidget{

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final tLogin = TextEditingController();
  final tSenha = TextEditingController();

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
            TextFormField(
              validator: (text){
                if(text!.isEmpty)return "Informe o Login";

                return null;
              },
              controller: tLogin,
              decoration: const InputDecoration(
                labelText: "Login",
                hintText: "Digite o login",
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              validator: (text){
                if(text!.isEmpty)return "Informe a senha";

                return null;
              },
              controller: tSenha,
              decoration: const InputDecoration(
                labelText: "Senha",
                hintText: "Digite sua senha",
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: 46,
             child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 30),
                ),
                  child: const Text("Login"),

                  onPressed: () async {

                    bool formOk = _formKey.currentState!.validate();
                    if(! formOk){
                      return;
                    }

                    final _data = await SQLHelper.getAllUsers(tLogin.text,tSenha.text);

                    if(_data.length==1){

                      await SQLHelper.inserirUsuarioAtual(_data[0]['nome'], _data[0]['email'], _data[0]['senha'], _data[0]['cep'], _data[0]['logradouro'], _data[0]['numero'], _data[0]['bairro'], _data[0]['cidade'], _data[0]['estado'], _data[0]['complemento'], _data[0]['ddd'], _data[0]['telefone']);

                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const Principal())
                      );

                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Login ou senha incorreto!")),
                      );
                      return;
                    }

                    ///await SQLHelper.inserirUsuarioAtual(_data[0]['nome'], _data[0]['email'], _data[0]['senha'], _data[0]['cep'], _data[0]['logradouro'], _data[0]['numero'], _data[0]['bairro'], _data[0]['cidade'], _data[0]['estado'], _data[0]['complemento'], _data[0]['ddd'], _data[0]['telefone']);

                  },

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
                child: const Text("Cadastre-se"),

                onPressed: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=> Cadastro()),
                  );
                },
              ),
            ),
          ],
        ),
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
