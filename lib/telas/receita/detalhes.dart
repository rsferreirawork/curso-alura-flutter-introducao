import 'package:amamos_comida/modelos/receitas.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Detalhes extends StatelessWidget {
  final Receita receita;

  Detalhes({Key? key, required this.receita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _construirPagina(this.receita, context),
    );
  }

  Widget _construirPagina(Receita receita, BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        _construitAppBar(receita),
        _construirDetalhes(receita, context),
      ],
    );
  }

  SliverToBoxAdapter _construirDetalhes(Receita receita, BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _construirResumoCard(receita, context),
          _construirIngredientes(receita, context),
          _construirPreparo(receita, context),
          _construirInformacoesAdicionais(receita,context),
        ],
      ),
    );
  }

  SliverAppBar _construitAppBar(Receita receita) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Stack(
          fit: StackFit.expand,
          children: [
            _construirImagemBar(receita.image),
            _construirGradienteCard(),
          ],
        ),
        title: Text(receita.title),
      ),
    );
  }

  Container _construirGradienteCard() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
            Colors.deepOrange.withOpacity(0.8),
            Colors.transparent,
          ])),
    );
  }

  CachedNetworkImage _construirImagemBar(String srcImage) {
    return CachedNetworkImage(
      placeholder: (context, url) => LinearProgressIndicator(),
      imageUrl: srcImage,
      fit: BoxFit.cover,
    );
  }

  Card _construirResumoCard(Receita receita, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: _construirResumo(context, Icons.access_alarm, "Preparo",
                  "${receita.tempo.toString()} min"),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _construirResumo(context, Icons.restaurant, "Rendimento",
                      "${receita.rendimento.toString()} Porções")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _construirResumo(
      BuildContext context, IconData icon, String tipo, String detalhe) {
    return Column(
      children: [
        Icon(icon),
        Text(
          tipo.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor),
        ),
        Text(detalhe)
      ],
    );
  }

  Card _construirIngredientes(Receita receita, BuildContext context) {
    return Card(
      child: Column(
        children: [
          _construirTituloCard(context, "Ingredientes", Icons.restaurant_menu),
          _construirCardWithList(receita.ingredientes),
        ],
      ),
    );
  }

  Container _construirTituloCard(BuildContext context, String titulo, IconData icon) {
    return Container(
          padding: EdgeInsets.only(top: 10),
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(padding: EdgeInsets.only(right: 5), child: Icon(icon,color: Theme.of(context).accentColor,)),
            Text(
              titulo.toUpperCase(),
              style: TextStyle(color: Theme.of(context).accentColor,fontSize: 15),
            )
          ],
        ));
  }

  Card _construirPreparo(Receita receita, BuildContext context) {
    return Card(
      child: Column(
        children: [
          _construirTituloCard(context, "Modo de Preparo", Icons.whatshot_rounded),
          _construirCardWithList(receita.preparo),
        ],
      ),
    );
  }

  Card _construirInformacoesAdicionais(Receita receita, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            _construirTituloCard(context, "Informações Adicionais", Icons.info_outline),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: _construirCardInformacoesAdicionais(
                          receita.informacoesAdicionais)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirCardInformacoesAdicionais(String informacoesAdicionais) {
    switch (informacoesAdicionais != null) {
      case true:
        return Text(informacoesAdicionais);
      default:
        return Text("Não encontrei informações adicionais");
    }
  }

  ListView _construirCardWithList(List<String> list) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              children: [
                Icon(Icons.arrow_right_outlined),
                Expanded(child: Text(list[index]))
              ],
            ),
          );
        });
  }
}
