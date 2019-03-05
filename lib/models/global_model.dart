import 'package:scoped_model/scoped_model.dart';

class GlobalModel extends Model{
  Object _data = {};
  String _trackingStatus = '';

  get trackingStatus => _trackingStatus;

  get data => _data;

  void updateData(data) {
    _data = data;
    notifyListeners();
  }

  void updateTrackingStatus(status) {
    _trackingStatus = status;
    notifyListeners();
  }

  GlobalModel of(context) => ScopedModel.of<GlobalModel>(context);
}