import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tcg_op/src/models/cards_data.dart';
import 'package:tcg_op/src/service/deck_data_service.dart';
import 'package:tcg_op/src/widgets/card_detail_widget.dart';

class DeckCreationWidget extends StatelessWidget {
  final List<CardsData> cards;

  const DeckCreationWidget({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Baraja')),
      body: GridView.builder(
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
          padding: const EdgeInsets.only(left: 15.0, right: 14.9),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => CardDetailWidget(card: card),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation, 
                      child: child);
                  },
                ),
              );
            },
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(bottom: 5.01, right: 20, top: 5, left: 4.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.3),
                  ),
                  
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: card.imgUrl!,
                        fit: BoxFit.contain,                    
                        width: 50,
                        height: 38.4,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error), 
                      ),
                    ],
                  ),                    
                ),
                ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final nameController = TextEditingController();
                    return AlertDialog(
                      title: const Text('Nombre de la Baraja'),
                      content: TextField(controller: nameController),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<DeckDataService>(context, listen: false).createDeck(nameController.text);
                            Navigator.pop(context);
                            Navigator.pop(context); // Volver a la pantalla anterior
                          },
                          child: const Text('Crear'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Crear Baraja'),
            ),
              ],
            ),
          ),
        );
      },
      )
    );}
    
  
}