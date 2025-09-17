class MediaShared {
	final List<dynamic>? images;
	final List<dynamic>? videos;
	final List<dynamic>? voices;
	final List<dynamic>? documents;

	const MediaShared({
		this.images, 
		this.videos, 
		this.voices, 
		this.documents, 
	});

	factory MediaShared.fromJson(Map<String, dynamic> json) => MediaShared(
				images: json['images'] as List<dynamic>?,
				videos: json['videos'] as List<dynamic>?,
				voices: json['voices'] as List<dynamic>?,
				documents: json['documents'] as List<dynamic>?,
			);

	Map<String, dynamic> toJson() => {
				'images': images,
				'videos': videos,
				'voices': voices,
				'documents': documents,
			};
}
