import 'package:flutter/material.dart';

class TailleVarianteWidget extends StatelessWidget {
  final List<String> tailles;
  final Function(String)? onSelectionChanged;

  TailleVarianteWidget({required this.tailles, this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sélectionnez la taille :'),
        Wrap(
          spacing: 8.0,
          children: tailles.map((taille) {
            return ChoiceChip(
              label: Text(taille),
              selected: tailles.indexOf(taille) == 0,
              onSelected: (selected) {
                if (onSelectionChanged != null && selected) {
                  onSelectionChanged!(taille);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class PointureVarianteWidget extends StatelessWidget {
  final List<String> pointures;
  final Function(String)? onSelectionChanged;

  PointureVarianteWidget({required this.pointures, this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sélectionnez la pointure :'),
        Wrap(
          spacing: 8.0,
          children: pointures.map((pointure) {
            return ChoiceChip(
              label: Text(pointure),
              selected: pointures.indexOf(pointure) == 0,
              onSelected: (selected) {
                if (onSelectionChanged != null && selected) {
                  onSelectionChanged!(pointure);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CouleurVarianteWidget extends StatelessWidget {
  final List<String> couleurs;
  final Function(String)? onSelectionChanged;

  CouleurVarianteWidget({required this.couleurs, this.onSelectionChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sélectionnez la couleur :'),
        Wrap(
          spacing: 8.0,
          children: couleurs.map((color) {
            return ChoiceChip(
              label: Text(color),
              selected: couleurs.indexOf(color) == 0,
              onSelected: (selected) {
                if (onSelectionChanged != null && selected) {
                  onSelectionChanged!(color);
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
