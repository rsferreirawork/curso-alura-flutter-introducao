import 'dart:convert';

import 'package:amamos_comida/modelos/receitas.dart';
import 'package:amamos_comida/telas/receita/detalhes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return _construirDashBoard();
  }

  Scaffold _construirDashBoard() {
    return Scaffold(
      body: _construirListaCard(),
      appBar: _construitAppBar(),
    );
  }

  Widget _construirListaCard() {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString("assets/data/receitas.json"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> receitas = json.decode(snapshot.data.toString());
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              Receita receita = Receita.fromJson(receitas[index]);
              return _construirCard(receita);
            },
            itemCount: receitas == null ? 0 : receitas.length,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Encontramos problemas para encontrar os dados'),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Card _construirCard(Receita receita) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => Detalhes(receita: receita,)
          ));
        },
        child: Container(
          height: 150,
          child: Stack(
            fit: StackFit.expand,
            children: _construirStackCard(receita.cardImage, receita.cardTitle),
          ),
        ),
      ),
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 1,
      margin: EdgeInsets.all(10),
    );
  }

  List<Widget> _construirStackCard(String srcImage, String texto) {
    return [
      _construirImagemCard(srcImage),
      _construirGradienteCard(),
      _contruirTextoCard(texto),
    ];
  }

  Widget _construirImagemCard(String srcImage) {
    return CachedNetworkImage(
      placeholder: (context, url) => LinearProgressIndicator(),
      imageUrl: srcImage,
      fit: BoxFit.cover,
    );
  }

  Container _construirGradienteCard() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
            Colors.transparent,
            Colors.deepOrange[900]!.withOpacity(0.8)
          ])),
    );
  }

  Positioned _contruirTextoCard(String texto) {
    return Positioned(
      bottom: 10,
      left: 10,
      child: Text(
        texto,
        style: GoogleFonts.bebasNeue(
            color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
      ),
    );
  }

  AppBar _construitAppBar() {
    return AppBar(
      title: Text('Receitas'),
    );
  }
}
