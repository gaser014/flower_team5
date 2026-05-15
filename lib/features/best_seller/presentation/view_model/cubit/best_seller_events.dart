sealed class BestSellerEvents {}

class GetBestSellersEvent extends BestSellerEvents {
  final bool isRefresh;
  GetBestSellersEvent({this.isRefresh = false});
}

