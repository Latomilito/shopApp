import 'package:flutter/material.dart';

class PublicationActionsBottomSheet extends StatelessWidget {
  final Function()? onView;
  final Function()? askQuestion;
  final Function()? leaveComment;
  final Function()? share;
  final Function()? reserveOrOrder;

  PublicationActionsBottomSheet({
    this.onView,
    this.askQuestion,
    this.leaveComment,
    this.share,
    this.reserveOrOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          if (onView != null)
            ListTile(
              leading: Icon(Icons.remove_red_eye),
              title: Text('Voir'),
              onTap: onView,
            ),
          if (askQuestion != null)
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('Poser une Question'),
              onTap: askQuestion,
            ),
          if (leaveComment != null)
            ListTile(
              leading: Icon(Icons.comment),
              title: Text('Laisser un Commentaire'),
              onTap: leaveComment,
            ),
          if (share != null)
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Partager'),
              onTap: share,
            ),
          if (reserveOrOrder != null)
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Réserver/Commander'),
              onTap: reserveOrOrder,
            ),
        ],
      ),
    );
  }
}

// Utilisation dans une fonction pour afficher le BottomSheet
void showPublicationActionsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return PublicationActionsBottomSheet(
        onView: () {
          // Action à effectuer lorsqu'on clique sur "Voir"
          Navigator.pop(context); // Fermer le BottomSheet
        },
        askQuestion: () {
          // Action à effectuer lorsqu'on clique sur "Poser une Question"
          Navigator.pop(context); // Fermer le BottomSheet
        },
        leaveComment: () {
          // Action à effectuer lorsqu'on clique sur "Laisser un Commentaire"
          Navigator.pop(context); // Fermer le BottomSheet
        },
        share: () {
          // Action à effectuer lorsqu'on clique sur "Partager"
          Navigator.pop(context); // Fermer le BottomSheet
        },
        reserveOrOrder: () {
          // Action à effectuer lorsqu'on clique sur "Réserver/Commander"
          Navigator.pop(context); // Fermer le BottomSheet
        },
      );
    },
  );
}
