import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/controller/home/home_controller.dart';
import 'package:pokedex/model/colors.dart';
import 'package:pokedex/model/constants.dart';
import 'package:pokedex/model/home/pokemons_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (getX) {
        final _screenSize = MediaQuery.of(context).size;
        return Scaffold(
          body: Stack(
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
                top: 300,
                left: 0,
                right: 0,
                height: _screenSize.height * 0.7,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SafeArea(
                      bottom: true,
                      child: GetBuilder<HomeController>(
                        id: 'ListPokemons',
                        builder: (getX) {
                          if (getX.loading) {
                            return Swing(
                              infinite: true,
                              child: Center(
                                child: Image.asset(
                                  'assets/images/loading_pokedex_5.png',
                                  color: PokeDexColors.blue,
                                ),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ZoomIn(
                                child: Center(
                                  child: CarouselSlider.builder(
                                    carouselController: getX.carrouselController,
                                    itemCount: getX.pokemon?.results?.length,
                                    itemBuilder: (BuildContext context,
                                        int index, int pageViewIndex) {
                                      var collectionDataList =
                                          getX.pokemon?.results?.toList();
                                      var collec = collectionDataList![index];
                                      return _buildPokemon(
                                          context, collec, index + 1, getX);
                                    },
                                    options: CarouselOptions(
                                      height: _screenSize.height * 0.4,
                                      aspectRatio: 2.0,
                                      viewportFraction: 0.8,
                                      initialPage: 0,
                                      disableCenter: true,
                                      pageSnapping: true,
                                      enableInfiniteScroll: false,
                                      reverse: false,
                                      autoPlay: false,
                                      enlargeCenterPage: true,
                                      autoPlayCurve: Curves.bounceOut,
                                      onPageChanged: getX.onChangePokemon,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: 10,
                right: 10,
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/loading_pokedex_1.png',
                    alignment: Alignment.center,
                    //color: PokeDexColors.blue,
                  ),
                ),
              ),
              Positioned(
                top: 310,
                left: 10,
                right: 10,
                child: Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/loading_pokedex_6.png',
                    alignment: Alignment.center,
                    //color: PokeDexColors.blue,
                  ),
                ),
              ),
              Positioned(
                top: 200,
                left: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  width: double.infinity,
                  child: TextFormField(
                    //enabled: get.bloqueoCampoBusqueda,
                    onFieldSubmitted: (v) {
                      if (v.isEmpty) {
                        _mensajeSnackBar(context, 'Campo de busqueda vacio.');
                      } else {
                        getX.getBusqueda(v.trim().toUpperCase(),context);
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Buscar por nombre o id',
                      filled: true,
                      suffixIcon: const Icon(
                        Icons.search_outlined,
                        color: Colors.black,
                      ),
                      fillColor: Colors.grey,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPokemon(
      BuildContext context, Result result, int index, HomeController _) {
    final _screenSize = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        _.openDetail(index);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                '${WebService().baseURlImagePng}$index.png',
                height: _screenSize.height * 0.3,
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
              Text(
                '#$index   ${result.name}',
                style: Theme.of(context).primaryTextTheme.headline5!,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _mensajeSnackBar(BuildContext context,String? titulo){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        key: Key(titulo.toString()),
        content: Text(titulo.toString()),
        duration: const Duration(milliseconds: 5500),
        padding: const EdgeInsets.all(20),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
