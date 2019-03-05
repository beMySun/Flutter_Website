class TrackingResponse {
  final String message;
  final int retcode;
  final Object data;

  TrackingResponse({this.message, this.retcode, this.data});

  factory TrackingResponse.fromJson(json) {
    return TrackingResponse(
        message: json['message'], retcode: json['retcode'], data: json['data']);
  }
}
