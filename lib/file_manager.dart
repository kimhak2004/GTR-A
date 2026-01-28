import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

/// FileManager - A utility class for managing files in Flutter
/// 
/// This class demonstrates how to delete files in Dart code.
/// It provides methods for common file operations including:
/// - Deleting a single file
/// - Deleting multiple files
/// - Deleting files in a directory
/// - Safe file deletion with error handling
class FileManager {
  /// Delete a single file by its path
  /// 
  /// Example:
  /// ```dart
  /// await FileManager.deleteFile('/path/to/file.txt');
  /// ```
  /// 
  /// Returns true if the file was successfully deleted, false otherwise
  static Future<bool> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      
      // Check if file exists before attempting to delete
      if (await file.exists()) {
        await file.delete();
        debugPrint('File deleted successfully: $filePath');
        return true;
      } else {
        debugPrint('File does not exist: $filePath');
        return false;
      }
    } catch (e) {
      debugPrint('Error deleting file: $e');
      return false;
    }
  }

  /// Delete a file using a File object
  /// 
  /// Example:
  /// ```dart
  /// File myFile = File('/path/to/file.txt');
  /// await FileManager.deleteFileObject(myFile);
  /// ```
  static Future<bool> deleteFileObject(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
        debugPrint('File deleted successfully: ${file.path}');
        return true;
      } else {
        debugPrint('File does not exist: ${file.path}');
        return false;
      }
    } catch (e) {
      debugPrint('Error deleting file: $e');
      return false;
    }
  }

  /// Delete multiple files at once
  /// 
  /// Example:
  /// ```dart
  /// List<String> filePaths = ['/path/to/file1.txt', '/path/to/file2.pdf'];
  /// await FileManager.deleteMultipleFiles(filePaths);
  /// ```
  /// 
  /// Returns a map with file paths as keys and deletion status as values
  static Future<Map<String, bool>> deleteMultipleFiles(
      List<String> filePaths) async {
    Map<String, bool> results = {};

    for (String filePath in filePaths) {
      results[filePath] = await deleteFile(filePath);
    }

    return results;
  }

  /// Delete all files in a directory
  /// 
  /// Example:
  /// ```dart
  /// await FileManager.deleteAllFilesInDirectory('/path/to/directory');
  /// ```
  /// 
  /// Parameters:
  /// - directoryPath: Path to the directory
  /// - recursive: If true, also delete files in subdirectories
  static Future<int> deleteAllFilesInDirectory(
    String directoryPath, {
    bool recursive = false,
  }) async {
    int deletedCount = 0;

    try {
      final directory = Directory(directoryPath);

      if (!await directory.exists()) {
        debugPrint('Directory does not exist: $directoryPath');
        return 0;
      }

      final List<FileSystemEntity> entities = await directory
          .list(recursive: recursive, followLinks: false)
          .toList();

      for (var entity in entities) {
        if (entity is File) {
          if (await deleteFileObject(entity)) {
            deletedCount++;
          }
        }
      }

      debugPrint('Deleted $deletedCount files from $directoryPath');
    } catch (e) {
      debugPrint('Error deleting files in directory: $e');
    }

    return deletedCount;
  }

  /// Delete a file and its parent directory if empty
  /// 
  /// Useful for cleaning up temporary files and their directories
  static Future<bool> deleteFileAndEmptyParent(String filePath) async {
    try {
      final file = File(filePath);

      if (!await file.exists()) {
        return false;
      }

      // Delete the file
      await file.delete();
      debugPrint('File deleted: $filePath');

      // Check if parent directory is empty
      final parentDir = file.parent;
      final List<FileSystemEntity> contents = await parentDir.list().toList();

      if (contents.isEmpty) {
        await parentDir.delete();
        debugPrint('Empty parent directory deleted: ${parentDir.path}');
      }

      return true;
    } catch (e) {
      debugPrint('Error in deleteFileAndEmptyParent: $e');
      return false;
    }
  }

  /// Delete files older than a specified duration
  /// 
  /// Example:
  /// ```dart
  /// // Delete files older than 7 days in the temp directory
  /// await FileManager.deleteOldFiles(
  ///   '/path/to/temp',
  ///   Duration(days: 7),
  /// );
  /// ```
  static Future<int> deleteOldFiles(
    String directoryPath,
    Duration maxAge,
  ) async {
    int deletedCount = 0;

    try {
      final directory = Directory(directoryPath);

      if (!await directory.exists()) {
        return 0;
      }

      final cutoffTime = DateTime.now().subtract(maxAge);
      final List<FileSystemEntity> entities =
          await directory.list(recursive: false).toList();

      for (var entity in entities) {
        if (entity is File) {
          final stat = await entity.stat();
          if (stat.modified.isBefore(cutoffTime)) {
            if (await deleteFileObject(entity)) {
              deletedCount++;
            }
          }
        }
      }

      debugPrint(
          'Deleted $deletedCount old files from $directoryPath');
    } catch (e) {
      debugPrint('Error deleting old files: $e');
    }

    return deletedCount;
  }

  /// Get the application documents directory
  /// 
  /// This is where you can safely store user files
  static Future<Directory> getAppDocumentsDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  /// Get the temporary directory
  /// 
  /// Files here can be deleted by the system at any time
  static Future<Directory> getTempDirectory() async {
    return await getTemporaryDirectory();
  }

  /// Pick a file using the file picker and return its path
  /// 
  /// Example usage in a widget:
  /// ```dart
  /// String? filePath = await FileManager.pickFile();
  /// if (filePath != null) {
  ///   // Use the file
  /// }
  /// ```
  static Future<String?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        return result.files.single.path!;
      }
      return null;
    } catch (e) {
      debugPrint('Error picking file: $e');
      return null;
    }
  }

  /// Pick and delete a file in one operation
  /// 
  /// Useful for demos or testing
  static Future<bool> pickAndDeleteFile() async {
    try {
      String? filePath = await pickFile();

      if (filePath != null) {
        return await deleteFile(filePath);
      }
      return false;
    } catch (e) {
      debugPrint('Error in pickAndDeleteFile: $e');
      return false;
    }
  }

  /// Check if a file exists
  static Future<bool> fileExists(String filePath) async {
    try {
      return await File(filePath).exists();
    } catch (e) {
      debugPrint('Error checking file existence: $e');
      return false;
    }
  }

  /// Get file size in bytes
  static Future<int> getFileSize(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.length();
      }
      return 0;
    } catch (e) {
      debugPrint('Error getting file size: $e');
      return 0;
    }
  }

  /// Delete a file only if it matches certain criteria (e.g., size, extension)
  /// 
  /// Example:
  /// ```dart
  /// await FileManager.deleteFileIfMatches(
  ///   '/path/to/file.tmp',
  ///   extension: '.tmp',
  ///   maxSizeBytes: 1024 * 1024, // 1MB
  /// );
  /// ```
  static Future<bool> deleteFileIfMatches(
    String filePath, {
    String? extension,
    int? maxSizeBytes,
  }) async {
    try {
      final file = File(filePath);

      if (!await file.exists()) {
        return false;
      }

      // Check extension if provided
      if (extension != null && !filePath.endsWith(extension)) {
        debugPrint('File extension does not match: $filePath');
        return false;
      }

      // Check size if provided
      if (maxSizeBytes != null) {
        final size = await file.length();
        if (size > maxSizeBytes) {
          debugPrint('File size exceeds maximum: $filePath ($size bytes)');
          return false;
        }
      }

      // All checks passed, delete the file
      return await deleteFileObject(file);
    } catch (e) {
      debugPrint('Error in deleteFileIfMatches: $e');
      return false;
    }
  }
}
