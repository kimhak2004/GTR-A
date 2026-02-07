
class CVData {
  static const String fullName = 'Kao Kimhak';
  static const String professionalTitle = 'Telecommunication and Network Engineer';
  static const String bio =
      'Passionate about leveraging technology to drive innovation and solve complex problems in the telecommunications industry. Experienced in network design, optimization, and management, with a strong foundation in both theoretical and practical aspects of telecommunication systems.';
  
  static const String profileImageUrl =
      'assets/personal.jpg';
  static const String backgroundImage = 
      'assets/itc_logo.png';
  static const String background = 
      'itc_logo.png';

  static const String email = 'kaokimhak2019@email.com';
  static const String phone = '+855 93 391 505';
  static const String location = 'Phnom Penh, Cambodia';
  static const String linkedIn = 'https://www.linkedin.com/in/kaokim-hak-38262b288 ';
  static const String github = 'https://github.com/kimhak2004/GTR-A';
  static const String telegram = 'https://t.me/@kimhak2004';
  
  // About section
  static const String aboutTitle = 'About Me';
  static const String aboutContent =
      'Experienced Telecommunication and Network Engineer with a strong background in designing, implementing, and managing complex network infrastructures.\n'
      'Proficient in various networking protocols and technologies, with a passion for staying updated with the latest industry trends.\n'
      'Adept at troubleshooting and optimizing network performance to ensure seamless communication and connectivity.\n'
      'Committed to delivering high-quality solutions that meet organizational goals and enhance user experience.\n';
  // Education section
  static final List<Education> education = [
    Education(
      degree: 'Engineering in telecommunication\'s Degree',
      school: 'Institute of Technology of Cambodia (ITC)',
      year: '2022 - Present',
      details: 'Expected Graduation: 2026, GPA: 3.7/4.0',
    ),
    Education(
      degree: 'High School Diploma',
      school: 'Prey Hanus High School',
      year: '2019 - 2022',
      details: 'Graduated with Honors.',
    ),
  ];
  
  // Experience section
  static final List<Experience> experience = [
    Experience(
      title: 'Network Engineer Intern',
      company: 'TechNet Solutions',
      year: '2025 - Present',
      description:
          'Assisting in the design and implementation of network solutions for clients. Conducting network performance analysis and troubleshooting connectivity issues.',
    ),
    Experience(
      title: 'Electrician panel Intern',
      company: 'Taing Kim Sreng co.,Ltd.',
      year: 'Two weeks in August 2025',
      description:
          'Assisted in the installation and maintenance of electrical panels. Gained hands-on experience in wiring, circuit testing, and safety protocols.',
    ),
    Experience(
      title: 'Agency Insurance. ',
      company: 'FWD Cambodia',
      year: '2025 - Present',
      description:
          'Providing insurance solutions and customer service. Developed strong communication and problem-solving skills while assisting clients with their insurance needs.',
    ),
  ];
  
  // Skills section
  static final Map<String, List<String>> skills = {
    'Frontend': ['Flutter'],
    'Backend': ['firebase', 'csv', 'Dart', 'python'],
    'Tools & Platforms': ['Git', 'Firebase'],
    'Soft Skills': ['Team Leadership', 'Problem Solving', 'Communication', 'Mentoring'],
  };
  
  // Projects section
  static final List<Project> projects = [
    Project(
      title: 'Smart Assistant clock',
      description: 'A voice-activated smart clock application with alarm, weather updates, and reminders',
      tags: ['Flutter', 'Firebase', 'Dart'],
      link: 'https://github.com/kimhak2004/GTR-A',
    ),
    Project(
      title: 'TO DO saving App',
      description: 'A task management app that allows users to create, edit, and delete to-do lists with cloud synchronization',
      tags: ['Flutter', 'Firebase', 'Dart','sqflite'],
      link: 'https://github.com/kimhak2004/GTR-A',
    ),
    Project(
      title: 'Mobile App',
      description: 'Cross-platform mobile application for CV showcasing using Flutter framework',
      tags: ['Flutter', 'Dart'],
      link: 'https://github.com/kimhak2004/GTR-A',
    ),
    
  ];
}

class Education {
  final String degree;
  final String school;
  final String year;
  final String details;
  
  Education({
    required this.degree,
    required this.school,
    required this.year,
    required this.details,
  });
}

class Experience {
  final String title;
  final String company;
  final String year;
  final String description;
  
  Experience({
    required this.title,
    required this.company,
    required this.year,
    required this.description,
  });
}

class Project {
  final String title;
  final String description;
  final List<String> tags;
  final String link;
  
  Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.link,
  });
}
