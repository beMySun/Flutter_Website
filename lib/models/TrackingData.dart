class TrackingData {
  final String deliveryType;
  final String currentStatus;
  final String phone;
  final String recipientName;
  final String slsTrackingNumber;
  final List<TrackingItem> trackingList;

  TrackingData({
    this.deliveryType,
    this.currentStatus,
    this.trackingList,
    this.phone,
    this.recipientName,
    this.slsTrackingNumber
  });

  factory TrackingData.fromJson(Map<String, dynamic> json) {
    
    var list = json['tracking_list'] as List;
    List <TrackingItem> trackingList = list.map((i) => TrackingItem.fromJson(i)).toList();

    return TrackingData(
      currentStatus: json['current_status'],
      deliveryType: json['delivery_type'],
      trackingList: trackingList,
      phone: json['phone'],
      recipientName: json['recipient_name'],
      slsTrackingNumber: json['sls_tracking_number']
    );
  }
}

class TrackingItem {
  final String status;
  final int timestamp;
  final String message;

  TrackingItem({this.status, this.timestamp, this.message});

  factory TrackingItem.fromJson(Map<String, dynamic> parsedJson) {
    return TrackingItem(
      status: parsedJson['status'],
      timestamp: parsedJson['timestamp'],
      message: parsedJson['message']
    );
  }
}