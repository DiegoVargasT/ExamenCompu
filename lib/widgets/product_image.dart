import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  
  final String? url;
  const ProductImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Container(
          decoration: _createDecoration(),
          width: double.infinity,
          height: 400,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: url == null
                ? const Image(
                    image: AssetImage('assets/no-image.png'),
                    fit: BoxFit.cover,
                  )
                : FadeInImage.assetNetwork(
                    placeholder: '/assets/loading.png',
                    image: url as String
                  ),
          )),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        offset: Offset(0, 5),
        blurRadius: 10,
      )
   ]);
}