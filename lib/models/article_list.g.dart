// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticlesListAdapter extends TypeAdapter<ArticlesList> {
  @override
  final int typeId = 0;

  @override
  ArticlesList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticlesList(
      statusCode: fields[0] as int,
      articlesList: (fields[1] as List).cast<Article>(),
    );
  }

  @override
  void write(BinaryWriter writer, ArticlesList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.statusCode)
      ..writeByte(1)
      ..write(obj.articlesList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticlesListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
