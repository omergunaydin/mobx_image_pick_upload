import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  String? name;
  String? bucket;
  String? generation;
  String? metageneration;
  String? contentType;
  String? timeCreated;
  String? updated;
  String? storageClass;
  String? size;
  String? md5Hash;
  String? contentEncoding;
  String? contentDisposition;
  String? crc32c;
  String? etag;
  String? downloadTokens;

  ImageModel(
      {this.name,
      this.bucket,
      this.generation,
      this.metageneration,
      this.contentType,
      this.timeCreated,
      this.updated,
      this.storageClass,
      this.size,
      this.md5Hash,
      this.contentEncoding,
      this.contentDisposition,
      this.crc32c,
      this.etag,
      this.downloadTokens});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return _$ImageModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ImageModelToJson(this);
  }
}
