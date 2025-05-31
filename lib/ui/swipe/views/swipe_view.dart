import 'package:flutter/material.dart';
import 'package:found_you_app/ui/swipe/view_models/swipe_view_model.dart';

class SwapView extends StatelessWidget {
  final SwapViewModel model = SwapViewModel();

  SwapView({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = model.currentProfile;

    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Near You', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Image.network(profile.imageUrl,
                          width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${profile.name}, ${profile.age}',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(profile.location,
                                    style: const TextStyle(color: Colors.black54)),
                                IconButton(
                                  icon: const Icon(Icons.download_outlined),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _actionButton(Icons.close, Colors.white),
                            const SizedBox(width: 20),
                            _actionButton(Icons.favorite, Colors.pink.shade200),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: model.bottomButtons
                  .map((btn) => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: btn.bgColor,
                ),
                onPressed: () {},
                child: Icon(btn.icon, color: Colors.black54),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(IconData icon, Color color) => Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow()]),
    child: Icon(icon, size: 30, color: Colors.black87),
  );
}
