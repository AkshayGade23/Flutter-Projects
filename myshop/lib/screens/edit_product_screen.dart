import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusedNode = FocusNode();
  final _descriptionFocusedNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusedNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var edittingProduct = Product(
    id: null,
    title: '',
    price: 0,
    imageUrl: '',
    description: '',
  );

  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };

  var _IsInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusedNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_IsInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        edittingProduct =
            Provider.of<Products>(context, listen: false).findById(productId);

        _initValues = {
          'title': edittingProduct.title,
          'price': edittingProduct.price.toString(),
          'description': edittingProduct.description,
          'imageUrl': '',
        };
        _imageUrlController.text = edittingProduct.imageUrl;
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusedNode.dispose();
    _descriptionFocusedNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusedNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (_imageUrlFocusedNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')))
      // ||
      // (!_imageUrlController.text.endsWith('png') &&
      //     !_imageUrlController.text.endsWith('jpg') &&
      //     !_imageUrlController.text.endsWith('jpeg')))
      {
        return null;
      }
    }

    setState(() {});
  }

  void _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return null;
    }
    _form.currentState.save();

    setState(() {
      _isLoading = true;
    });

    if (edittingProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .editItem(edittingProduct.id, edittingProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addItem(edittingProduct);
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occured!'),
            content: Text('Something went wrong!'),
            actions: [
              TextButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
      // finally {
      //   Navigator.of(context).pop();
      //   setState(() {
      //     _isLoading = true;
      //   });
      // }
      Navigator.of(context).pop();
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      initialValue: _initValues['title'],
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusedNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter a title.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        edittingProduct = Product(
                          id: edittingProduct.id,
                          isFavorite: edittingProduct.isFavorite,
                          title: value,
                          price: edittingProduct.price,
                          imageUrl: edittingProduct.imageUrl,
                          description: edittingProduct.description,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      initialValue: _initValues['price'],
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusedNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusedNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid Price';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a valid Price';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        edittingProduct = Product(
                          id: edittingProduct.id,
                          isFavorite: edittingProduct.isFavorite,
                          title: edittingProduct.title,
                          price: double.parse(value),
                          imageUrl: edittingProduct.imageUrl,
                          description: edittingProduct.description,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      initialValue: _initValues['description'],
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusedNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Please Enter at least 10 character';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        edittingProduct = Product(
                          id: edittingProduct.id,
                          isFavorite: edittingProduct.isFavorite,
                          title: edittingProduct.title,
                          price: edittingProduct.price,
                          imageUrl: edittingProduct.imageUrl,
                          description: value,
                        );
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          alignment: Alignment.center,
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a Url')
                              : Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Image URL',
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (_imageUrlController.text.isEmpty) {
                                return 'Please enter a image URL';
                              }
                              if (!_imageUrlController.text
                                      .startsWith('http') &&
                                  !_imageUrlController.text
                                      .startsWith('https')) {
                                return 'Please enter a valid image URL';
                              }
                              // if (!_imageUrlController.text.endsWith('png') &&
                              //     !_imageUrlController.text.endsWith('jpg') &&
                              //     !_imageUrlController.text.endsWith('jpeg')) {
                              //   return 'Please enter a valid image URL';
                              // }
                              return null;
                            },
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusedNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              edittingProduct = Product(
                                id: edittingProduct.id,
                                isFavorite: edittingProduct.isFavorite,
                                title: edittingProduct.title,
                                price: edittingProduct.price,
                                imageUrl: value,
                                description: edittingProduct.description,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
