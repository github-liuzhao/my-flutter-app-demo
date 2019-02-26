import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scope-model/main.dart';

class ProductEdit extends StatefulWidget {
  final int productIndex;
  ProductEdit([this.productIndex]) {
    print('ProductEdit widget constructor');
  }

  @override
  State<StatefulWidget> createState() {
    return _ProductEdit();
  }
}

class _ProductEdit extends State<ProductEdit> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'price': null,
    'desc': null,
    'image': 'assets/01.jpg'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _createTitleTextFiled(String title) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title required'),
      initialValue: title == null ? '' : title,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title can not be empty';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _createPriceTextFiled(double price) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price required'),
      keyboardType: TextInputType.numberWithOptions(),
      initialValue: price == null ? '' : price.toString(),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price requied and should be a number';
        }
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
    );
  }

  Widget _createDescTextFiled(String desc) {
    return TextFormField(
      maxLines: 4,
      initialValue: desc == null ? '' : desc,
      decoration: InputDecoration(
        labelText: 'Desc required',
      ),
      onSaved: (String value) {
        _formData['desc'] = value;
      },
    );
  }

  Widget _buildSubmitBtn(MainModel model) {
    return RaisedButton(
      textColor: Colors.white,
      child: Text('提交'),
      onPressed: () => _submitForms(model),
    );
  }

  void _submitForms(MainModel model) {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (widget.productIndex == null) {
      model.addProduct(        
        title: _formData['title'],
        desc: _formData['desc'],
        price: _formData['price'],
        image: _formData['image'],
        isMyFavorite: widget.productIndex == null ? false : model.products[widget.productIndex].isMyFavorite);
    } else {
      model.editProduct(
        widget.productIndex,         
        title: _formData['title'],
        desc: _formData['desc'],
        price: _formData['price'],
        image: _formData['image'],
        isMyFavorite: widget.productIndex == null ? false : model.products[widget.productIndex].isMyFavorite);
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildProductContent(BuildContext context, MainModel model) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 750.0 ? 00.0 : deviceWidth * 0.9;
    final double paddingWidth = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: paddingWidth / 2),
              // ListView always take full avialble width
              children: <Widget>[
                _createTitleTextFiled(widget.productIndex == null
                    ? null
                    : model.products[widget.productIndex].title),
                _createPriceTextFiled(widget.productIndex == null
                    ? null
                    : model.products[widget.productIndex].price),
                _createDescTextFiled(widget.productIndex == null
                    ? null
                    : model.products[widget.productIndex].desc),
                _buildSubmitBtn(model),
                // GestureDetector(
                //   onTap: (){
                //     print('GestureDetector');
                //   },
                //   child: Container(child: Text('click me'),),
                // ),
              ],
            ),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return widget.productIndex == null
          ? _buildProductContent(context, model)
          : Scaffold(
              appBar: AppBar(
                title: Text('Edit ${model.products[widget.productIndex].title}'),
              ),
              body: _buildProductContent(context, model),
            );
      },
    );
  }
}
