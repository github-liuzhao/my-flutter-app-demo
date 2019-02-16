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
  String _title;
  double _price;
  String _content;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'name required'),
            onChanged: (String value) {
              setState(() {
                _title = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'price required'),
            keyboardType: TextInputType.numberWithOptions(),
            onChanged: (String value) {
              setState(() {
                _price = double.parse(value);
              });
            },
          ),
          TextField(
            maxLines: 4,
            decoration: InputDecoration(labelText: 'content required',),
            onChanged: (String value) {
              setState(() {
                _content = value;
              });
            },
          ),
          RaisedButton(
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            child: Text('提交'),
            onPressed: (){
            widget.addProduct(<String, dynamic>{'title': _title, 'price': _price, 'content': _content, 'image': 'assets/01.jpg'});
            Navigator.pushReplacementNamed(context, '/products');
          },)
        ],
      ),
    );
  }
}
