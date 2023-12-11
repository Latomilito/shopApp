// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';

// class viewProductPage extends StatefulWidget {
//   const viewProductPage({super.key});

//   @override
//   State<viewProductPage> createState() => _viewProductPageState();
// }

// class _viewProductPageState extends State<viewProductPage> {
//   PageController controller = PageController(initialPage: 0);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               icon: const Icon(
//                 Icons.arrow_back_ios,
//                 color: Colors.black,
//               )),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: PageView(
//                 controller: controller,
//                 onPageChanged: (indexx) {
//                   setState(() {
//                     _seletedindex = indexx;
//                   });
//                 },
//                 children: widget.produit.images!
//                     .map((e) => CachedNetworkImage(imageUrl: e))
//                     .toList(),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: widget.produit.images!.map((e) {
//                   int index = widget.produit.images!.indexOf(e);
//                   return GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _seletedindex = index;
//                         });
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 5),
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                                 width: 2,
//                                 color: _seletedindex == index
//                                     ? Colors.orange
//                                     : Colors.black)),
//                         height: 60,
//                         width: 60,
//                         child: Stack(
//                           children: [
//                             CachedNetworkImage(
//                               width: 60,
//                               height: 60,
//                               imageUrl: e,
//                               fit: BoxFit.fill,
//                               errorWidget: (context, url, error) =>
//                                   const SizedBox(),
//                             ),
//                           ],
//                         ),
//                       ));
//                 }).toList(),
//               ),
//             ),
//           ],
//         ));
//   }
// }
