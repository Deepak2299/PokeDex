import 'package:flutter/material.dart';
import 'package:pokemonApp/pokemondetail.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetail({this.pokemon});
  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.4,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.15,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    pokemon.name,
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                  Text("Height: ${pokemon.height}"),
                  Text("Weight: ${pokemon.weight}"),
                  Text(
                    "Types",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.type
                        .map((t) =>
                            FilterChip(label: Text(t), onSelected: (b) {}))
                        .toList(),
                  ),
                  Text(
                    "Weakness",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: pokemon.weaknesses
                        .map((t) =>
                            FilterChip(label: Text(t), onSelected: (b) {}))
                        .toList(),
                  ),
                  pokemon.nextEvolution == null
                      ? Container()
                      : Text(
                          "Next Evalution",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                  pokemon.nextEvolution == null
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: pokemon.nextEvolution
                              .map((n) => FilterChip(
                                  label: Text(n.name), onSelected: (b) {}))
                              .toList(),
                        ),
                  pokemon.prevEvolution == null
                      ? Container()
                      : Text(
                          "Prev Evalution",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                  pokemon.prevEvolution == null
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: pokemon.prevEvolution
                              .map((n) => FilterChip(
                                  label: Text(n.name), onSelected: (b) {}))
                              .toList(),
                        ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
                transitionOnUserGestures: true,
                tag: pokemon.img,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(pokemon.img))),
                )),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text(pokemon.name),
        backgroundColor: Colors.cyan,
        elevation: 0,
      ),
      body: bodyWidget(context),
    );
  }
}
