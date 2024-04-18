import 'package:advanced_flutter/data/network/error_handler.dart';

import '../response/responses.dart';

// for home data
const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60*1000; // 1 minutes in milliseconds

// for store data
const CACHE_STORE_DETAILS_KEY = "CACHE_STORE_DETAILS_KEY";
const CACHE_STORE_DETAILS_INTERVAL = 60 * 1000; // 30s in millis
abstract class LocalDataSource {

  Future<HomeResponse> getHomeData();

  Future<void> saveHomeCache(HomeResponse homeResponse);

  void clearCache();

  void removeFromCache(String key);

  Future<StoreDetailsResponse> getStoreDetails();

  Future<void> saveStoreDetailsToCache(StoreDetailsResponse response);

}

class LocalDataSourceImp implements LocalDataSource {

  // run time cash بخزن فيه home response بتاعي يكون معمول له cache

  Map<String , CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHomeData() async{

    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if(cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)){
      // return response from cache
      return cachedItem.data;
    }else{
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.CASH_ERROR);
    }
  }

  @override
  Future<void> saveHomeCache(HomeResponse homeResponse) async{
    cacheMap[CACHE_HOME_KEY] =  CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async {
    CachedItem? cachedItem = cacheMap[CACHE_STORE_DETAILS_KEY];

    if (cachedItem != null &&
        cachedItem.isValid(CACHE_STORE_DETAILS_INTERVAL)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CASH_ERROR);
    }
  }

  @override
  Future<void> saveStoreDetailsToCache(StoreDetailsResponse response) async {
    cacheMap[CACHE_STORE_DETAILS_KEY] = CachedItem(response);
  }
}

class CachedItem {

  dynamic data ;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem{

  bool isValid(int expirationTimeInMillis){
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTimeInMillis - cacheTime <= expirationTimeInMillis ;

    return isValid ;
  }
}