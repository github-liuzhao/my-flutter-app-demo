import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scope-model/main.dart';
import '../model/product.dart';

class ProductEdit extends StatefulWidget {
  final String productId;
  final MainModel model;
  ProductEdit(this.productId, this.model) {
    print('ProductEdit widget constructor');
  }

  @override
  State<StatefulWidget> createState() {
    return _ProductEdit();
  }
}

class _ProductEdit extends State<ProductEdit> {
  Product _product;
  final Map<String, dynamic> _formData = {
    'title': null,
    'price': null,
    'desc': null
  };

  @override
  void initState() {
    if(widget.productId != null){
      widget.model.getProduct(widget.productId).then((Product product){
        setState((){
          _product = product;
          _formData['title'] = product.title;
          _formData['desc'] = product.desc;
          _formData['price'] = product.price;
        });
      });
    }
    print('editing productid ${widget.productId}');
    super.initState();
  }

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
    return model.isLoading ? Center(child: CircularProgressIndicator(),) : RaisedButton(
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
    if (widget.productId == null) {
      model.addProduct(
        title: _formData['title'],
        desc: _formData['desc'],
        price: _formData['price'],
        image: _formData['image'],
        isMyFavorite: false
      )
      .then((_) => Navigator.pushReplacementNamed(context, '/'));
    } else {
      model.updateProduct(
        widget.productId,
        title: _formData['title'],
        desc: _formData['desc'],
        price: _formData['price'],
        image: _product.image,
        userEmail: _product.userEmail,
        userId: _product.userId,
        isMyFavorite: _product.isMyFavorite
      )
      .then((_) =>  Navigator.pushReplacementNamed(context, '/'));
    }
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
                _createTitleTextFiled(widget.productId == null
                    ? null
                    : _formData['title']),
                _createPriceTextFiled(widget.productId == null
                    ? null
                    : _formData['price']),
                _createDescTextFiled(widget.productId == null
                    ? null
                    : _formData['desc']),
                SizedBox(height: 10.0,),
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
        return widget.productId == null
          ? _buildProductContent(context, model)
          : Scaffold(
              appBar: AppBar(
                title: Text('Edit product'),
              ),
              body: model.isLoading 
                ? Center(child: CircularProgressIndicator(),) 
                : _buildProductContent(context, model),
            );
      },
    );
  }
}
