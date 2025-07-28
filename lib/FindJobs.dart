import 'package:flutter/material.dart';

class Findjobs extends StatefulWidget {
  const Findjobs({super.key});

  @override
  State<Findjobs> createState() => _FindjobsState();
}

class _FindjobsState extends State<Findjobs> {
  final List<Job> jobs = [
    Job(
      title: 'Aerial Photography Drone Pilot',
      pay: '₹1500/hour',
      location: 'Mumbai',
      type: 'Full-time',
      imageUrl: 'https://images.unsplash.com/photo-1464983953574-0892a716854b', // Placeholder
      applied: true,
    ),
    Job(
      title: 'Drone Pilot for Surveying',
      pay: '₹1200/hour',
      location: 'Bangalore',
      type: 'Part-time',
      imageUrl: 'https://images.unsplash.com/photo-1465101178521-c1a152f8a61d', // Placeholder
      applied: false,
    ),
    Job(
      title: 'Delivery Drone Operator',
      pay: '₹1000/hour',
      location: 'Delhi',
      type: 'Full-time',
      imageUrl: 'https://images.unsplash.com/photo-1519681393794-d120267933ba', // Placeholder
      applied: false,
    ),
    Job(
      title: 'Drone Inspection Specialist',
      pay: '₹3000/hour',
      location: 'Chennai',
      type: 'Contract',
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb', // Placeholder
      applied: false,
    ),
  ];

  final categories = ['Photography', 'Survey', 'Delivery', 'Inspection'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 375,
          child: Column(
            children: [
              SizedBox(height: 40),
              // App Bar Row
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {},
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Find Jobs',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Spacer(),
                  Icon(Icons.grid_view),
                  SizedBox(width: 12),
                ],
              ),
              // Search Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search for jobs',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
              ),
              // Category Filters
              Container(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  separatorBuilder: (_, __) => SizedBox(width: 8),
                  itemCount: categories.length,
                  itemBuilder: (context, i) {
                    return Chip(
                      label: Text(categories[i]),
                      backgroundColor: i == 0 ? Color(0xFF8763FF) : Colors.grey[200],
                      labelStyle: TextStyle(
                          color: i == 0 ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600),
                    );
                  },
                ),
              ),
              // Jobs List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: jobs.length,
                  itemBuilder: (context, i) {
                    final job = jobs[i];
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Container(
                            width: 85,
                            height: 85,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            child: Image.network(job.imageUrl, fit: BoxFit.cover),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(job.title,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Text(job.pay, style: TextStyle(color: Colors.grey[700])),
                                      SizedBox(width: 10),
                                      Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                                      SizedBox(width: 2),
                                      Text(job.location, style: TextStyle(fontSize: 13)),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(job.type, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: job.applied
                                ? Container(
                              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
                              decoration: BoxDecoration(
                                color: Color(0xFF8763FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text('Applied',
                                  style: TextStyle(color: Colors.white)),
                            )
                                : OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Color(0xFF8763FF)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Apply',
                                style: TextStyle(color: Color(0xFF8763FF)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Job {
  final String title, pay, location, type, imageUrl;
  final bool applied;
  Job({
    required this.title,
    required this.pay,
    required this.location,
    required this.type,
    required this.imageUrl,
    this.applied = false,
  });
}
