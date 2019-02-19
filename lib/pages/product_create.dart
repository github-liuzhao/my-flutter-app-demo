import 'package:flutter/material.dart';

class ProductCreate extends StatefulWidget {
  final Function addProduct;
  ProductCreate(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreate();
  }
}

class _ProductCreate extends State<ProductCreate> {

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
    widget.addProduct(_formData);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
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
}
