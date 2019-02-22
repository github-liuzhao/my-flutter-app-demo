import 'package:flutter/material.dart';

class ProductEdit extends StatefulWidget {

  final Function addProduct;
  final Function editProduct;
  final int productIndex;
  final Map<String, dynamic> product;
  ProductEdit({this.addProduct, this.editProduct, this.product, this.productIndex}){
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

  Widget _createTitleTextFiled() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title required'),
      initialValue: widget.product == null ? '' : widget.product['title'],
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

  Widget _createPriceTextFiled() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price required'),
      keyboardType: TextInputType.numberWithOptions(),
      initialValue: widget.product == null ? '' : widget.product['price'].toString(),
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

  Widget _createDescTextFiled() {
    return TextFormField(
      maxLines: 4,
      initialValue: widget.product == null ? '' : widget.product['desc'],
      decoration: InputDecoration(
        labelText: 'Desc required',
      ),
      onSaved: (String value) {
        _formData['desc'] = value;
      },
    );
  }

  void _submitForms() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if(widget.product == null){
      widget.addProduct(_formData);
    } else {
      widget.editProduct(_formData, widget.productIndex);
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget productContent () {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 750.0 ? 00.0 : deviceWidth * 0.9;
    final double paddingWidth = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: (){
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
              _createTitleTextFiled(),
              _createPriceTextFiled(),
              _createDescTextFiled(),
              RaisedButton(
                textColor: Colors.white,
                child: Text('提交'),
                onPressed: _submitForms,
              ),
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
    return widget.product == null ? productContent() : Scaffold(appBar: AppBar(title: Text('Product edit'),), body: productContent(),);
  }
}
