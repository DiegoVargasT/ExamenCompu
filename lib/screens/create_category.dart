import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/category_service.dart';
import '../providers/category_form_provider.dart';
import '../widgets/inputs_color.dart';

class CreateCategoryScreen extends StatelessWidget {
  const CreateCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    return ChangeNotifierProvider(
        create: (_) => CategoryFormProvider(categoryService.selectCategory!),
        child: _CategoryScreenBody(
          categoryService: categoryService,
        ));
  }
}

class _CategoryScreenBody extends StatelessWidget {
  const _CategoryScreenBody({
    Key? key,
    required this.categoryService,
  }) : super(key: key);

  final CategoryService categoryService;
  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryFormProvider>(context);
    final isUpdating = categoryForm.category.categoryId == 0;

    List<Widget> actionsButtons = [
      FloatingActionButton(
        onPressed: () async {
          if (!categoryForm.isValidForm()) return;
          await categoryService.deleteCategory(categoryForm.category, context);
        },
        heroTag: null,
        tooltip: "Eliminar",
        child: const Icon(Icons.delete_forever),
      ),
      const SizedBox(width: 20)
    ];
    if (isUpdating) {
      actionsButtons.clear();
    }

    actionsButtons.add(FloatingActionButton(
        onPressed: () async {
          if (!categoryForm.isValidForm()) return;
          await categoryService.editOrCreateCategory(categoryForm.category);
        },
        heroTag: null,
        tooltip: "Guardar",
        child: const Icon(Icons.save)));

    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdating ? 'Crear Categoria' : 'Actualizar Categoria'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [_CategoryForm()]),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: actionsButtons,
      ),
    );
  }
}

class _CategoryForm extends StatefulWidget {
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<_CategoryForm> {
  bool sw = false;

  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryFormProvider>(context);
    final category = categoryForm.category;
    sw = category.categoryState == "Activa";

    return Form(
      key: categoryForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            initialValue: category.categoryName,
            onChanged: (value) => category.categoryName = value,
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Nombre es requerido' : null,
            decoration: InputColor.inputDecoration(
              hinText: 'Nombre de categoria',
              labelText: 'Nombre',
            ),
          ),
          const SizedBox(height: 20),
          SwitchListTile.adaptive(
            value: sw,
            onChanged: (val) {
              category.categoryState = val ? "Activa" : "bloqueada";
              setState(() {
                sw = val;
              });
            },
            activeColor: Colors.blue,
            title: const Text('Disponible'),
          )
        ],
      ),
    );
  }
}