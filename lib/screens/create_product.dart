import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_form_provider.dart';
import '../services/product_service.dart';
import '../widgets/inputs_color.dart';
import '../widgets/product_image.dart';

class CreateProductScreen extends StatelessWidget {
  const CreateProductScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectProduct!),
      child: _ProductScreenBody(
        productService: productService,
      )
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductService productService;
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              ProductImage(
                url: productService.selectProduct!.productImage,
              ),
              Positioned(
                top: 40,
                left: 20,
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 40,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
          _ProductForm(),
        ]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              if (!productForm.isValidForm()) return;
              await productService.deleteProduct(productForm.product, context);
            },
            heroTag: null,
          ),

          const SizedBox(width: 20),
          FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () async {
              if (!productForm.isValidForm()) return;
              await productService.editOrCreateProduct(productForm.product);
            },
            heroTag: null,

          ),
        ],
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    bool switchValue = product.productState == "Activo";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        decoration: _createDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                initialValue: product.productName,
                onChanged: (value) => product.productName = value,
                validator: (value) {
                  if (value == null || value.length < 1) {
                    return 'Nombre obligatorio';
                  }
                },
                decoration: InputColor.inputDecoration(
                  hinText: 'Nombre producto',
                  labelText: 'Nombre',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: product.productPrice.toString(),
                onChanged: (value) {
                  if (int.tryParse(value) == null) {
                    product.productPrice = 0;
                  } else {
                    product.productPrice = int.parse(value);
                  }
                },
                decoration: InputColor.inputDecoration(
                  hinText: '----',
                  labelText: 'Precio',
                ),
              ),
              const SizedBox(height: 20),
              SwitchListTile.adaptive(
                value: switchValue,
                onChanged: (value) {
                  product.productState = value == true ? 'Activo': 'Inactivo';
                  switchValue = value;
                },
                activeColor: Colors.blue,
                title: const Text('Disponible'),
              )
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _createDecoration() => const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15)),
      boxShadow: [
        BoxShadow(
          color: Colors.blue,
          offset: Offset(0, 5),
          blurRadius: 10,
        )
      ]);
}