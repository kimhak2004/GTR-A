import 'package:flutter/material.dart';
import 'models.dart';
import 'package:url_launcher/url_launcher.dart';

class CVPage extends StatefulWidget {
  const CVPage({super.key});

  @override
  State<CVPage> createState() => _CVPageState();
}

class _CVPageState extends State<CVPage> {
  String activeSection = 'about';
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  void _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(CVData.background),//change image background here
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              const Color.fromARGB(255, 252, 252, 252).withValues(alpha: 0.8),
              BlendMode.dstATop,
            ),
          ),
        ),

  child: SingleChildScrollView(
    controller: _scrollController,
    child: Column(
      children: [
        // Hero Section
        _buildHeroSection(),
        // Main Content
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 32.0),
          child: _buildActiveSection(),
        ),
        // Footer
        _buildFooter(),
      ],
    ),
  ),
),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('My-CV'),
      elevation: 0,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: const Color.fromARGB(255, 11, 11, 11),
          height: 1,
        ),
      ),
      actions: [
        // Navigation buttons for desktop/tablet
        if (MediaQuery.of(context).size.width > 600)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: _buildNavButtons(),
            ),
          ),
        // Social icons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.email,
                    color: Color.fromARGB(255, 6, 222, 255)),
                onPressed: () => _launchUrl('mailto:${CVData.email}'),
              ),
              IconButton(
                icon: const Icon(Icons.language, color: Color(0xFF00D9FF)),
                onPressed: () => _launchUrl(CVData.linkedIn),
              ),
              IconButton(
                icon: const Icon(Icons.code, color: Color(0xFF00D9FF)),
                onPressed: () => _launchUrl(CVData.github),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildNavButtons() {
    final sections = [
      ('about', 'About'),
      ('education', 'Education'),
      ('experience', 'Experience'),
      ('skills', 'Skills'),
      ('projects', 'Projects'),
    ];

    return sections
        .map((section) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                onPressed: () => setState(() => activeSection = section.$1),
                child: Text(
                  section.$2,
                  style: TextStyle(
                    color: activeSection == section.$1
                        ? const Color.fromARGB(255, 6, 213, 250)
                        : const Color(0xFFB0B0B0),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ))
        .toList();
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.asset('assets/itc_logo.png').image,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            const Color.fromARGB(255, 82, 118, 130).withValues(alpha: 0.6),
            BlendMode.darken,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Image
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 70, 180, 210).withValues(alpha: 0.75),
                  width: 3,
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  CVData.profileImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color.fromARGB(255, 130, 206, 219),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Color.fromARGB(255, 75, 113, 120),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Name
            const Text(
              CVData.fullName,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'IBMPlexSerif',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Professional Title
            const Text(
              CVData.professionalTitle,
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 246, 244, 244),
                fontWeight: FontWeight.w900,
                fontFamily: 'IBMPlexSans',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Bio
            const SizedBox(
              width: 600,
              child: Text(
                CVData.bio,
                style: TextStyle(
                  fontSize: 19,
                  color: Color.fromARGB(255, 255, 255, 255),
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'IBMPlexSans',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            // CTA Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => activeSection = 'about'),
                  child: const Text('Explore My Work'),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF00E5FF)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Download CV feature coming soon')),
                    );
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('Download CV'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveSection() {
    switch (activeSection) {
      case 'about':
        return _buildAboutSection();
      case 'education':
        return _buildEducationSection();
      case 'experience':
        return _buildExperienceSection();
      case 'skills':
        return _buildSkillsSection();
      case 'projects':
        return _buildProjectsSection();
      default:
        return _buildAboutSection();
    }
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          CVData.aboutTitle,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
        ),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                CVData.aboutContent,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.8,
                      color: const Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.w500
                    ),
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Facts',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: const Color.fromARGB(255, 234, 234, 234),
                            ),
                      ),
                      const SizedBox(height: 16),
                      _buildQuickFact('Location:', CVData.location),
                      _buildQuickFact('Experience:', '1+ Years'),
                      _buildQuickFact('Specialization:', 'Mobile & Use AI'),
                      _buildQuickFact('Email:', CVData.email),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickFact(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Education',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: const Color.fromARGB(255, 0, 0, 0)
              ),
        ),
        const SizedBox(height: 24),
        ...CVData.education.map((edu) => Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 3,
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edu.degree,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      edu.school,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      edu.year,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      edu.details,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
        ),
        const SizedBox(height: 24),
        ...CVData.experience.map((exp) => Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exp.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        exp.company,
                        style: const TextStyle(
                          color: Color(0xFF00D9FF),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        exp.year,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        exp.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: const Color(0xFF00D9FF),
              ),
        ),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: CVData.skills.length,
          itemBuilder: (context, index) {
            final category = CVData.skills.keys.elementAt(index);
            final skillList = CVData.skills[category]!;
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: const Color.fromARGB(255, 6, 238, 255),
                          ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: skillList
                            .map((skill) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2A2A2A),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    skill,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFFE0E0E0),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProjectsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Projects',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
        ),
        const SizedBox(height: 24),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: CVData.projects.length,
          itemBuilder: (context, index) {
            final project = CVData.projects[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 4,
                      children: project.tags
                          .map((tag) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2A2A2A),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Text(
                                  tag,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFFB0B0B0),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => _launchUrl(project.link),
                      child: const Row(
                        children: [
                          Text('View Project'),
                          SizedBox(width: 4),
                          Icon(Icons.open_in_new, size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color(0xFF2A2A2A),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Let\'s work together on something amazing',
            style: Theme.of(context).textTheme.bodyMedium?.
            copyWith(color: const Color.fromARGB(255, 0, 0, 0)) ??
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => _launchUrl('mailto:${CVData.email}'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 0, 0),
                ),
                child: const Text('Email'),
              ),
              const SizedBox(width: 24),
              TextButton(
                onPressed: () => _launchUrl(CVData.linkedIn),
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 38, 0, 251),
                ),
                child: const Text('LinkedIn'),
              ),
              const SizedBox(width: 24),
              TextButton(
                onPressed: () => _launchUrl(CVData.github),
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                ),
                child: const Text('GitHub'),
              ),
              const SizedBox(width: 24),
              TextButton(
                onPressed: () => _launchUrl(CVData.telegram),
                style: TextButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 0, 0),
                ),
                child: const Text('Telegram'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
        ],
      ),
    );
  }

}
