# cv

A professional CV application built with Flutter featuring a Modern Minimalist design.

## Features

- 📱 Modern, responsive CV presentation
- 🎨 Dark theme with teal accents
- 📂 **File Management Utility** - Comprehensive file deletion functionality
- 🔧 Built-in file manager demo

## Getting Started

This project is a starting point for a Flutter application.

### File Deletion Feature

This project includes a comprehensive file management system that demonstrates how to delete files in Dart/Flutter code. 

#### Quick Example

```dart
import 'package:cv_app/file_manager.dart';

// Delete a single file
await FileManager.deleteFile('/path/to/file.txt');

// Delete multiple files
await FileManager.deleteMultipleFiles([
  '/path/to/file1.txt',
  '/path/to/file2.pdf',
]);

// Delete old files
await FileManager.deleteOldFiles(
  '/path/to/directory',
  Duration(days: 7),
);
```

#### Documentation

See [HOW_TO_DELETE_FILES.md](HOW_TO_DELETE_FILES.md) for comprehensive documentation on file deletion in Dart/Flutter, including:

- Basic file deletion methods
- Advanced file operations
- Best practices
- UI integration examples
- Testing examples
- Common issues and solutions

#### Demo Application

The app includes a File Manager Demo that you can access from the main CV page by clicking the file manager icon (📁) in the app bar. This demo provides:

- Interactive file picking and deletion
- Multiple file operations
- Cleanup utilities for temporary files
- Visual feedback and history tracking

#### Examples

Check out the `examples/file_deletion_examples.dart` file for runnable examples demonstrating:

1. Basic file deletion
2. Safe deletion with existence checks
3. Deleting multiple files
4. Deleting files in a directory

Run the examples with:
```bash
dart run examples/file_deletion_examples.dart
```

## Flutter Resources

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Dependencies

- `file_picker`: For selecting files from the device
- `path_provider`: For accessing file system directories
- `url_launcher`: For opening links
- `http`: For API calls

## Project Structure

```
lib/
  ├── main.dart                 # App entry point
  ├── cv_page.dart              # Main CV page
  ├── models.dart               # Data models
  ├── file_manager.dart         # File management utility
  └── file_manager_demo.dart    # Demo UI for file operations
examples/
  └── file_deletion_examples.dart  # Runnable examples
test/
  └── file_manager_test.dart    # Unit tests
```

## License

This project is open source and available under the MIT License.
