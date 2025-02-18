import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scholars.g.dart';

@JsonSerializable()
class Scholars extends Equatable {
    const Scholars({
        required this.count,
        required this.totalPages,
        required this.currentPage,
        required this.nextPage,
        required this.previousPage,
        required this.authors,
    });

    final int? count;

    @JsonKey(name: 'total_pages') 
    final int? totalPages;

    @JsonKey(name: 'current_page') 
    final int? currentPage;

    @JsonKey(name: 'next_page') 
    final int? nextPage;

    @JsonKey(name: 'previous_page') 
    final dynamic previousPage;
    final List<Author>? authors;

    factory Scholars.fromJson(Map<String, dynamic> json) => _$ScholarsFromJson(json);

    Map<String, dynamic> toJson() => _$ScholarsToJson(this);

    @override
    List<Object?> get props => [
    count, totalPages, currentPage, nextPage, previousPage, authors, ];
}

@JsonSerializable()
class Author extends Equatable {
    const Author({
        required this.containerType,
        required this.filled,
        required this.source,
        required this.scholarId,
        required this.urlPicture,
        required this.name,
        required this.affiliation,
        required this.emailDomain,
        required this.interests,
        required this.citedby,
    });

    @JsonKey(name: 'container_type') 
    final String? containerType;
    final List<dynamic>? filled;
    final String? source;

    @JsonKey(name: 'scholar_id') 
    final String? scholarId;

    @JsonKey(name: 'url_picture') 
    final String? urlPicture;
    final String? name;
    final String? affiliation;

    @JsonKey(name: 'email_domain') 
    final String? emailDomain;
    final List<String>? interests;
    final int? citedby;

    factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

    Map<String, dynamic> toJson() => _$AuthorToJson(this);

    @override
    List<Object?> get props => [
    containerType, filled, source, scholarId, urlPicture, name, affiliation, emailDomain, interests, citedby, ];
}
