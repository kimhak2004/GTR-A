import 'package:flutter/material.dart';
import 'file_manager.dart';
import 'dart:io';

/// FileManagerDemo - A demonstration widget showing how to delete files
/// 
/// This widget provides a UI for demonstrating file deletion functionality.
/// It includes examples of:
/// - Deleting a single file
/// - Picking and deleting files
/// - Viewing deleted file history
class FileManagerDemo extends StatefulWidget {
  const FileManagerDemo({super.key});

  @override
  State<FileManagerDemo> createState() => _FileManagerDemoState();
}

class _FileManagerDemoState extends State<FileManagerDemo> {
  final List<String> _deletedFiles = [];
  String? _selectedFilePath;
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Deletion Demo'),
        backgroundColor: const Color(0xFF0F0F0F),
      ),
      body: Container(
        color: const Color(0xFF0F0F0F),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info Card
              _buildInfoCard(),
              const SizedBox(height: 24),

              // File Selection Card
              _buildFileSelectionCard(),
              const SizedBox(height: 24),

              // Quick Actions Card
              _buildQuickActionsCard(),
              const SizedBox(height: 24),

              // Deleted Files History
              _buildDeletedFilesHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: const Color(0xFF1A1A1A),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: const Color(0xFF00D9FF)),
                const SizedBox(width: 8),
                Text(
                  'How to Delete Files in Code',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF00D9FF),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'File deletion in Dart/Flutter is done using the dart:io library. '
              'Here are the key methods:',
              style: TextStyle(color: Color(0xFFE0E0E0)),
            ),
            const SizedBox(height: 12),
            _buildCodeExample(
              'Delete a single file:',
              "await File('/path/to/file.txt').delete();",
            ),
            const SizedBox(height: 8),
            _buildCodeExample(
              'Check if file exists first:',
              "if (await file.exists()) {\n  await file.delete();\n}",
            ),
            const SizedBox(height: 8),
            _buildCodeExample(
              'Using FileManager utility:',
              "await FileManager.deleteFile(filePath);",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeExample(String title, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFB0B0B0),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F0F),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF2A2A2A)),
          ),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Color(0xFF00D9FF),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileSelectionCard() {
    return Card(
      color: const Color(0xFF1A1A1A),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected File',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 12),
            if (_selectedFilePath != null) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.insert_drive_file,
                        color: Color(0xFF00D9FF)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _selectedFilePath!,
                        style: const TextStyle(color: Color(0xFFE0E0E0)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isProcessing ? null : _deleteSelectedFile,
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete This File'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              const Text(
                'No file selected. Use "Pick a File" button below.',
                style: TextStyle(color: Color(0xFFB0B0B0)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return Card(
      color: const Color(0xFF1A1A1A),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isProcessing ? null : _pickFile,
                    icon: const Icon(Icons.file_open),
                    label: const Text('Pick a File'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isProcessing ? null : _pickAndDeleteFile,
                    icon: const Icon(Icons.delete_sweep),
                    label: const Text('Pick & Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _isProcessing ? null : _cleanupTempFiles,
              icon: const Icon(Icons.cleaning_services),
              label: const Text('Cleanup Old Temp Files'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00D9FF),
                foregroundColor: const Color(0xFF0F0F0F),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeletedFilesHistory() {
    return Card(
      color: const Color(0xFF1A1A1A),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Deleted Files History',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                if (_deletedFiles.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _deletedFiles.clear();
                      });
                    },
                    child: const Text('Clear'),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (_deletedFiles.isEmpty)
              const Text(
                'No files deleted yet.',
                style: TextStyle(color: Color(0xFFB0B0B0)),
              )
            else
              ...(_deletedFiles.reversed.take(10).map((filePath) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle,
                          color: Colors.green, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          filePath,
                          style: const TextStyle(
                            color: Color(0xFFE0E0E0),
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              })),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFile() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      String? filePath = await FileManager.pickFile();

      if (filePath != null) {
        setState(() {
          _selectedFilePath = filePath;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File selected: $filePath')),
          );
        }
      }
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _deleteSelectedFile() async {
    if (_selectedFilePath == null) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      bool success = await FileManager.deleteFile(_selectedFilePath!);

      if (success) {
        setState(() {
          _deletedFiles.add(_selectedFilePath!);
          _selectedFilePath = null;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File deleted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to delete file.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _pickAndDeleteFile() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      String? filePath = await FileManager.pickFile();

      if (filePath != null) {
        bool success = await FileManager.deleteFile(filePath);

        if (success) {
          setState(() {
            _deletedFiles.add(filePath);
          });
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('File picked and deleted successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to delete file.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      }
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  Future<void> _cleanupTempFiles() async {
    setState(() {
      _isProcessing = true;
    });

    try {
      final tempDir = await FileManager.getTempDirectory();
      final count = await FileManager.deleteOldFiles(
        tempDir.path,
        const Duration(days: 7),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cleaned up $count old temporary files.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error cleaning up files: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }
}
