import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_op/src/controllers/card_data_controller.dart';
import 'package:tcg_op/src/models/cards_data.dart';
import 'package:tcg_op/src/service/deck_data_service.dart';
import 'package:tcg_op/src/widgets/card_list_widget.dart';
import 'package:tcg_op/src/widgets/deck_creation_widget.dart';
import 'package:tcg_op/src/widgets/filter_widget.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = 'HomeScreen';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int offset = 2;
  bool isFiltering = false;

  @override
  void initState() {
    fetchTCGAPI();
    super.initState();
  }

  void showFilters() {
    setState(() {
      isFiltering = !isFiltering;
    });
  }

  Future<void> fetchTCGAPI () async{
    await Provider.of<CardDataController>(context, listen: false)
      .getAllCards(offset);
  }

  

  Future<void> onApplyFilters(List<String> colorFilter, double costFilter, double powerFilter, String codeFilter, String nameFilter) async{
    final cardDataController = Provider.of<CardDataController>(context, listen: false);
    cardDataController.colorFilter = colorFilter.join();
    cardDataController.costFilter = costFilter.toInt();
    cardDataController.powerFilter = powerFilter.toInt();
    cardDataController.codeFilter = codeFilter;
    cardDataController.nameFilter = nameFilter;
  }
  
  @override
  Widget build(BuildContext context) {

    final cardDataController = Provider.of<CardDataController>(context);
    
  
    return ChangeNotifierProvider(
      create: (_) => CardDataController(),
      child: Consumer<CardDataController>(
        builder: (context, controller, child) {
          return Scaffold(
    
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('TCG One Piece'),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isFiltering = !isFiltering;
                });
              },
              icon: const Icon(Icons.search),
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => DeckDataService(),
                      child: DeckCreationWidget(cards: cardDataController.cardsDataList),),
                  ),
                );
              },
              icon: const Icon(Icons.create),
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person_2_sharp),
              color: Colors.black,
            )
          ],
        ),
        body: Column(
          children: [
            if(isFiltering) FilterWidget(onApplyFilters: onApplyFilters),
            Expanded(
              child: FutureBuilder<void>( 
                future: cardDataController.getAllCards(offset),
                builder:(context, snapshot) {
                  if(snapshot.hasError){
                    return const Center(child: Text('Error: &{snapshot.error}'));
                  }              
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }    
                  // if(snapshot.connectionState == ConnectionState.waiting)
                  // {
                  //   return const Center(child: CircularProgressIndicator());
                  // }else{
                  //   final cards = snapshot.data as List<CardsData>;
                  //   return CardListWidget(cards: cards);
                  // }           
                final cards = snapshot.data as List<CardsData>;
               return CardListWidget(cards: cards);
                },
              ),
            ),
          ],
        ),
      );
      },),
    );
  }


}