
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class SQLHelper{

  static Future<void> criaTabela(sql.Database database) async{
    await database.execute("""CREATE TABLE carrinho(
          id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          nome TEXT,
          valor REAL,
          sobre TExT,
          foto1 TEXT,
          createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
          )
          """);

    await database.execute("""CREATE TABLE relogios(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    nome TEXT,
    valor REAL,
    sobre TExT,
    foto1 TEXT,
    foto2 TEXT,
    foto3 TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);

    await database.execute("""CREATE TABLE usuarios(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    nome TEXT,
    email TEXT,
    senha TEXT,
    cep TEXT,
    logradouro TEXT,
    numero TEXT,
    bairro TEXT,
    cidade TEXT,
    estado TEXT,
    complemento TEXT,
    ddd TEXT,
    telefone TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);

    await database.execute("""CREATE TABLE usuarioAtual(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    nome TEXT,
    email TEXT,
    senha TEXT,
    cep TEXT,
    logradouro TEXT,
    numero TEXT,
    bairro TEXT,
    cidade TEXT,
    estado TEXT,
    complemento TEXT,
    ddd TEXT,
    telefone TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )
    """);

    inserirRelogio("Pagani Design GMT Series", 720.00, """
MARCA:  Pagani Design
MODELO: PD-1662
MECANISMO:  Movimento automático
ESTILO:  Luxo, Casual
RESISTÊNCIA À ÁGUA: 100m à prova d'água, 10ATM
FECHO: Fecho dobrável com segurança
LARGURA DA PULSEIRA: 20mm
COMPRIMENTO PULSEIRA: 22cm ajustável
DIÂMETRO DO VISOR: 40mm
ESPESSURA DA CAIXA: 12.5mm
MATERIAL: Aço inoxidável
CARACTERÍSTICAS: GMT ( 2 Horarios diferentes) e Data
MATERIAL DO VISOR: Vidro safira 
PESO: 156g 
    """,
        "https://zaggystore.com.br/cdn/shop/products/PretoeAzulGMT_1024x1024.png?v=1653398928",
        "https://zaggystore.com.br/cdn/shop/products/AzuleVermelhoGMT_1024x1024.png?v=1653398928",
        "https://zaggystore.com.br/cdn/shop/products/PretoJubileeGMT_1024x1024.png?v=1653398928");

    inserirRelogio("Pagani Design Open Heart", 620.00, """
MARCA: Pagani Design
MODELO: PD-1736
MECANISMO: Movimento automático, Japan TMI NH39
ESTILO:  Luxo, Casual
RESISTÊNCIA À ÁGUA: À prova d'água, 20ATM
LARGURA DA PULSEIRA: 24mm
COMPRIMENTO PULSEIRA: 22cm ajustável
DIÂMETRO DO VISOR: 43mm
ESPESSURA DA CAIXA: 13mm
MATERIAL: Aço inoxidável/ Nylon
CARACTERÍSTICAS: Luminous
MATERIAL DO VISOR: Vidro cristal safira 
PESO: 100g 
    """,
        "https://zaggystore.com.br/cdn/shop/products/Sb2eb0337767c4bb8942cd1e45103757cL_c735b23d-08fa-4abf-8859-dea0d2c163fe_1024x1024.jpg?v=1665777058",
        "https://zaggystore.com.br/cdn/shop/products/Se724c2837ef14d05af153f1375b64998k_b983eac6-db58-44c5-b8eb-07b682be2122_1024x1024.jpg?v=1668028552",
        "https://zaggystore.com.br/cdn/shop/products/S880fe233e2ea4dd9b92b9c2aad787545b_969f5288-4650-4ece-925d-940709b4eef3_1024x1024.jpg?v=1668028552");

    inserirRelogio("Pagani Design PRX", 849.00, """
MARCA:  Pagani Design
MODELO: PD-1753
MECANISMO: Movimento automático NH35A
ESTILO: Luxo, Casual, Esportes
RESISTÊNCIA À ÁGUA: À prova d'água, 10ATM
LARGURA DA PULSEIRA: 15mm
COMPRIMENTO PULSEIRA: 23cm
DIÂMETRO DO VISOR: 40mm
ESPESSURA DA CAIXA: 12mm
MATERIAL: Aço inoxidável
MATERIAL DO VISOR: Vidro Cristal Safira 
    """, "https://zaggystore.com.br/cdn/shop/products/S59d21ff854264bd4ba59a5e959b11a1ev_42fa3e58-adb1-4c73-acee-557b8cd38c65_1024x1024.jpg?v=1682128406",
        "https://zaggystore.com.br/cdn/shop/products/Sead5ec4e31214994a7a09e24d54c695a9_1024x1024.jpg?v=1682128406",
        "https://zaggystore.com.br/cdn/shop/products/S8a9561fec1b747c7aa87bd0fd8669692L_418835d3-7ac7-4a28-85e5-6f6897fda0df_1024x1024.jpg?v=1682128406");
    
    inserirRelogio("Pagani Design Speedmaster 57'", 770.00, """
MARCA:  Pagani Design
MODELO: PD-1766
MECANISMO: Movimento Quartz, Máquina Japan Seiko VK64
ESTILO: Luxo, Casual, Esportes
RESISTÊNCIA À ÁGUA: 100m à prova d'água, 10ATM
LARGURA DA PULSEIRA: 20mm
COMPRIMENTO PULSEIRA: 20cm
DIÂMETRO DO VISOR: 40mm
ESPESSURA DA CAIXA: 13mm
MATERIAL: Aço inoxidável
MATERIAL DO VISOR: Vidro Cristal Safira 
PESO: 140g
    """,
        "https://zaggystore.com.br/cdn/shop/files/Ab00dd93e75a34e848561841e72095c525_9587fd41-55de-4e6b-89cb-87b26dbde2e4_1024x1024.jpg?v=1685810947",
        "https://zaggystore.com.br/cdn/shop/files/A667af8430d2e478ab40f0bf632ce5d4fZ_17b141cb-d4a7-49b0-8dcf-c41430769de0_1024x1024.jpg?v=1685811570",
        "https://zaggystore.com.br/cdn/shop/files/Adcb0e4626130459d990622c42851fcc2s_85a51eb8-7218-4b66-a744-6c010dd4ca1c_1024x1024.jpg?v=1685811570");
    
    inserirRelogio("Benyar Business Leather", 390.00, """
MARCA:  Benyar
MODELO: BY-5187
MECANISMO:  Movimento à Bateria
ESTILO:  Luxo, Casual, Sport
RESISTÊNCIA À ÁGUA: 10atm 
FECHO: Fivela
LARGURA DA PULSEIRA: 22mm
COMPRIMENTO PULSEIRA: 25cm ajustável
DIÂMETRO DO VISOR: 42mm
ESPESSURA DA CAIXA: 13mm
MATERIAL: Aço inoxidável e Pulseira de Couro
CARACTERÍSTICAS: Cronógrafo e Data
MATERIAL DO VISOR: Vidro Hardlex  
PESO: 62g
    """,
        "https://zaggystore.com.br/cdn/shop/products/Pretoedourado_1024x1024.jpg?v=1651363985",
        "https://zaggystore.com.br/cdn/shop/products/Pretoepratapulseiramarrom_1024x1024.jpg?v=1651669624",
        "https://zaggystore.com.br/cdn/shop/products/Brancoepratapulseiramarrom2_1024x1024.jpg?v=1651669624");
    
    inserirRelogio("Pagani Design Daytona Rubber", 680.00, """
MARCA:  Pagani Design
MODELO: PD-1644
MECANISMO: Movimento Quartz
ESTILO: Luxo, Casual, Esportes
RESISTÊNCIA À ÁGUA: 10atm à prova d´água
FECHO: Fecho dobrável com segurança
LARGURA DA PULSEIRA: 20mm
COMPRIMENTO PULSEIRA: 22cm ajustável
DIÂMETRO DO VISOR: 40mm
ESPESSURA DA CAIXA: 12mm
MATERIAL: Aço inoxidável e pulseira de borracha
CARACTERÍSTICAS: Data, Cronógrafo
MATERIAL DO VISOR: Vidro Safira
PESO: 135g
    """,
        "https://zaggystore.com.br/cdn/shop/products/H75b3c866559e439a80dcdecbca203c51P_4fb9421a-19e9-473f-b9c6-b333b66ad6ac_1024x1024.jpg?v=1660181159",
        "https://zaggystore.com.br/cdn/shop/products/H92d2cb1e1c304220a12533b3df152325k_1024x1024.jpg?v=1660181159",
        "https://zaggystore.com.br/cdn/shop/products/H1e7480588ff34613a88d9f99e1b2db68F_1024x1024.jpg?v=1652743941");
    
    inserirRelogio("Pagani Design Pilot", 480.00, """
MARCA:  Pagani Design
MODELO: PD-1654
MECANISMO:  Movimento à bateria, Máquina Japan Seiko Vk64
ESTILO:  Luxo, Casual
RESISTÊNCIA À ÁGUA: 10atm, 100m á prova d`'agua
FECHO: Fecho fivela 
LARGURA DA PULSEIRA: 20mm
COMPRIMENTO PULSEIRA: 24cm ajustável
DIÂMETRO DO VISOR: 40mm
ESPESSURA DA CAIXA: 11mm
MATERIAL: Aço inoxidável e Pulseira de Couro
CARACTERÍSTICAS:  Data
MATERIAL DO VISOR: Vidro Cristal Safira 
PESO: 49g 
    """,
        "https://zaggystore.com.br/cdn/shop/products/PAGANIDESIGNPILOT_1024x1024.png?v=1652021398",
        "https://zaggystore.com.br/cdn/shop/products/paganipretosilver_1024x1024.png?v=1652021398",
        "https://zaggystore.com.br/cdn/shop/products/paganidesigntbrancodourado_1024x1024.png?v=1652021398");

    inserirRelogio("Benyar Luminous Clock", 380.00, """
MARCA: Benyar
MODELO: BY-5190
MECANISMO: Movimento quartz
ESTILO: Casual, Sport
RESISTÊNCIA À ÁGUA: À prova d'água, 3atm
FECHO: Fivela
LARGURA DA PULSEIRA: 22mm
COMPRIMENTO PULSEIRA: 22cm 
DIÂMETRO DO VISOR: 42mm
ESPESSURA DA CAIXA: 14mm
MATERIAL: Aço inoxidável, Pulseira de Couro ou Nato
CARACTERÍSTICAS: Cronógrafo, Data, Luminous 
MATERIAL DO VISOR: Vidro Hardlex  
PESO: 60g

    """,
        "https://zaggystore.com.br/cdn/shop/products/S9e42cddd53be489ea9a5dbf9410c5f2am_c4178039-93d6-4cea-b438-efd86d0d251a_1024x1024.jpg?v=1659387999",
        "https://zaggystore.com.br/cdn/shop/products/S57ee94cc5756473b833c888bef109a62h_0f4ae56d-0c25-4949-b579-6b3263b2abb4_1024x1024.jpg?v=1659387999",
        "https://zaggystore.com.br/cdn/shop/products/S120cd4cd02e74713b8f9d82b369ec54fa_50874cc4-0245-4a25-8951-79e4f53b64f8_1024x1024.jpg?v=1659388130");

    inserirRelogio("Pagani Design Submariner GOLD Edition", 790.00, """
MARCA:  Pagani Design
MODELO: PD-1661
MECANISMO:  Movimento automático, Máquina Seiko NH35
ESTILO:  Luxo, Casual
RESISTÊNCIA À ÁGUA: 100m à prova d'água, 10ATM
FECHO: Fecho dobrável com segurança
LARGURA DA PULSEIRA: 20mm
COMPRIMENTO PULSEIRA: 22cm ajustável
DIÂMETRO DO VISOR: 40mm
ESPESSURA DA CAIXA: 13mm
MATERIAL: Aço inoxidável 
CARACTERÍSTICAS: Data
MATERIAL DO VISOR: Vidro safira 
PESO: 152g
    """,
        "https://zaggystore.com.br/cdn/shop/products/GOLDSUBMARINERPRETO_1024x1024.png?v=1652059291",
        "https://zaggystore.com.br/cdn/shop/products/submarinergoldazul_1024x1024.png?v=1652059291",
        "https://zaggystore.com.br/cdn/shop/products/submarinergoldverde_1024x1024.png?v=1652059291");
    
    inserirRelogio("Pagani Design Datejust Jubilee", 750.00, """
MARCA:  Pagani Design
MODELO: PD-1645
MECANISMO:  Movimento Automático, Máquina Seiko NH35 Movement
ESTILO:  Luxo, Casual, Negócios
RESISTÊNCIA À ÁGUA: 100m à prova d'água, 10ATM
FECHO: Fecho dobrável com segurança
LARGURA DA PULSEIRA: 20mm
COMPRIMENTO PULSEIRA: 22cm ajustável
DIÂMETRO DO VISOR: 40mm
ESPESSURA DA CAIXA: 12mm
MATERIAL: Aço inoxidável
CARACTERÍSTICAS: Data
MATERIAL DO VISOR: Vidro Cristal Safira
PESO: 143g
    """, "https://zaggystore.com.br/cdn/shop/products/H7e05b7032b4d42d59811adeac209e9b0R_1024x1024.jpg?v=1653574064",
        "https://zaggystore.com.br/cdn/shop/products/H243df8f97b3f4a7fa5e7c04a89ba42a47_1024x1024.jpg?v=1653574064",
        "https://zaggystore.com.br/cdn/shop/products/H6736c1d6a7cc427796a24b46fafff181d_1024x1024.jpg?v=1653573789");
    
    inserirRelogio("Pagani Design Chronomat Homage", 760.00, """
MARCA:  Pagani Design
MODELO: PD-17058
MECANISMO: Movimento Quartz, Máquina Seiko VK64
ESTILO: Luxo, Casual, Esportes
RESISTÊNCIA À ÁGUA: À prova d'água, 10ATM
LARGURA DA PULSEIRA: 20mm
COMPRIMENTO PULSEIRA: 22cm
DIÂMETRO DO VISOR: 42mm
ESPESSURA DA CAIXA: 12mm
MATERIAL: Aço inoxidável
CARACTERÍSTICAS: Cronógrafo, Luminous
MATERIAL DO VISOR: Vidro Cristal Safira 
PESO: 195g
    """, "https://zaggystore.com.br/cdn/shop/products/Sf5c59fcc1ab047ca87a7ee3ad2e75e91X_1024x1024.jpg?v=1680887984",
        "https://zaggystore.com.br/cdn/shop/products/S4b78f91930a9430798eca744bd0462149_1024x1024.jpg?v=1680887984",
        "https://zaggystore.com.br/cdn/shop/products/S76d34495e6bf4a52ac82e168ea64da9dc_1024x1024.jpg?v=1680887984");
    

  }

  static Future<Database> db() async {
    return sql.openDatabase(
      'produtos.db',
      version: 1,
      onCreate: (sql.Database database,version)async{
          await criaTabela(database);
      },
    );
  }

  //INSERIR RELOGIO
  static Future inserirRelogio(String nome,double valor,String sobre,String foto1,String foto2, String foto3) async{
      final db = await SQLHelper.db();

      final data = {'nome': nome,'valor':valor,'sobre': sobre,'foto1': foto1, 'foto2': foto2,'foto3': foto3};

      await db.insert('relogios',data, conflictAlgorithm: sql.ConflictAlgorithm.replace);

  }

  //INSERIR RELOGIO carrinho
  static Future inserirCarrinho(String nome,double valor,String sobre,String foto1) async{
    final db = await SQLHelper.db();

    final data = {'nome': nome,'valor':valor,'sobre': sobre,'foto1': foto1};

    await db.insert('carrinho',data, conflictAlgorithm: sql.ConflictAlgorithm.replace);

  }

  //INSERIR USUARIOS
  static Future inserirUsuario(String nome,String email,String senha,String cep,String logradouro,String numero,String bairro,String cidade,String estado,String complemento,String DDD,String telefone) async{
    final db = await SQLHelper.db();

    final data = {'nome':nome,'email':email,'senha':senha,'cep':cep,'logradouro':logradouro,'numero':numero,'bairro':bairro,'cidade':cidade,'estado':estado,'complemento':complemento,'ddd':DDD,'telefone':telefone};

    await db.insert('usuarios',data, conflictAlgorithm: sql.ConflictAlgorithm.replace);

  }

  //login atual
  static Future inserirUsuarioAtual(String nome,String email,String senha,String cep,String logradouro,String numero,String bairro,String cidade,String estado,String complemento,String DDD,String telefone) async{
    final db = await SQLHelper.db();

    final data = {'nome':nome,'email':email,'senha':senha,'cep':cep,'logradouro':logradouro,'numero':numero,'bairro':bairro,'cidade':cidade,'estado':estado,'complemento':complemento,'ddd':DDD,'telefone':telefone};

    await db.insert('usuarioAtual',data, conflictAlgorithm: sql.ConflictAlgorithm.replace);

  }

  //logoff
  static Future removerUsuarioAtual(String nome,String email,String senha,String cep,String logradouro,String numero,String bairro,String cidade,String estado,String complemento,String DDD,String telefone) async{
    final db = await SQLHelper.db();

    final data = {'nome':nome,'email':email,'senha':senha,'cep':cep,'logradouro':logradouro,'numero':numero,'bairro':bairro,'cidade':cidade,'estado':estado,'complemento':complemento,'ddd':DDD,'telefone':telefone};

    await db.rawDelete('DELETE FROM usuarioAtual WHERE id = 1');

  }


  static Future<List<Map<String, dynamic>>> getAllUsers(String email,String senha) async{
    final db = await SQLHelper.db();
    return db.query('usuarios', where: 'email=? AND senha=?',whereArgs: [email,senha]);
  }

  static Future<List<Map<String, dynamic>>> getCurrentUser() async{
    final db = await SQLHelper.db();
    return db.query('usuarioAtual', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getAllRelogio() async{
    final db = await SQLHelper.db();
    return db.query('relogios', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getCarrinho() async{
    final db = await SQLHelper.db();
    return db.query('carrinho', orderBy: "id");
  }

  static Future<void> apagaProduto(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("carrinho", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Erro ao apagar o item item: $err");
    }
  }

  static Future<void> apagaUsuario(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("usuarioAtual", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Erro ao apagar o item item: $err");
    }
  }

  static void deletaBanco() async{
    sql.deleteDatabase('produtos.db');
  }


}