import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class ProduitGridItem extends StatelessWidget {
  final List<String> image;
  final String nom;
  final double prix;
  final Function() onTap;
  final Function() onlongpressed;

  const ProduitGridItem({
    super.key,
    required this.image,
    required this.nom,
    required this.prix,
    required this.onTap,
    required this.onlongpressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onlongpressed,
      onTap: onTap,
      child: Container(
        // color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: image[0],
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         nom,
            //         style: GoogleFonts.acme(fontSize: 16, color: Colors.black),
            //       ),
            //       const SizedBox(height: 1),
            //       Text(
            //         '$prix FCFA',
            //         style: GoogleFonts.acme(fontSize: 12, color: Colors.grey),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
