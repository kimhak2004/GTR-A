# How to Delete Files in Dart/Flutter Code

This guide explains different methods for deleting files in Dart and Flutter applications.

## Table of Contents
1. [Basic File Deletion](#basic-file-deletion)
2. [Using the FileManager Utility](#using-the-filemanager-utility)
3. [Advanced File Operations](#advanced-file-operations)
4. [Best Practices](#best-practices)
5. [Examples](#examples)

## Basic File Deletion

### Method 1: Using dart:io File Class

The simplest way to delete a file in Dart is using the `File` class from `dart:io`:

```dart
import 'dart:io';

// Delete a file
await File('/path/to/file.txt').delete();
```

### Method 2: Safe Deletion (Check if Exists)

Always check if a file exists before attempting to delete it:

```dart
import 'dart:io';

File file = File('/path/to/file.txt');

if (await file.exists()) {
  await file.delete();
  print('File deleted successfully');
} else {
  print('File does not exist');
}
```

### Method 3: With Error Handling

Wrap file deletion in try-catch blocks for robust error handling:

```dart
import 'dart:io';

try {
  File file = File('/path/to/file.txt');
  
  if (await file.exists()) {
    await file.delete();
    print('File deleted successfully');
  }
} catch (e) {
  print('Error deleting file: $e');
}
```

## Using the FileManager Utility

This project includes a comprehensive `FileManager` utility class that simplifies file operations.

### Delete a Single File

```dart
import 'file_manager.dart';

// Delete a file by path
bool success = await FileManager.deleteFile('/path/to/file.txt');

if (success) {
  print('File deleted successfully');
} else {
  print('Failed to delete file');
}
```

### Delete Multiple Files

```dart
import 'file_manager.dart';

List<String> filePaths = [
  '/path/to/file1.txt',
  '/path/to/file2.pdf',
  '/path/to/file3.jpg',
];

Map<String, bool> results = await FileManager.deleteMultipleFiles(filePaths);

results.forEach((path, success) {
  print('$path: ${success ? "deleted" : "failed"}');
});
```

### Delete All Files in a Directory

```dart
import 'file_manager.dart';

// Delete all files in a directory
int deletedCount = await FileManager.deleteAllFilesInDirectory(
  '/path/to/directory',
  recursive: false, // Set to true to delete files in subdirectories
);

print('Deleted $deletedCount files');
```

### Delete Old Files

Remove files older than a specified duration:

```dart
import 'file_manager.dart';

// Delete files older than 7 days
int deletedCount = await FileManager.deleteOldFiles(
  '/path/to/temp',
  Duration(days: 7),
);

print('Cleaned up $deletedCount old files');
```

## Advanced File Operations

### Delete File and Empty Parent Directory

```dart
import 'file_manager.dart';

// Delete file and parent directory if it becomes empty
bool success = await FileManager.deleteFileAndEmptyParent('/path/to/file.txt');
```

### Conditional File Deletion

Delete a file only if it matches certain criteria:

```dart
import 'file_manager.dart';

// Delete only .tmp files smaller than 1MB
bool deleted = await FileManager.deleteFileIfMatches(
  '/path/to/file.tmp',
  extension: '.tmp',
  maxSizeBytes: 1024 * 1024, // 1MB
);
```

### Pick and Delete Files

Interactive file picking and deletion:

```dart
import 'file_manager.dart';

// Let user pick a file and then delete it
bool success = await FileManager.pickAndDeleteFile();

if (success) {
  print('File picked and deleted');
} else {
  print('Operation cancelled or failed');
}
```

## Best Practices

### 1. Always Check File Existence

Before deleting a file, verify it exists to avoid errors:

```dart
if (await file.exists()) {
  await file.delete();
}
```

### 2. Use Try-Catch Blocks

Wrap file operations in try-catch for error handling:

```dart
try {
  await file.delete();
} catch (e) {
  print('Error: $e');
}
```

### 3. Use Application Directories

Store and delete files in appropriate directories:

```dart
import 'package:path_provider/path_provider.dart';

// Get application documents directory
Directory appDir = await getApplicationDocumentsDirectory();
String filePath = '${appDir.path}/myfile.txt';

// Delete file
await File(filePath).delete();
```

### 4. Handle Permissions

On mobile platforms, ensure you have necessary permissions before file operations.

### 5. Clean Up Temporary Files

Regularly delete temporary files to free up storage:

```dart
Directory tempDir = await getTemporaryDirectory();
await FileManager.deleteAllFilesInDirectory(tempDir.path);
```

## Examples

### Example 1: Delete User Profile Picture

```dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> deleteProfilePicture() async {
  try {
    final appDir = await getApplicationDocumentsDirectory();
    final profilePic = File('${appDir.path}/profile.jpg');
    
    if (await profilePic.exists()) {
      await profilePic.delete();
      print('Profile picture deleted');
    }
  } catch (e) {
    print('Error deleting profile picture: $e');
  }
}
```

### Example 2: Clean Up Cache Files

```dart
import 'package:path_provider/path_provider.dart';
import 'file_manager.dart';

Future<void> clearCache() async {
  try {
    final cacheDir = await getTemporaryDirectory();
    final count = await FileManager.deleteAllFilesInDirectory(
      cacheDir.path,
      recursive: true,
    );
    print('Cleared $count cache files');
  } catch (e) {
    print('Error clearing cache: $e');
  }
}
```

### Example 3: Delete Downloaded File After Processing

```dart
import 'dart:io';

Future<void> processAndDeleteFile(String filePath) async {
  try {
    final file = File(filePath);
    
    // Process the file
    final contents = await file.readAsString();
    print('Processing: $contents');
    
    // Delete after processing
    if (await file.exists()) {
      await file.delete();
      print('File deleted after processing');
    }
  } catch (e) {
    print('Error: $e');
  }
}
```

### Example 4: Delete Files Based on Pattern

```dart
import 'dart:io';

Future<void> deleteLogFiles(String directoryPath) async {
  try {
    final directory = Directory(directoryPath);
    final files = await directory.list().toList();
    
    for (var entity in files) {
      if (entity is File && entity.path.endsWith('.log')) {
        await entity.delete();
        print('Deleted log file: ${entity.path}');
      }
    }
  } catch (e) {
    print('Error deleting log files: $e');
  }
}
```

## UI Integration

### Delete File Button in Flutter Widget

```dart
import 'package:flutter/material.dart';
import 'file_manager.dart';

class DeleteFileButton extends StatelessWidget {
  final String filePath;
  final VoidCallback? onDeleted;

  const DeleteFileButton({
    required this.filePath,
    this.onDeleted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final success = await FileManager.deleteFile(filePath);
        
        if (success && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('File deleted successfully')),
          );
          onDeleted?.call();
        }
      },
      icon: const Icon(Icons.delete),
      label: const Text('Delete File'),
    );
  }
}
```

## Testing File Deletion

### Unit Test Example

```dart
import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  test('File deletion test', () async {
    // Create a temporary file
    final tempDir = await getTemporaryDirectory();
    final testFile = File('${tempDir.path}/test.txt');
    await testFile.writeAsString('test content');
    
    // Verify file exists
    expect(await testFile.exists(), true);
    
    // Delete the file
    await testFile.delete();
    
    // Verify file is deleted
    expect(await testFile.exists(), false);
  });
}
```

## Common Issues and Solutions

### Issue 1: Permission Denied

**Problem:** Getting "Permission denied" error when trying to delete files.

**Solution:** 
- On Android/iOS, ensure you have necessary permissions
- Only delete files in app-specific directories (documents, temp, cache)
- Don't try to delete system files or files in restricted locations

### Issue 2: File Not Found

**Problem:** File deletion fails because file doesn't exist.

**Solution:** Always check if file exists before deletion:
```dart
if (await file.exists()) {
  await file.delete();
}
```

### Issue 3: File Is Locked

**Problem:** Cannot delete file because it's being used by another process.

**Solution:**
- Close all streams/handles to the file before deletion
- Ensure no other part of your app is reading/writing to the file

## Additional Resources

- [Dart File Class Documentation](https://api.dart.dev/stable/dart-io/File-class.html)
- [Flutter path_provider Package](https://pub.dev/packages/path_provider)
- [Flutter file_picker Package](https://pub.dev/packages/file_picker)

## Demo Application

This project includes a demo application (`FileManagerDemo`) that demonstrates all these file deletion methods with a user interface. Access it from the main CV page by clicking the file manager icon in the app bar.
