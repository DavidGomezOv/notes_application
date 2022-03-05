import 'package:hive/hive.dart';
import 'package:notes_application/core/text_type.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {

  @HiveField(1)
  int index;
  @HiveField(2)
  String title;
  @HiveField(3)
  String content;
  @HiveField(4)
  DateTime createdAt;
  @HiveField(5)
  String? color;
  @HiveField(6)
  bool isPinned;
  @HiveField(7)
  TextType textType;
  @HiveField(8)
  int textSize;

  Note(this.index, this.title, this.content, this.createdAt, this.color, this.isPinned, this.textType, this.textSize);

}