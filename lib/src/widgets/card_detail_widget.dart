import 'package:flutter/material.dart';
import 'package:tcg_op/src/models/cards_data.dart';

class CardDetailWidget extends StatefulWidget {
  const CardDetailWidget({super.key, required this.card});
  final CardsData card;

  @override
  State<CardDetailWidget> createState() => _CardDetailWidgetState();
}

class _CardDetailWidgetState extends State<CardDetailWidget> {

  void _handleTap() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.card.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: GestureDetector(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10.0,),
              Center(
                child: Text(
                   widget.card.cardSet == null ? widget.card.name! : widget.card.cardSet!,
                   style: const TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.bold,
                     color: Colors.black,
                   ),),
              ),
              GestureDetector(
                onTap: _handleTap,
                child: Hero(
                  tag: widget.card.id,
                  //padding: const EdgeInsets.only(top: 10.0),
                  child: Image.network(widget.card.imgUrl!),
                ),
              ),
              const SizedBox(height: 10.0,),
            
            ],
          ),
        ),
      ),
    );
  }
}