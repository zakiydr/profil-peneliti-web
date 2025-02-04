import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scholars.g.dart';

@JsonSerializable()
class Scholars extends Equatable {
    Scholars({
        required this.authors,
    });

    final List<Author>? authors;
    static const String authorsKey = "authors";
    

    factory Scholars.fromJson(Map<String, dynamic> json) => _$ScholarsFromJson(json);

    Map<String, dynamic> toJson() => _$ScholarsToJson(this);

    @override
    List<Object?> get props => [
    authors, ];
}

@JsonSerializable()
class Author extends Equatable {
    Author({
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
    final String containerType;
    static const String containerTypeKey = "container_type";
    
    final List<dynamic>? filled;
    static const String filledKey = "filled";
    
    final String source;
    static const String sourceKey = "source";
    

    @JsonKey(name: 'scholar_id') 
    final String scholarId;
    static const String scholarIdKey = "scholar_id";
    

    @JsonKey(name: 'url_picture') 
    final String urlPicture;
    static const String urlPictureKey = "url_picture";
    
    final String name;
    static const String nameKey = "name";
    
    final String affiliation;
    static const String affiliationKey = "affiliation";
    

    @JsonKey(name: 'email_domain') 
    final String emailDomain;
    static const String emailDomainKey = "email_domain";
    
    final List<String>? interests;
    static const String interestsKey = "interests";
    
    final int citedby;
    static const String citedbyKey = "citedby";
    

    factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

    Map<String, dynamic> toJson() => _$AuthorToJson(this);

    @override
    List<Object?> get props => [
    containerType, filled, source, scholarId, urlPicture, name, affiliation, emailDomain, interests, citedby, ];
}
