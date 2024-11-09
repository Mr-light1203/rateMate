import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;

import 'forex_page.dart';
import 'payroll_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0; // Track the current index

  // List of pages for each tab
  final List<Widget> _pages = [
    HomePageContent(),
    ForexPage(),
    PayrollPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A2E),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white10,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Container(
                color: Colors.white.withOpacity(0.1),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Drawer Content',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: Container(
        height: 90,
        margin: EdgeInsets.only(bottom: 20, left: 40, right: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white10,
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 10,
              sigmaX: 10,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.5, vertical: 10),
              child: GNav(
                gap: 8,
                backgroundColor: Colors.transparent,
                color: Colors.white,
                tabBackgroundColor: Colors.black12,
                activeColor: Colors.white,
                padding: EdgeInsets.all(20),
                selectedIndex:
                    _selectedIndex, // Keep track of the selected index
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.swap_horiz,
                    text: 'Forex',
                  ),
                  GButton(
                    icon: Icons.monetization_on,
                    text: 'Payroll',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Separate widget for HomePageContent within homepage.dart
// homepage.dart

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            "Today's Rate",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16), // Spacing between title and search bar

          // Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search by country',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16), // Space between search bar and country panel

          // Scrollable Country Panel
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: ListView(
                children: [
                  CountryContainer(
                    currencyCode: 'USD',
                    countryName: 'United States',
                    flagImageUrl: 'https://www.countryflags.io/us/flat/64.png',
                  ),
                  CountryContainer(
                    currencyCode: 'NTD',
                    countryName: 'Taiwan',
                    flagImageUrl: 'https://www.countryflags.io/tw/flat/64.png',
                  ),
                  // Add more CountryContainer widgets for other currencies...
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Map<String, dynamic>> fetchExchangeData(
    String base, String target) async {
  // Fetch the latest exchange rate
  final latestResponse = await http.get(
    Uri.parse('https://api.frankfurter.app/latest?base=$base&symbols=$target'),
  );

  // Fetch the previous day's rate to calculate percentage change
  final previousResponse = await http.get(
    Uri.parse(
        'https://api.frankfurter.app/2024-11-07?base=$base&symbols=$target'),
  );

  if (latestResponse.statusCode == 200 && previousResponse.statusCode == 200) {
    final latestData = jsonDecode(latestResponse.body);
    final previousData = jsonDecode(previousResponse.body);

    final latestRate = latestData['rates'][target];
    final previousRate = previousData['rates'][target];
    final percentageChange = ((latestRate - previousRate) / previousRate) * 100;

    return {
      'rate': latestRate,
      'percentageChange': percentageChange,
    };
  } else {
    throw Exception('Failed to load exchange rate data');
  }
}

class CountryContainer extends StatelessWidget {
  final String currencyCode;
  final String countryName;
  final String flagImageUrl;

  const CountryContainer({
    required this.currencyCode,
    required this.countryName,
    required this.flagImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchExchangeData(currencyCode, 'PHP'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.data!;
          final rate = data['rate'];
          final percentageChange = data['percentageChange'];
          final isPositiveChange = percentageChange >= 0;

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Image.network(
                  flagImageUrl,
                  width: 40,
                  height: 40,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currencyCode,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '1 $currencyCode -> ${rate.toStringAsFixed(2)} PHP',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  '${percentageChange.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: isPositiveChange ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Open',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
