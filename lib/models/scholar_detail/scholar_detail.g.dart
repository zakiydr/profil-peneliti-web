// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scholar_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScholarDetail _$ScholarDetailFromJson(Map<String, dynamic> json) =>
    ScholarDetail(
      containerType: json['container_type'] as String?,
      filled:
          (json['filled'] as List<dynamic>?)?.map((e) => e as String).toList(),
      scholarId: json['scholar_id'] as String?,
      source: json['source'] as String?,
      name: json['name'] as String?,
      urlPicture: json['url_picture'] as String?,
      affiliation: json['affiliation'] as String?,
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      emailDomain: json['email_domain'] as String?,
      homepage: json['homepage'] as String?,
      citedby: (json['citedby'] as num?)?.toInt(),
      citedby5Y: (json['citedby5y'] as num?)?.toInt(),
      hindex: (json['hindex'] as num?)?.toInt(),
      hindex5Y: (json['hindex5y'] as num?)?.toInt(),
      i10Index: (json['i10index'] as num?)?.toInt(),
      i10Index5Y: (json['i10index5y'] as num?)?.toInt(),
      citesPerYear: (json['cites_per_year'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      coauthors: (json['coauthors'] as List<dynamic>?)
          ?.map((e) => Coauthor.fromJson(e as Map<String, dynamic>))
          .toList(),
      publications: (json['publications'] as List<dynamic>?)
          ?.map((e) => Publication.fromJson(e as Map<String, dynamic>))
          .toList(),
      publicAccess: json['public_access'] == null
          ? null
          : PublicAccess.fromJson(
              json['public_access'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScholarDetailToJson(ScholarDetail instance) =>
    <String, dynamic>{
      'container_type': instance.containerType,
      'filled': instance.filled,
      'scholar_id': instance.scholarId,
      'source': instance.source,
      'name': instance.name,
      'url_picture': instance.urlPicture,
      'affiliation': instance.affiliation,
      'interests': instance.interests,
      'email_domain': instance.emailDomain,
      'homepage': instance.homepage,
      'citedby': instance.citedby,
      'citedby5y': instance.citedby5Y,
      'hindex': instance.hindex,
      'hindex5y': instance.hindex5Y,
      'i10index': instance.i10Index,
      'i10index5y': instance.i10Index5Y,
      'cites_per_year': instance.citesPerYear,
      'coauthors': instance.coauthors,
      'publications': instance.publications,
      'public_access': instance.publicAccess,
    };

Coauthor _$CoauthorFromJson(Map<String, dynamic> json) => Coauthor(
      containerType: json['container_type'] as String?,
      filled: json['filled'] as List<dynamic>?,
      scholarId: json['scholar_id'] as String?,
      source: json['source'] as String?,
      name: json['name'] as String?,
      affiliation: json['affiliation'] as String?,
    );

Map<String, dynamic> _$CoauthorToJson(Coauthor instance) => <String, dynamic>{
      'container_type': instance.containerType,
      'filled': instance.filled,
      'scholar_id': instance.scholarId,
      'source': instance.source,
      'name': instance.name,
      'affiliation': instance.affiliation,
    };

PublicAccess _$PublicAccessFromJson(Map<String, dynamic> json) => PublicAccess(
      available: (json['available'] as num?)?.toInt(),
      notAvailable: (json['not_available'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PublicAccessToJson(PublicAccess instance) =>
    <String, dynamic>{
      'available': instance.available,
      'not_available': instance.notAvailable,
    };

Publication _$PublicationFromJson(Map<String, dynamic> json) => Publication(
      containerType: json['container_type'] as String?,
      source: json['source'] as String?,
      bib: json['bib'] == null
          ? null
          : Bib.fromJson(json['bib'] as Map<String, dynamic>),
      filled: json['filled'] as bool?,
      authorPubId: json['author_pub_id'] as String?,
      numCitations: (json['num_citations'] as num?)?.toInt(),
      citedbyUrl: json['citedby_url'] as String?,
      citesId: (json['cites_id'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PublicationToJson(Publication instance) =>
    <String, dynamic>{
      'container_type': instance.containerType,
      'source': instance.source,
      'bib': instance.bib,
      'filled': instance.filled,
      'author_pub_id': instance.authorPubId,
      'num_citations': instance.numCitations,
      'citedby_url': instance.citedbyUrl,
      'cites_id': instance.citesId,
    };

Bib _$BibFromJson(Map<String, dynamic> json) => Bib(
      title: json['title'] as String?,
      pubYear: json['pub_year'] as String?,
      citation: json['citation'] as String?,
    );

Map<String, dynamic> _$BibToJson(Bib instance) => <String, dynamic>{
      'title': instance.title,
      'pub_year': instance.pubYear,
      'citation': instance.citation,
    };
