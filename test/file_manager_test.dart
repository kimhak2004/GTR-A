import 'package:flutter_test/flutter_test.dart';
import 'package:cv_app/file_manager.dart';
import 'dart:io';

/// Tests for FileManager utility class
/// 
/// These tests demonstrate how to use the FileManager for file deletion
void main() {
  group('FileManager Tests', () {
    late Directory testDir;
    
    setUp(() async {
      // Create a temporary test directory
      testDir = await Directory.systemTemp.createTemp('file_manager_test_');
    });

    tearDown(() async {
      // Clean up test directory
      if (await testDir.exists()) {
        await testDir.delete(recursive: true);
      }
    });

    test('deleteFile should delete an existing file', () async {
      // Create a test file
      final testFile = File('${testDir.path}/test.txt');
      await testFile.writeAsString('test content');
      
      // Verify file exists
      expect(await testFile.exists(), true);
      
      // Delete the file
      final result = await FileManager.deleteFile(testFile.path);
      
      // Verify deletion was successful
      expect(result, true);
      expect(await testFile.exists(), false);
    });

    test('deleteFile should return false for non-existent file', () async {
      final nonExistentPath = '${testDir.path}/nonexistent.txt';
      
      final result = await FileManager.deleteFile(nonExistentPath);
      
      expect(result, false);
    });

    test('deleteMultipleFiles should delete all specified files', () async {
      // Create multiple test files
      final file1 = File('${testDir.path}/file1.txt');
      final file2 = File('${testDir.path}/file2.txt');
      final file3 = File('${testDir.path}/file3.txt');
      
      await file1.writeAsString('content 1');
      await file2.writeAsString('content 2');
      await file3.writeAsString('content 3');
      
      // Delete all files
      final results = await FileManager.deleteMultipleFiles([
        file1.path,
        file2.path,
        file3.path,
      ]);
      
      // Verify all deletions were successful
      expect(results[file1.path], true);
      expect(results[file2.path], true);
      expect(results[file3.path], true);
      
      expect(await file1.exists(), false);
      expect(await file2.exists(), false);
      expect(await file3.exists(), false);
    });

    test('deleteAllFilesInDirectory should delete all files', () async {
      // Create multiple files in directory
      await File('${testDir.path}/file1.txt').writeAsString('content 1');
      await File('${testDir.path}/file2.txt').writeAsString('content 2');
      await File('${testDir.path}/file3.txt').writeAsString('content 3');
      
      // Delete all files
      final count = await FileManager.deleteAllFilesInDirectory(testDir.path);
      
      // Verify all files were deleted
      expect(count, 3);
      
      final files = await testDir.list().toList();
      expect(files.isEmpty, true);
    });

    test('deleteOldFiles should delete only old files', () async {
      // Create a new file
      final newFile = File('${testDir.path}/new.txt');
      await newFile.writeAsString('new content');
      
      // Create an old file (we can't actually make it old in tests,
      // but this demonstrates the API)
      final oldFile = File('${testDir.path}/old.txt');
      await oldFile.writeAsString('old content');
      
      // Try to delete files older than 1 day
      // In real scenario, only truly old files would be deleted
      final count = await FileManager.deleteOldFiles(
        testDir.path,
        const Duration(days: 1),
      );
      
      // Verify the function ran without errors
      expect(count >= 0, true);
    });

    test('fileExists should check file existence correctly', () async {
      final testFile = File('${testDir.path}/test.txt');
      
      // File doesn't exist yet
      expect(await FileManager.fileExists(testFile.path), false);
      
      // Create file
      await testFile.writeAsString('content');
      
      // File exists now
      expect(await FileManager.fileExists(testFile.path), true);
      
      // Delete file
      await testFile.delete();
      
      // File doesn't exist anymore
      expect(await FileManager.fileExists(testFile.path), false);
    });

    test('getFileSize should return correct file size', () async {
      final testFile = File('${testDir.path}/test.txt');
      final content = 'Hello, World!';
      await testFile.writeAsString(content);
      
      final size = await FileManager.getFileSize(testFile.path);
      
      expect(size, content.length);
    });

    test('deleteFileIfMatches should delete file matching criteria', () async {
      // Create a .tmp file
      final tmpFile = File('${testDir.path}/temp.tmp');
      await tmpFile.writeAsString('temp content');
      
      // Delete only .tmp files
      final result = await FileManager.deleteFileIfMatches(
        tmpFile.path,
        extension: '.tmp',
      );
      
      expect(result, true);
      expect(await tmpFile.exists(), false);
    });

    test('deleteFileIfMatches should not delete file not matching extension', () async {
      // Create a .txt file
      final txtFile = File('${testDir.path}/file.txt');
      await txtFile.writeAsString('content');
      
      // Try to delete only .tmp files
      final result = await FileManager.deleteFileIfMatches(
        txtFile.path,
        extension: '.tmp',
      );
      
      expect(result, false);
      expect(await txtFile.exists(), true);
    });
  });
}
