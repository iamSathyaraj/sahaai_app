import 'package:flutter/material.dart';

class RatingScreen extends StatefulWidget {
  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _selectedRating = 3;
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF20574B),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFF20574B),
        elevation: 0,
        title: Text('Rating', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(radius: 26, child: Icon(Icons.person, size: 32)),
                SizedBox(height: 8),
                Text('Vignesh', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 16),
                Text('How was work', style: TextStyle(fontSize: 18)),
                SizedBox(height: 8),
                Text(
                  'Your feedback will improve the work experience \n write your feedbacks',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return IconButton(
                      icon: Icon(
                        Icons.star,
                        color: index < _selectedRating ? Colors.amber : Colors.grey[300],
                        size: 32,
                      ),
                      onPressed: () {
                        setState(() {
                          _selectedRating = index + 1;
                        });
                      },
                    );
                  }),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: "Add comments",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF20574B),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                    ),
                    child: Text('Submit Review',style: TextStyle(color: Colors.white),),
                    onPressed: () {
                      
                    },
                  ),
                ),
              ],
            ), 
          ),
        ),
      ),
    );
  }
}


