class Receita {
  late String _cardImage;
  late String _cardTitle;
  late String _title;
  late String _image;
  late int _tempo;
  late int _rendimento;
  late List<String> _ingredientes;
  late List<String> _preparo;
  late String _informacoesAdicionais;

  Receita(
      {required String cardImage,
        required String cardTitle,
        required String title,
        required String image,
        required int tempo,
        required int rendimento,
        required List<String> ingredientes,
        required List<String> preparo,
        String? informacoesAdicionais}) {
    this._cardImage = cardImage;
    this._cardTitle = cardTitle;
    this._title = title;
    this._image = image;
    this._tempo = tempo;
    this._rendimento = rendimento;
    this._ingredientes = ingredientes;
    this._preparo = preparo;
    this._informacoesAdicionais = informacoesAdicionais!;
  }

  String get cardImage => _cardImage;
  set cardImage(String cardImage) => _cardImage = cardImage;
  String get cardTitle => _cardTitle;
  set cardTitle(String cardTitle) => _cardTitle = cardTitle;
  String get title => _title;
  set title(String title) => _title = title;
  String get image => _image;
  set image(String image) => _image = image;
  int get tempo => _tempo;
  set tempo(int tempo) => _tempo = tempo;
  int get rendimento => _rendimento;
  set rendimento(int rendimento) => _rendimento = rendimento;
  List<String> get ingredientes => _ingredientes;
  set ingredientes(List<String> ingredientes) => _ingredientes = ingredientes;
  List<String> get preparo => _preparo;
  set preparo(List<String> preparo) => _preparo = preparo;
  String get informacoesAdicionais => _informacoesAdicionais;
  set informacoesAdicionais(String informacoesAdicionais) =>
      _informacoesAdicionais = informacoesAdicionais;

  Receita.fromJson(Map<String, dynamic> json) {
    _cardImage = json['cardImage'];
    _cardTitle = json['cardTitle'];
    _title = json['title'];
    _image = json['image'];
    _tempo = json['tempo'];
    _rendimento = json['rendimento'];
    _ingredientes = json['ingredientes'].cast<String>();
    _preparo = json['preparo'].cast<String>();
    _informacoesAdicionais = json['informacoes_adicionais'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardImage'] = this._cardImage;
    data['cardTitle'] = this._cardTitle;
    data['title'] = this._title;
    data['image'] = this._image;
    data['tempo'] = this._tempo;
    data['rendimento'] = this._rendimento;
    data['ingredientes'] = this._ingredientes;
    data['preparo'] = this._preparo;
    data['informacoes_adicionais'] = this._informacoesAdicionais;
    return data;
  }
}
