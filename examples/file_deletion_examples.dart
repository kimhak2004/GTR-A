import 'dart:io';

/// Simple example demonstrating how to delete files in Dart
/// 
/// This script shows basic file deletion operations without Flutter dependencies
void main() async {
  print('=== File Deletion Examples in Dart ===\n');

  // Example 1: Basic file deletion
  await example1BasicDeletion();

  // Example 2: Safe deletion with existence check
  await example2SafeDeletion();

  // Example 3: Delete multiple files
  await example3DeleteMultipleFiles();

  // Example 4: Delete files in a directory
  await example4DeleteFilesInDirectory();

  print('\n=== All examples completed ===');
}

/// Example 1: Basic file deletion
Future<void> example1BasicDeletion() async {
  print('Example 1: Basic File Deletion');
  print('--------------------------------');

  try {
    // Create a temporary file
    final tempDir = Directory.systemTemp;
    final file = File('${tempDir.path}/example1.txt');
    await file.writeAsString('This is a test file');
    
    print('Created file: ${file.path}');
    print('File exists: ${await file.exists()}');

    // Delete the file
    await file.delete();
    
    print('File deleted');
    print('File exists: ${await file.exists()}');
  } catch (e) {
    print('Error: $e');
  }
  
  print('');
}

/// Example 2: Safe deletion with existence check
Future<void> example2SafeDeletion() async {
  print('Example 2: Safe Deletion with Existence Check');
  print('----------------------------------------------');

  try {
    final tempDir = Directory.systemTemp;
    final file = File('${tempDir.path}/example2.txt');
    await file.writeAsString('Safe deletion example');
    
    print('Created file: ${file.path}');

    // Safe deletion - check if file exists first
    if (await file.exists()) {
      await file.delete();
      print('File deleted successfully');
    } else {
      print('File does not exist');
    }

    // Try to delete again (file doesn't exist)
    if (await file.exists()) {
      await file.delete();
      print('File deleted successfully');
    } else {
      print('File does not exist (already deleted)');
    }
  } catch (e) {
    print('Error: $e');
  }
  
  print('');
}

/// Example 3: Delete multiple files
Future<void> example3DeleteMultipleFiles() async {
  print('Example 3: Delete Multiple Files');
  print('---------------------------------');

  try {
    final tempDir = Directory.systemTemp;
    
    // Create multiple files
    final files = <File>[];
    for (int i = 1; i <= 3; i++) {
      final file = File('${tempDir.path}/example3_file$i.txt');
      await file.writeAsString('Content for file $i');
      files.add(file);
      print('Created: ${file.path}');
    }

    print('\nDeleting files...');

    // Delete all files
    for (final file in files) {
      if (await file.exists()) {
        await file.delete();
        print('Deleted: ${file.path}');
      }
    }
  } catch (e) {
    print('Error: $e');
  }
  
  print('');
}

/// Example 4: Delete files in a directory
Future<void> example4DeleteFilesInDirectory() async {
  print('Example 4: Delete Files in Directory');
  print('-------------------------------------');

  try {
    // Create a temporary directory
    final tempDir = await Directory.systemTemp.createTemp('example4_');
    print('Created directory: ${tempDir.path}');

    // Create some files in the directory
    for (int i = 1; i <= 5; i++) {
      final file = File('${tempDir.path}/file$i.txt');
      await file.writeAsString('Content $i');
    }
    print('Created 5 files in the directory');

    // List files before deletion
    print('\nFiles before deletion:');
    await for (final entity in tempDir.list()) {
      if (entity is File) {
        print('  - ${entity.path}');
      }
    }

    // Delete all files in the directory
    int deletedCount = 0;
    await for (final entity in tempDir.list()) {
      if (entity is File) {
        await entity.delete();
        deletedCount++;
      }
    }
    print('\nDeleted $deletedCount files');

    // List files after deletion
    print('\nFiles after deletion:');
    final filesAfter = await tempDir.list().toList();
    if (filesAfter.isEmpty) {
      print('  (directory is empty)');
    }

    // Clean up the directory
    await tempDir.delete();
    print('Cleaned up temporary directory');
  } catch (e) {
    print('Error: $e');
  }
  
  print('');
}
