import 'package:flutter/material.dart';
import 'package:found_you_app/ui/common_widgets/neo_app_bar.dart';
import 'package:found_you_app/ui/common_widgets/neo_card.dart';

class TermsOfUseView extends StatelessWidget {
  const TermsOfUseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeoAppBar(text: 'Zasady korzystania'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: NeoCard(
          child: Text(
            '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc interdum commodo nisi ac varius. Ut sed fringilla eros, et malesuada sem. Praesent tempor a erat ac convallis. Sed semper vulputate laoreet. Sed at vestibulum arcu. Fusce mattis elit felis, eu tempus neque condimentum non. Quisque imperdiet fringilla libero sed finibus. Morbi at sem velit. Duis sollicitudin porta ipsum in viverra. Sed et ullamcorper turpis. Sed laoreet lobortis libero, ac bibendum nisi bibendum in. Praesent efficitur nunc in justo convallis, eu tempor augue hendrerit.
    
    Etiam eleifend eu nisl quis mattis. Integer quis nisi egestas, tempor leo a, pellentesque urna. Quisque elit purus, facilisis at enim non, tempor luctus mauris. Etiam finibus, eros ac dapibus tristique, dui velit maximus felis, vitae maximus nisl arcu sagittis nisl. Nulla lacus justo, interdum sit amet vehicula vitae, gravida eu erat. Pellentesque vel rutrum nisi, non condimentum velit. Nulla facilisi.
    
    Proin efficitur imperdiet consectetur. Nullam vehicula volutpat lorem in eleifend. Vestibulum rutrum, ligula eu pharetra scelerisque, odio tortor interdum quam, nec varius mi sapien ut neque. Proin elementum ultrices lectus, sit amet pulvinar odio rhoncus vel. Praesent a purus sit amet dolor auctor elementum. Aenean maximus elementum lorem, in condimentum eros porta quis. Morbi eu mi ante. Maecenas enim arcu, convallis quis enim at, fringilla malesuada magna. Ut blandit iaculis scelerisque. Duis in nibh eu dui fermentum accumsan. Quisque in luctus quam.
    
    Aliquam pulvinar non massa eu convallis. Aliquam id augue dolor. Proin et arcu vitae metus tincidunt iaculis ut sed risus. Aenean suscipit a arcu non elementum. Nulla quis mattis eros. Nullam hendrerit justo ipsum, eget cursus mi lobortis in. Duis ornare felis non sollicitudin laoreet. Suspendisse velit orci, efficitur vel metus sed, aliquam posuere nulla. Ut commodo, velit sed varius molestie, enim sem tristique nisl, quis ornare turpis eros vel tellus. Nulla sagittis, dui sed cursus ultricies, ante sapien hendrerit enim, quis ullamcorper eros libero sit amet risus. Curabitur sit amet ligula aliquet, luctus turpis vel, tempor ipsum. Curabitur aliquam sapien sed fringilla ultrices. Vivamus tempus ultrices sapien a efficitur.
    
    Nunc nec dictum ante. Fusce neque dui, fermentum vel dapibus a, interdum tincidunt arcu. Vivamus risus orci, consectetur a augue ac, feugiat consectetur ante. Curabitur pharetra augue vel magna aliquam, eu ultricies purus convallis. In ac consectetur dui, quis cursus felis. Fusce vel libero quis justo luctus tempor a non leo. Proin pulvinar urna ac dui volutpat fringilla. Donec commodo eleifend orci sed euismod. Phasellus lorem ex, auctor ut lectus ut, auctor auctor nunc. Vivamus egestas egestas diam eu mattis. Vestibulum blandit urna turpis, eu elementum sapien convallis quis. Nam in eros non lacus ultrices ornare. Nam scelerisque sodales feugiat. Integer dignissim justo et imperdiet pretium.
    
    Aenean in volutpat odio, suscipit aliquam felis. Vivamus vestibulum, erat eu laoreet fermentum, eros odio cursus turpis, et rutrum mi enim id metus. Aenean eu magna viverra, tempus lectus at, commodo eros. Sed viverra, lorem vitae ornare finibus, nunc diam accumsan dui, et tristique libero tellus a dui. Aliquam congue eu tellus ut gravida. Aliquam erat volutpat. Aliquam tristique sagittis nunc, eu eleifend mauris vehicula quis. Morbi lacinia faucibus lorem, sit amet laoreet nisl pharetra in. Nulla fringilla diam porttitor, porttitor purus nec, aliquam arcu. Vestibulum ultrices elit in mi aliquam fermentum vitae scelerisque sapien.''',

            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
        ),
      ),
    );
  }
}
