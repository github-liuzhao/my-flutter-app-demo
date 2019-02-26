import 'package:scoped_model/scoped_model.dart';
import './collected_products.dart';

class MainModel extends Model with CollectedProducts, ProductsModel, UserModel{}