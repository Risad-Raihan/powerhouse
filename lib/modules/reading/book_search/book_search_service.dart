import 'dart:convert';
import 'package:http/http.dart' as http;

/// Google Books API search result model
class BookSearchResult {
  final String id;
  final String title;
  final List<String> authors;
  final String? thumbnailUrl;
  final int? pageCount;
  final String? description;

  BookSearchResult({
    required this.id,
    required this.title,
    required this.authors,
    this.thumbnailUrl,
    this.pageCount,
    this.description,
  });
}

/// Google Books API service
/// Uses REST API without OAuth (public search endpoint)
class BookSearchService {
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  /// Search for books by query (title/author)
  /// Returns list of BookSearchResult
  Future<List<BookSearchResult>> searchBooks(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }

    try {
      final uri = Uri.parse(_baseUrl).replace(queryParameters: {
        'q': query,
        'maxResults': '20',
      });

      final response = await http.get(uri).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Request timeout');
        },
      );

      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }

      final jsonData = json.decode(response.body) as Map<String, dynamic>;
      final items = jsonData['items'] as List<dynamic>?;

      if (items == null || items.isEmpty) {
        return [];
      }

      return items.map((item) {
        final volumeInfo = item['volumeInfo'] as Map<String, dynamic>?;
        if (volumeInfo == null) return null;

        final title = volumeInfo['title'] as String? ?? '';
        final authorsList = volumeInfo['authors'] as List<dynamic>?;
        final authors = authorsList?.map((a) => a.toString()).toList() ?? <String>[];

        // Extract thumbnail URL
        final imageLinks = volumeInfo['imageLinks'] as Map<String, dynamic>?;
        String? thumbnailUrl;
        if (imageLinks != null) {
          thumbnailUrl = imageLinks['thumbnail'] as String? ??
              imageLinks['smallThumbnail'] as String?;
        }

        final pageCount = volumeInfo['pageCount'] as int?;
        final description = volumeInfo['description'] as String?;

        return BookSearchResult(
          id: item['id'] as String? ?? '',
          title: title,
          authors: authors,
          thumbnailUrl: thumbnailUrl,
          pageCount: pageCount,
          description: description,
        );
      }).whereType<BookSearchResult>().toList();
    } catch (e) {
      throw Exception('Failed to search books: $e');
    }
  }
}

