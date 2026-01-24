/// CV Data Models - Edit these to customize your CV content
/// 
/// This file contains all the data structures for your CV.
/// Simply edit the values below to update your CV content.

class CVData {
  static const String fullName = 'Kao Kimhak';
  static const String professionalTitle = 'Full Stack Developer & Designer';
  static const String bio =
      'Crafting elegant solutions to complex problems. Passionate about web development, user experience, and continuous learning.';
  
  static const String profileImageUrl =
      'assets/personal.jpg';
  static const String backgroundImage = 
      'assets/itc_logo.png';

  static const String email = 'kaokimhak2019@email.com';
  static const String phone = '+855 93 391 505';
  static const String location = 'Phnom Penh, Cambodia';
  static const String linkedIn = 'https://www.linkedin.com/in/kaokim-hak-38262b288 ';
  static const String github = 'https://github.com/kaokimhak';
  static const String telegram = 'https://t.me/@kimhak2004';
  
  // About section
  static const String aboutTitle = 'About Me';
  static const String aboutContent =
      'I\'m a passionate developer with a keen eye for design. With experience in web development, I\'ve worked with startups and established companies to build scalable, user-friendly applications.\n\n'
      'My expertise spans across modern web technologies including React, TypeScript, Node.js, and cloud platforms. I believe in writing clean, maintainable code and creating intuitive user experiences.\n\n'
      'When I\'m not coding, you can find me exploring new technologies, contributing to open-source projects, or sharing knowledge with the developer community.';
  
  // Education section
  static final List<Education> education = [
    Education(
      degree: 'Master of Science in Computer Science',
      school: 'Stanford University',
      year: '2019 - 2021',
      details: 'Specialized in Machine Learning and Distributed Systems',
    ),
    Education(
      degree: 'Bachelor of Science in Computer Science',
      school: 'University of California, Berkeley',
      year: '2015 - 2019',
      details: 'Graduated with Honors, GPA: 3.8/4.0',
    ),
  ];
  
  // Experience section
  static final List<Experience> experience = [
    Experience(
      title: 'Senior Full Stack Developer',
      company: 'Tech Innovations Inc.',
      year: '2021 - Present',
      description:
          'Led development of microservices architecture serving 1M+ users. Mentored junior developers and established coding standards.',
    ),
    Experience(
      title: 'Full Stack Developer',
      company: 'Digital Solutions Ltd.',
      year: '2019 - 2021',
      description:
          'Developed and maintained multiple React applications with Node.js backends. Improved performance by 40% through optimization.',
    ),
    Experience(
      title: 'Junior Developer',
      company: 'StartUp Ventures',
      year: '2018 - 2019',
      description:
          'Built responsive web applications using React and contributed to API development with Express.js.',
    ),
  ];
  
  // Skills section
  static final Map<String, List<String>> skills = {
    'Frontend': ['React', 'TypeScript', 'Tailwind CSS', 'Next.js', 'Vue.js'],
    'Backend': ['Node.js', 'Express', 'Python', 'PostgreSQL', 'MongoDB'],
    'Tools & Platforms': ['Git', 'Docker', 'AWS', 'CI/CD', 'GraphQL'],
    'Soft Skills': ['Team Leadership', 'Problem Solving', 'Communication', 'Mentoring'],
  };
  
  // Projects section
  static final List<Project> projects = [
    Project(
      title: 'E-Commerce Platform',
      description: 'Full-stack e-commerce solution with real-time inventory management',
      tags: ['React', 'Node.js', 'PostgreSQL', 'Stripe'],
      link: 'https://github.com',
    ),
    Project(
      title: 'Analytics Dashboard',
      description: 'Real-time data visualization dashboard for business intelligence',
      tags: ['React', 'D3.js', 'Python', 'AWS'],
      link: 'https://github.com',
    ),
    Project(
      title: 'Mobile App',
      description: 'Cross-platform mobile application for task management',
      tags: ['React Native', 'Firebase', 'Redux'],
      link: 'https://github.com',
    ),
    Project(
      title: 'Open Source Library',
      description: 'Utility library for React hooks with 10k+ GitHub stars',
      tags: ['TypeScript', 'React', 'npm'],
      link: 'https://github.com',
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
