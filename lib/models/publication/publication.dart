import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'publication.g.dart';

@JsonSerializable()
class Publication extends Equatable {
    Publication({
        required this.containerType,
        required this.source,
        required this.bib,
        required this.filled,
        required this.gsrank,
        required this.pubUrl,
        required this.authorId,
        required this.urlScholarbib,
        required this.urlAddSclib,
        required this.numCitations,
        required this.citedbyUrl,
        required this.urlRelatedArticles,
        required this.eprintUrl,
    });

    @JsonKey(name: 'container_type') 
    final String? containerType;
    final String? source;
    final Bib? bib;
    final bool? filled;
    final int? gsrank;

    @JsonKey(name: 'pub_url') 
    final String? pubUrl;

    @JsonKey(name: 'author_id') 
    final List<String>? authorId;

    @JsonKey(name: 'url_scholarbib') 
    final String? urlScholarbib;

    @JsonKey(name: 'url_add_sclib') 
    final String? urlAddSclib;

    @JsonKey(name: 'num_citations') 
    final int? numCitations;

    @JsonKey(name: 'citedby_url') 
    final String? citedbyUrl;

    @JsonKey(name: 'url_related_articles') 
    final String? urlRelatedArticles;

    @JsonKey(name: 'eprint_url') 
    final String? eprintUrl;

    Publication copyWith({
        String? containerType,
        String? source,
        Bib? bib,
        bool? filled,
        int? gsrank,
        String? pubUrl,
        List<String>? authorId,
        String? urlScholarbib,
        String? urlAddSclib,
        int? numCitations,
        String? citedbyUrl,
        String? urlRelatedArticles,
        String? eprintUrl,
    }) {
        return Publication(
            containerType: containerType ?? this.containerType,
            source: source ?? this.source,
            bib: bib ?? this.bib,
            filled: filled ?? this.filled,
            gsrank: gsrank ?? this.gsrank,
            pubUrl: pubUrl ?? this.pubUrl,
            authorId: authorId ?? this.authorId,
            urlScholarbib: urlScholarbib ?? this.urlScholarbib,
            urlAddSclib: urlAddSclib ?? this.urlAddSclib,
            numCitations: numCitations ?? this.numCitations,
            citedbyUrl: citedbyUrl ?? this.citedbyUrl,
            urlRelatedArticles: urlRelatedArticles ?? this.urlRelatedArticles,
            eprintUrl: eprintUrl ?? this.eprintUrl,
        );
    }

    factory Publication.fromJson(Map<String, dynamic> json) => _$PublicationFromJson(json);

    Map<String, dynamic> toJson() => _$PublicationToJson(this);

    @override
    List<Object?> get props => [
    containerType, source, bib, filled, gsrank, pubUrl, authorId, urlScholarbib, urlAddSclib, numCitations, citedbyUrl, urlRelatedArticles, eprintUrl, ];
}

@JsonSerializable()
class Bib extends Equatable {
    Bib({
        required this.title,
        required this.author,
        required this.pubYear,
        required this.venue,
        required this.bibAbstract,
        required this.number,
        required this.volume,
        required this.journal,
        required this.pubType,
        required this.bibId,
    });

    final String? title;
    final String? author;

    @JsonKey(name: 'pub_year') 
    final String? pubYear;
    final String? venue;
    final String? bibAbstract;
    final String? number;
    final String? volume;
    final String? journal;

    @JsonKey(name: 'pub_type') 
    final String? pubType;

    @JsonKey(name: 'bib_id') 
    final String? bibId;

    Bib copyWith({
        String? title,
        String? author,
        String? pubYear,
        String? venue,
        String? bibAbstract,
        String? number,
        String? volume,
        String? journal,
        String? pubType,
        String? bibId,
    }) {
        return Bib(
            title: title ?? this.title,
            author: author ?? this.author,
            pubYear: pubYear ?? this.pubYear,
            venue: venue ?? this.venue,
            bibAbstract: bibAbstract ?? this.bibAbstract,
            number: number ?? this.number,
            volume: volume ?? this.volume,
            journal: journal ?? this.journal,
            pubType: pubType ?? this.pubType,
            bibId: bibId ?? this.bibId,
        );
    }

    factory Bib.fromJson(Map<String, dynamic> json) => _$BibFromJson(json);

    Map<String, dynamic> toJson() => _$BibToJson(this);

    @override
    List<Object?> get props => [
    title, author, pubYear, venue, bibAbstract, number, volume, journal, pubType, bibId, ];
}
