import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String catFact = "Welcome to Catto! Click the button below to get a random cat fact and image.";
  // Use a simple static image that loads faster
  String catImageUrl = "https://cataas.com/cat/says/Welcome?fontSize=24&fontColor=white&width=300&height=250";
  bool isLoading = false;
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    // Don't automatically fetch data - let user click the button first
  }

  Future<void> fetchCatData() async {
    setState(() {
      isLoading = true;
      isFirstLoad = false; // Mark that we've started fetching data
    });

    try {
      // Fetch cat fact from MeowFacts API
      final factResponse = await http.get(
        Uri.parse('https://meowfacts.herokuapp.com/'),
        headers: {'Accept': 'application/json'},
      );
      
      // Fetch random cat image from Cataas API
      final imageResponse = await http.get(
        Uri.parse('https://cataas.com/cat?json=true'),
        headers: {'Accept': 'application/json'},
      );

      print('Fact Response Status: ${factResponse.statusCode}');
      print('Image Response Status: ${imageResponse.statusCode}');
      print('Image Response Body: ${imageResponse.body}');

      if (factResponse.statusCode == 200 && imageResponse.statusCode == 200) {
        final factData = jsonDecode(factResponse.body);
        final imageData = jsonDecode(imageResponse.body);
        
        print('Parsed Image Data: $imageData');
        
        setState(() {
          // Extract fact from MeowFacts API response
          if (factData['data'] != null && factData['data'].isNotEmpty) {
            catFact = factData['data'][0];
          } else {
            catFact = "Here's a purr-fect fact: Cats are amazing!";
          }
          
          // Extract image URL from Cataas API response
          // The response includes the full URL
          if (imageData['url'] != null) {
            catImageUrl = imageData['url'] as String;
            print('Set Cat Image URL: $catImageUrl');
          } else {
            catImageUrl = "";
            print('No image URL found in response');
          }
          
          isLoading = false;
        });
      } else {
        print('API Error - Fact Status: ${factResponse.statusCode}, Image Status: ${imageResponse.statusCode}');
        setState(() {
          catFact = "Failed to load cat fact. Please try again!";
          isLoading = false;
        });
      }
    } catch (e) {
      print('Exception in fetchCatData: $e');
      setState(() {
        catFact = "Failed to load cat fact. Please try again!";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff8DC2D2),
        title: Text(
          "Catto!",
          style: TextStyle(
            color: Color(0xff347093),
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Cat Image Container
              Container(
                padding: EdgeInsets.all(12),
                height: 250,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: catImageUrl.isNotEmpty
                      ? Image.network(
                          catImageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Color(0xff8DC2D2),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            print('Image loading error: $error');
                            print('Failed URL: $catImageUrl');
                            return Container(
                              color: Color(0xff8DC2D2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Failed to load image",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Color(0xff8DC2D2),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.pets,
                                size: 50,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Loading cat...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xff8DC2D2),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: isLoading
                    ? Column(
                        children: [
                          CircularProgressIndicator(color: Colors.white),
                          SizedBox(height: 10),
                          Text(
                            "Fetching the purr-fact...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        catFact,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
              
              SizedBox(height: 30),
              
              // Get New Fact Button
              ElevatedButton.icon(
                onPressed: isLoading ? null : fetchCatData,
                icon: Icon(Icons.auto_awesome),
                label: Text(
                  isLoading ? "Loading..." : isFirstLoad ? "Get My First Cat Fact!" : "Get New Cat Fact",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff347093),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}