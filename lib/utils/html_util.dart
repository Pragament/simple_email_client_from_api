import 'dart:convert';

class HtmlWrapper {
  /// Reconstructs complete HTML document from head and body content
  static String wrapHtml({
    required String head,
    required String body,
  }) {
    String lang = 'en';
    String charset = 'UTF-8';
    return '''
<!DOCTYPE html>
<html lang="$lang">
<head>
    <meta charset="$charset">
    $head
</head>
<body>
    $body
</body>
</html>''';
  }

  static String decodeFromGraphQL(String content) {
    return content
        .replaceAll(r'\\', r'\')
        .replaceAll(r'\"', '"')
        .replaceAll(r"\'", "'")
        .replaceAll(r'\n', '\n')
        .replaceAll(r'\r', '\r')
        .replaceAll(r'\t', '\t');
  }

  /// Reconstructs HTML from extracted content map
  static String wrapFromContent(String content) {
    final data = jsonDecode(content) as Map<String, dynamic>;
    return wrapHtml(
      head: decodeFromGraphQL(data['head'] ?? ''),
      body: decodeFromGraphQL(data['body'] ?? ''),
    );
  }
}
