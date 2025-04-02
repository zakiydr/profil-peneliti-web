// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'publication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Publication _$PublicationFromJson(Map<String, dynamic> json) => Publication(
      containerType: json['container_type'] as String?,
      source: json['source'] as String?,
      bib: json['bib'] == null
          ? null
          : Bib.fromJson(json['bib'] as Map<String, dynamic>),
      filled: json['filled'] as bool?,
      gsrank: (json['gsrank'] as num?)?.toInt(),
      pubUrl: json['pub_url'] as String?,
      authorId: (json['author_id'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      urlScholarbib: json['url_scholarbib'] as String?,
      urlAddSclib: json['url_add_sclib'] as String?,
      numCitations: (json['num_citations'] as num?)?.toInt(),
      citedbyUrl: json['citedby_url'] as String?,
      urlRelatedArticles: json['url_related_articles'] as String?,
      eprintUrl: json['eprint_url'] as String?,
    );

Map<String, dynamic> _$PublicationToJson(Publication instance) =>
    <String, dynamic>{
      'container_type': instance.containerType,
      'source': instance.source,
      'bib': instance.bib,
      'filled': instance.filled,
      'gsrank': instance.gsrank,
      'pub_url': instance.pubUrl,
      'author_id': instance.authorId,
      'url_scholarbib': instance.urlScholarbib,
      'url_add_sclib': instance.urlAddSclib,
      'num_citations': instance.numCitations,
      'citedby_url': instance.citedbyUrl,
      'url_related_articles': instance.urlRelatedArticles,
      'eprint_url': instance.eprintUrl,
    };

Bib _$BibFromJson(Map<String, dynamic> json) => Bib(
      title: json['title'] as String?,
      author: json['author'] as String?,
      pubYear: json['pub_year'] as String?,
      venue: json['venue'] as String?,
      bibAbstract: json['bibAbstract'] as String?,
      number: json['number'] as String?,
      volume: json['volume'] as String?,
      journal: json['journal'] as String?,
      pubType: json['pub_type'] as String?,
      bibId: json['bib_id'] as String?,
    );

Map<String, dynamic> _$BibToJson(Bib instance) => <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'pub_year': instance.pubYear,
      'venue': instance.venue,
      'bibAbstract': instance.bibAbstract,
      'number': instance.number,
      'volume': instance.volume,
      'journal': instance.journal,
      'pub_type': instance.pubType,
      'bib_id': instance.bibId,
    };
