// Order tracking data is sourced from Cloud Firestore (see
// TrackRemoteDataSourceImpl), not the REST API, so no Dio/Retrofit client is
// needed for this feature. The driver app writes live status + location to the
// `orders/{orderId}` document that the customer app streams here.
