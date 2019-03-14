class CategoryModel{
  String mallCategoryId;

  String mallCategoryName;
  Null comments;
  List bxMallSubDto;
  String image;
  CategoryModel({
    this.bxMallSubDto,
    this.comments,
    this.image,
    this.mallCategoryId,
    this.mallCategoryName,
    }
  );
  factory CategoryModel.fromJson(dynamic json){
    return CategoryModel(
      bxMallSubDto: json['bxMallSubDto'],
      comments: json['comments'],
      image: json['image'],
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
    );
  }
}
class CategoryListModel{
  List<CategoryModel> data;
  CategoryListModel({this.data});
  factory CategoryListModel.fromJson(List json){
    return CategoryListModel(
      data:json.map((i)=>CategoryModel.fromJson(i)).toList(),
    );
  }
}