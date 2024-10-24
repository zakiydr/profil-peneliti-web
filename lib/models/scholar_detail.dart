import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scholar_detail.g.dart';

@JsonSerializable()
class ScholarDetail extends Equatable {
    const ScholarDetail({
        required this.containerType,
        required this.filled,
        required this.scholarId,
        required this.source,
        required this.name,
        required this.urlPicture,
        required this.affiliation,
        required this.interests,
        required this.emailDomain,
        required this.homepage,
        required this.citedby,
        required this.citedby5Y,
        required this.hindex,
        required this.hindex5Y,
        required this.i10Index,
        required this.i10Index5Y,
        required this.citesPerYear,
        required this.coauthors,
        required this.publications,
        required this.publicAccess,
    });

    @JsonKey(name: 'container_type') 
    final String? containerType;
    final List<String>? filled;

    @JsonKey(name: 'scholar_id') 
    final String? scholarId;
    final String? source;
    final String? name;

    @JsonKey(name: 'url_picture') 
    final String? urlPicture;
    final String? affiliation;
    final List<String>? interests;

    @JsonKey(name: 'email_domain') 
    final String? emailDomain;
    final String? homepage;
    final int? citedby;

    @JsonKey(name: 'citedby5y') 
    final int? citedby5Y;
    final int? hindex;

    @JsonKey(name: 'hindex5y') 
    final int? hindex5Y;

    @JsonKey(name: 'i10index') 
    final int? i10Index;

    @JsonKey(name: 'i10index5y') 
    final int? i10Index5Y;

    @JsonKey(name: 'cites_per_year') 
    final Map<String, int>? citesPerYear;
    final List<Coauthor>? coauthors;
    final List<Publication>? publications;

    @JsonKey(name: 'public_access') 
    final PublicAccess? publicAccess;

    factory ScholarDetail.fromJson(Map<String, dynamic> json) => _$ScholarDetailFromJson(json);

    Map<String, dynamic> toJson() => _$ScholarDetailToJson(this);

    @override
    List<Object?> get props => [
    containerType, filled, scholarId, source, name, urlPicture, affiliation, interests, emailDomain, homepage, citedby, citedby5Y, hindex, hindex5Y, i10Index, i10Index5Y, citesPerYear, coauthors, publications, publicAccess, ];
}

@JsonSerializable()
class Coauthor extends Equatable {
    const Coauthor({
        required this.containerType,
        required this.filled,
        required this.scholarId,
        required this.source,
        required this.name,
        required this.affiliation,
    });

    @JsonKey(name: 'container_type') 
    final String? containerType;
    final List<dynamic>? filled;

    @JsonKey(name: 'scholar_id') 
    final String? scholarId;
    final String? source;
    final String? name;
    final String? affiliation;

    factory Coauthor.fromJson(Map<String, dynamic> json) => _$CoauthorFromJson(json);

    Map<String, dynamic> toJson() => _$CoauthorToJson(this);

    @override
    List<Object?> get props => [
    containerType, filled, scholarId, source, name, affiliation, ];
}

@JsonSerializable()
class PublicAccess extends Equatable {
    const PublicAccess({
        required this.available,
        required this.notAvailable,
    });

    final int? available;

    @JsonKey(name: 'not_available') 
    final int? notAvailable;

    factory PublicAccess.fromJson(Map<String, dynamic> json) => _$PublicAccessFromJson(json);

    Map<String, dynamic> toJson() => _$PublicAccessToJson(this);

    @override
    List<Object?> get props => [
    available, notAvailable, ];
}

@JsonSerializable()
class Publication extends Equatable {
    const Publication({
        required this.containerType,
        required this.source,
        required this.bib,
        required this.filled,
        required this.authorPubId,
        required this.numCitations,
        required this.citedbyUrl,
        required this.citesId,
    });

    @JsonKey(name: 'container_type') 
    final String? containerType;
    final String? source;
    final Bib? bib;
    final bool? filled;

    @JsonKey(name: 'author_pub_id') 
    final String? authorPubId;

    @JsonKey(name: 'num_citations') 
    final int? numCitations;

    @JsonKey(name: 'citedby_url') 
    final String? citedbyUrl;

    @JsonKey(name: 'cites_id') 
    final List<String>? citesId;

    factory Publication.fromJson(Map<String, dynamic> json) => _$PublicationFromJson(json);

    Map<String, dynamic> toJson() => _$PublicationToJson(this);

    @override
    List<Object?> get props => [
    containerType, source, bib, filled, authorPubId, numCitations, citedbyUrl, citesId, ];
}

@JsonSerializable()
class Bib extends Equatable {
    const Bib({
        required this.title,
        required this.pubYear,
        required this.citation,
    });

    final String? title;

    @JsonKey(name: 'pub_year') 
    final String? pubYear;
    final String? citation;

    factory Bib.fromJson(Map<String, dynamic> json) => _$BibFromJson(json);

    Map<String, dynamic> toJson() => _$BibToJson(this);

    @override
    List<Object?> get props => [
    title, pubYear, citation, ];
}
