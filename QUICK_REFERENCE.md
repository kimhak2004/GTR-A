# Quick Reference - File Deletion in Dart/Flutter

## Import
```dart
import 'dart:io';
import 'package:cv_app/file_manager.dart';
```

## Basic Operations

### Delete a Single File
```dart
// Method 1: Using dart:io directly
await File('/path/to/file.txt').delete();

// Method 2: With safety check
final file = File('/path/to/file.txt');
if (await file.exists()) {
  await file.delete();
}

// Method 3: Using FileManager utility
await FileManager.deleteFile('/path/to/file.txt');
```

### Delete Multiple Files
```dart
await FileManager.deleteMultipleFiles([
  '/path/to/file1.txt',
  '/path/to/file2.pdf',
  '/path/to/file3.jpg',
]);
```

### Delete All Files in Directory
```dart
await FileManager.deleteAllFilesInDirectory(
  '/path/to/directory',
  recursive: true,  // Include subdirectories
);
```

## Advanced Operations

### Delete Old Files
```dart
// Delete files older than 7 days
await FileManager.deleteOldFiles(
  '/path/to/directory',
  Duration(days: 7),
);
```

### Conditional Deletion
```dart
// Delete only .tmp files under 1MB
await FileManager.deleteFileIfMatches(
  '/path/to/file.tmp',
  extension: '.tmp',
  maxSizeBytes: 1024 * 1024,
);
```

### Delete File with Empty Parent
```dart
// Delete file and parent directory if it becomes empty
await FileManager.deleteFileAndEmptyParent('/path/to/file.txt');
```

## File Picking

### Pick and Delete
```dart
// Let user pick a file
String? path = await FileManager.pickFile();

// Delete the picked file
if (path != null) {
  await FileManager.deleteFile(path);
}

// Or do both in one call
await FileManager.pickAndDeleteFile();
```

## Common Patterns

### Safe Deletion Pattern
```dart
try {
  final file = File('/path/to/file.txt');
  if (await file.exists()) {
    await file.delete();
    print('Deleted successfully');
  }
} catch (e) {
  print('Error: $e');
}
```

### Cleanup Pattern
```dart
// Get temporary directory
final tempDir = await FileManager.getTempDirectory();

// Delete all temp files
await FileManager.deleteAllFilesInDirectory(tempDir.path);
```

### Batch Deletion Pattern
```dart
final directory = Directory('/path/to/files');
await for (final file in directory.list()) {
  if (file is File && file.path.endsWith('.log')) {
    await file.delete();
  }
}
```

## Utility Methods

### Check File Existence
```dart
bool exists = await FileManager.fileExists('/path/to/file.txt');
```

### Get File Size
```dart
int bytes = await FileManager.getFileSize('/path/to/file.txt');
```

### Get App Directories
```dart
// Documents directory (persistent)
Directory docsDir = await FileManager.getAppDocumentsDirectory();

// Temporary directory (can be cleared by system)
Directory tempDir = await FileManager.getTempDirectory();
```

## Error Handling

```dart
try {
  bool success = await FileManager.deleteFile(filePath);
  if (success) {
    print('File deleted');
  } else {
    print('File not found or already deleted');
  }
} catch (e) {
  print('Error deleting file: $e');
}
```

## UI Integration

### Delete Button
```dart
ElevatedButton(
  onPressed: () async {
    bool success = await FileManager.deleteFile(filePath);
    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File deleted!')),
      );
    }
  },
  child: Text('Delete File'),
)
```

## Testing

```dart
test('File deletion test', () async {
  final file = File('/tmp/test.txt');
  await file.writeAsString('test');
  
  expect(await file.exists(), true);
  
  await FileManager.deleteFile(file.path);
  
  expect(await file.exists(), false);
});
```

## Resources
- Full Documentation: `HOW_TO_DELETE_FILES.md`
- Examples: `examples/file_deletion_examples.dart`
- Tests: `test/file_manager_test.dart`
- Demo App: Run the app and click the file manager icon (📁)
