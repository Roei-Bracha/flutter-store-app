import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/productsProvider.dart';

class EditProductScreenArguments {
  final String id;
  EditProductScreenArguments(this.id);
}

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  EditProductScreen({Key key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocuseNode = FocusNode();
  final _descriptionFocuseNode = FocusNode();
  final _imageFocuseNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  bool isInit = true;
  var _editedProduct = Product(
      id: null,
      description: '',
      imageUrl: '',
      price: 0,
      title: '',
      isFavorite: false);

  @override
  void dispose() {
    _priceFocuseNode.dispose();
    _descriptionFocuseNode.dispose();
    _imageUrlController.dispose();
    _imageFocuseNode.removeListener(_updateImageUrl);
    _imageFocuseNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    _imageFocuseNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final EditProductScreenArguments args =
          ModalRoute.of(context).settings.arguments;
      if (args != null && args.id != null) {
        _editedProduct = Provider.of<Products>(context).findById(args.id);
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    print(_imageUrlController.text);
    if (!_imageFocuseNode.hasFocus &&
        !_imageUrlController.text.startsWith('http://') &&
        !_imageUrlController.text.startsWith('https://') &&
        !_imageUrlController.text.endsWith('jpg') &&
        !_imageUrlController.text.endsWith('png') &&
        !_imageUrlController.text.endsWith('jpeg')) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      if (_editedProduct.id == null) {
                Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } else {
        Provider.of<Products>(context, listen: false)
            .editProduct(_editedProduct);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Product'),
          actions: [IconButton(icon: Icon(Icons.save), onPressed: _saveForm)],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _editedProduct.title,
                  decoration: InputDecoration(
                    labelText: 'Title',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_priceFocuseNode),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please provide a Title";
                    }
                    return null;
                  },
                  onSaved: (newValue) => _editedProduct = Product(
                      id: _editedProduct.id,
                      title: newValue,
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price),
                ),
                TextFormField(
                  initialValue: _editedProduct.price.toString(),
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocuseNode,
                  onFieldSubmitted: (value) => FocusScope.of(context)
                      .requestFocus(_descriptionFocuseNode),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please provide a price";
                    }
                    if (double.tryParse(value) == null) {
                      return "Please enter a valid number";
                    }
                    if (double.parse(value) <= 0) {
                      return "Please enter a number grater then 0";
                    }
                    return null;
                  },
                  onSaved: (newValue) => _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      price: double.parse(newValue)),
                ),
                TextFormField(
                  initialValue: _editedProduct.description,
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocuseNode,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please provide a Description";
                    }
                    return null;
                  },
                  onSaved: (newValue) => _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: newValue,
                      imageUrl: _editedProduct.imageUrl,
                      price: _editedProduct.price),
                ),
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: _imageUrlController.text.isEmpty
                          ? Center(child: Text('Enter URL'))
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        onFieldSubmitted: (value) => _saveForm(),
                        validator: (value) {
                          value = value.toLowerCase();
                          if (value.isEmpty) {
                            return "Please provide a imageUrl";
                          }
                          if (!value.startsWith('http://') &&
                              !value.startsWith('https://') &&
                              !value.endsWith('jpg') &&
                              !value.endsWith('png') &&
                              !value.endsWith('jpeg')) {
                            return "Please provide a valid imageUrl";
                          }
                          return null;
                        },
                        onSaved: (newValue) => _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            imageUrl: newValue,
                            price: _editedProduct.price),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
