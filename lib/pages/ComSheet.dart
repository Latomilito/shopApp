import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';

class CommentBottomSheet extends StatefulWidget {
  @override
  State<CommentBottomSheet> createState() => _CommentBottomSheetState();
}

class _CommentBottomSheetState extends State<CommentBottomSheet> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          TextField(
            controller: textController,
            decoration: InputDecoration(
              hintText: 'Votre commentaire...',
            ),
          ),
          SizedBox(height: 16), // Espace ajouté entre le TextField et le bouton
          ElevatedButton(
            onPressed: () {
              // Logique pour traiter le commentaire ici
              print(textController.text);
              Navigator.pop(context);
            },
            child: Text('Envoyer'),
          ),
        ],
      ),
    );
  }
}

void showProductBottomSheet(BuildContext context) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) {
      return CommentBottomSheet();
    },
    isScrollControlled: true,
  );
}
