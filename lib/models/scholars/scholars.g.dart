// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scholars.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Scholars _$ScholarsFromJson(Map<String, dynamic> json) => Scholars(
      count: (json['count'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      nextPage: (json['next_page'] as num?)?.toInt(),
      previousPage: json['previous_page'],
      authors: (json['authors'] as List<dynamic>?)
          ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScholarsToJson(Scholars instance) => <String, dynamic>{
      'count': instance.count,
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'next_page': instance.nextPage,
      'previous_page': instance.previousPage,
      'authors': instance.authors,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      containerType: json['container_type'] as String?,
      filled: json['filled'] as List<dynamic>?,
      source: json['source'] as String?,
      scholarId: json['scholar_id'] as String?,
      urlPicture: json['url_picture'] as String?,
      name: json['name'] as String?,
      affiliation: json['affiliation'] as String?,
      emailDomain: json['email_domain'] as String?,
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      citedby: (json['citedby'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'container_type': instance.containerType,
      'filled': instance.filled,
      'source': instance.source,
      'scholar_id': instance.scholarId,
      'url_picture': instance.urlPicture,
      'name': instance.name,
      'affiliation': instance.affiliation,
      'email_domain': instance.emailDomain,
      'interests': instance.interests,
      'citedby': instance.citedby,
    };
