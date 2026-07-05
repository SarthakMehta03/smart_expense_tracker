import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryCard extends StatelessWidget {
  final double balance;

  const SummaryCard({
    super.key,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 15,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            "Available Balance",
            style: GoogleFonts.poppins(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "₹${balance.toStringAsFixed(0)}",
            style: GoogleFonts.poppins(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.trending_up,
                color: Colors.green,
                size: 18,
              ),
              const SizedBox(width: 5),
              Text(
                "Updated automatically",
                style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontSize: 13,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}