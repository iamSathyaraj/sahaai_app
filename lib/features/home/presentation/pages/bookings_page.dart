

import 'package:flutter/material.dart';
import 'package:sahaai/features/home/presentation/pages/rating_screen.dart';

class BookingHomePage extends StatelessWidget {
  const BookingHomePage({super.key});

  static const Color topGreen = Color(0xFF285954);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: topGreen,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 140,
              width: double.infinity,
              color: topGreen,
            ),

            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    top: 40,
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 260 , 16, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Booking History',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10),
                            HistoryBookingCard(
                              serviceName: 'Laundry Service',
                              dateTimeText: 'Oct 21, 2024 | 7:30 A.M',
                              amountText: 'Amount  250',
                              statusText: 'Completed',
                            ),
                            SizedBox(height: 8),
                            HistoryBookingCard(
                              serviceName: 'Laundry Service',
                              dateTimeText: 'Oct 18, 2024 | 6:00 P.M',
                              amountText: 'Amount  200',
                              statusText: 'Completed',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topCenter,
                    child: Transform.translate(
                      offset: const Offset(0, -65), 
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _CurrentBookingCard(), 
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class  _CurrentBookingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const Color statusColor = Color(0xFF137A4F); 

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 350,
        minHeight: 0
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: Color(0xFFE0E0E0),
                      child: Icon(Icons.local_laundry_service,
                          size: 18, color: Colors.grey),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Laundry Service',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Rahul',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          'Worker',
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'IN PROGRESS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
      
            const SizedBox(height: 14),
      
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Color(0xFFE0E0E0),
                  child: Icon(Icons.location_on_outlined,
                      size: 18, color: Colors.redAccent),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Odunsi Junction - Kiosk Lane',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '32, kullikul way - Onipanu',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      
            const SizedBox(height: 14),
      
            Row(
              children: const [
                Text(
                  'Date and Time',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                Spacer(),
                Text(
                  'Oct 21, 2024 | 7:30 A.M',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
      
            const SizedBox(height: 10),
      
            
            Container(
              height: 105,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
      
            const SizedBox(height: 10),
      
            Row(
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RatingScreen()));
                  },
                  child: const Text(
                    '★ Rate',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF2566AF),
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {

                  },
                  child: const Text(
                    'View Details',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


  class HistoryBookingCard extends StatelessWidget {
    final String serviceName;
    final String dateTimeText;
    final String amountText;
    final String statusText;

    const HistoryBookingCard({
      super.key,
      required this.serviceName,
      required this.dateTimeText,
      required this.amountText,
      required this.statusText,
    });

    @override
    Widget build(BuildContext context) {
      const Color statusBg = Color(0xFFE4F4E9);
      const Color statusTextColor = Color(0xFF167D48);

      return Container(
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFFE0E0E0),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateTimeText,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    amountText,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                statusText,
                style: const TextStyle(
                  color: statusTextColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

