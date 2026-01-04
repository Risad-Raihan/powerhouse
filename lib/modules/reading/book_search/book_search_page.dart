import 'package:flutter/material.dart';
import '../../../core/database/converters/enum_converters.dart';
import '../../../core/utils/time_utils.dart';
import '../../../core/theme/theme_extensions.dart';
import '../reading_repository.dart';
import 'book_search_service.dart';
import 'book_search_result_tile.dart';

/// Book search page - search and add books via Google Books API
class BookSearchPage extends StatefulWidget {
  final ReadingRepository readingRepository;

  const BookSearchPage({
    super.key,
    required this.readingRepository,
  });

  @override
  State<BookSearchPage> createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  final BookSearchService _searchService = BookSearchService();
  final TextEditingController _searchController = TextEditingController();
  List<BookSearchResult> _results = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _results = [];
        _errorMessage = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await _searchService.searchBooks(query);
      setState(() {
        _results = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to search: $e';
        _isLoading = false;
        _results = [];
      });
    }
  }

  Future<void> _handleBookTap(BookSearchResult result) async {
    // Check for duplicates
    final isDuplicate = await widget.readingRepository.checkDuplicateBook(
      title: result.title,
      author: result.authors.isNotEmpty ? result.authors.first : null,
    );

    if (isDuplicate && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This book is already in your library'),
        ),
      );
      return;
    }

    // Show dialog to select status
    if (!mounted) return;
    final status = await showDialog<ReadingStatus>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add to'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Want to Read'),
              leading: const Icon(Icons.book_outlined),
              onTap: () => Navigator.of(context).pop(ReadingStatus.wantToRead),
            ),
            ListTile(
              title: const Text('Currently Reading'),
              leading: const Icon(Icons.menu_book),
              onTap: () => Navigator.of(context).pop(ReadingStatus.currentlyReading),
            ),
          ],
        ),
      ),
    );

    if (status == null || !mounted) return;

    // Insert book
    try {
      await widget.readingRepository.insertReadingItem(
        title: result.title,
        author: result.authors.isNotEmpty ? result.authors.join(', ') : null,
        type: ReadingType.book,
        totalUnits: result.pageCount,
        coverImagePath: result.thumbnailUrl, // Store URL for now
        status: status,
        nowUtc: nowUtc(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Book added successfully'),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add book: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<PowerHouseCardTokens>();
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (tokens == null) {
      throw StateError('PowerHouseCardTokens not found in theme');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Books'),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: tokens.padding,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by title or author...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _performSearch();
                              },
                            )
                          : null,
                    ),
                    onEditingComplete: _performSearch,
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: _isLoading ? null : _performSearch,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Search'),
                ),
              ],
            ),
          ),

          // Results
          Expanded(
            child: _errorMessage != null
                ? Center(
                    child: Padding(
                      padding: tokens.padding,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _errorMessage!,
                            style: textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : _results.isEmpty
                    ? Center(
                        child: Padding(
                          padding: tokens.padding,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                size: 64,
                                color: colorScheme.onSurface.withValues(alpha: 0.3),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _searchController.text.isEmpty
                                    ? 'Enter a book title or author to search'
                                    : 'No results found',
                                style: textTheme.bodyLarge?.copyWith(
                                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(tokens.paddingSmall.horizontal / 2),
                        itemCount: _results.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: tokens.paddingSmall.horizontal / 2,
                            ),
                            child: BookSearchResultTile(
                              result: _results[index],
                              onTap: () => _handleBookTap(_results[index]),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

