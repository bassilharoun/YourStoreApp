class ChangeFavModel{
  bool? status ;
  dynamic message ;

  ChangeFavModel.fromJson(Map<String , dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}