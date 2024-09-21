import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_op/src/controllers/card_data_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tcg_op/src/models/cards_data.dart';
import 'package:tcg_op/src/widgets/filter_widget.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const routeName = 'HomeScreen';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int offset = 2;
  bool isFiltering = true;

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
              onPressed: () {},
              icon: const Icon(Icons.edit_square),
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
                  
                final cards = snapshot.data as List<CardsData>;
              
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    itemCount: cards.length,
                    itemBuilder: (context, index) 
                    {
                      final card = cards[index];
                  
                      return Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 25),
                        child: Card(
                          elevation: 5,
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: card.imgUrl!,
                                fit: BoxFit.contain,
                                
                                width: 220,
                                height: 190,
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error), 
                              ),
                            ],
                          ),                    
                        ),
                      );
                    },
                  );
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