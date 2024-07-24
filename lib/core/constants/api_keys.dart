import 'dart:io';

class ApiKeys{
  static const androidApiKey = "CNhWrgHpjpsA4ApO3D5iJqHiq28J4b7j";
  static const iOSApiKey = "4khhc25uEBUSSfWFj6qbNJ4thb7mZWjt";
}

class ApiKeyProvider {
  static String _selectedApiKey = "";
  
  static selectKey(){
    if(Platform.isAndroid){
      _selectedApiKey = ApiKeys.androidApiKey;
    }
    else if(Platform.isIOS){
      _selectedApiKey = ApiKeys.iOSApiKey;
    }
  }

  static get getApiKey => _selectedApiKey;
}