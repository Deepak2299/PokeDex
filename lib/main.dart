import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemonApp/pokemon_item.dart';
import 'dart:convert';
import 'dart:math';
import 'package:pokemonApp/pokemondetail.dart';

void main() => runApp(MaterialApp(title: 'PokeDex', home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokemonDetail pokemonDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    print("second work");
  }

  fetchData() async {
    var response = await http.get(url);
    var decodeJson = json.decode(response.body);
    pokemonDetail = PokemonDetail.fromJson(decodeJson);
    print(decodeJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PoKeDex'),
      ),
      body: pokemonDetail == null
          ? Center(child: CircularProgressIndicator())
          : GridView.count(
              crossAxisCount: 2,
              children: pokemonDetail.pokemon
                  .map((poke) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PokeDetail(pokemon: poke)));
                          },
                          child: Hero(
                            tag: poke.img,
                            flightShuttleBuilder: (
                              BuildContext flightContext,
                              Animation<double> animation,
                              HeroFlightDirection flightDirection,
                              BuildContext fromHeroContext,
                              BuildContext toHeroContext,
                            ) {
                              final Hero toHero = toHeroContext.widget;
                              return ScaleTransition(
                                scale: animation.drive(
                                  Tween<double>(begin: 0.0, end: 1.0).chain(
                                    CurveTween(
                                      curve: Interval(0.0, 1.0,
                                          curve: PeakQuadraticCurve()),
                                    ),
                                  ),
                                ),
                                child: flightDirection ==
                                        HeroFlightDirection.push
                                    ? RotationTransition(
                                        turns: animation,
                                        child: toHero.child,
                                      )
                                    : FadeTransition(
                                        opacity: animation.drive(
                                          Tween<double>(begin: 0.0, end: 1.0)
                                              .chain(
                                            CurveTween(
                                              curve: Interval(0.0, 1.0,
                                                  curve:
                                                      ValleyQuadraticCurve()),
                                            ),
                                          ),
                                        ),
                                        child: toHero.child,
                                      ),
                              );
                            },
                            child: Card(
                              elevation: 3,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(poke.img))),
                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class ValleyQuadraticCurve extends Curve {
  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    return 4 * pow(t - 0.5, 2);
  }
}

class PeakQuadraticCurve extends Curve {
  @override
  double transform(double t) {
    assert(t >= 0.0 && t <= 1.0);
    return -15 * pow(t, 2) + 15 * t + 1;
  }
}
