import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/controller/detail/detail_controller.dart';
import 'package:pokedex/model/colors.dart';
import 'package:pokedex/model/constants.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<DetailController>(
      init: DetailController(),
      builder: (_) {
        return Scaffold(
          body: GetBuilder<DetailController>(
            id: 'Details',
            builder: (getX) {
              if (getX.error) {
                return Text(
                  'Ha ocurrido un error.',
                  style: Theme.of(context).primaryTextTheme.headline5!,
                  textAlign: TextAlign.start,
                );
              } else if (getX.loading) {
                return Swing(
                  infinite: true,
                  child: Center(
                    child: Image.asset(
                      'assets/images/loading_pokedex_5.png',
                      color: PokeDexColors.blue,
                    ),
                  ),
                );
              }
              return Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            PokeDexColors.blue,
                            PokeDexColors.yellow,
                          ],
                          stops: [
                            0.1,
                            0.8
                          ],
                          tileMode: TileMode.clamp,
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight),
                    ),
                  ),
                  Positioned(
                    top: 350,
                    left: 0,
                    right: 0,
                    height: 2000,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 70,
                            ),
                            Text(
                              'Informacion',
                              style:
                                  Theme.of(context).primaryTextTheme.subtitle1!,
                              textAlign: TextAlign.start,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    subtitle: Text(
                                        _.pokemonDetail!.weight.toString()),
                                    title: const Text('Weight'),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    subtitle: Text(
                                        _.pokemonDetail!.height.toString()),
                                    title: const Text('Height'),
                                  ),
                                ),
                              ],
                            ),
                            ListTile(
                              subtitle: Text(_.type.toString()),
                              title: const Text('Type'),
                            ),
                            ListTile(
                              subtitle: Text(_.species.toString()),
                              title: const Text('Species'),
                            ),
                            ListTile(
                              subtitle: Text(_.abilities.toString()),
                              title: const Text('Abilities'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: 10,
                    right: 10,
                    height: 300,
                    child: Image.network(
                      '${WebService().baseURlImagePng}${getX.idPokemon}.png',
                      fit: BoxFit.scaleDown,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Swing(
                          infinite: true,
                          child: Center(
                            heightFactor: 3,
                            child: Image.asset(
                              'assets/images/loading_pokedex_5.png',
                              color: PokeDexColors.blue,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 10,
                    right: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.clear_outlined,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          _.pokemonDetail!.name.toUpperCase(),
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline5!
                              .copyWith(fontSize: 35),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
