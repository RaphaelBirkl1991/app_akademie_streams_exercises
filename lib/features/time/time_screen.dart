import 'package:flutter/material.dart';
import 'package:streams_exercises/features/time/time_repository.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({
    super.key,
    required this.timeRepository,
  });

  final TimeRepository timeRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Screen'),
      ),
      body: Center(
        child: StreamBuilder<DateTime>(
          stream: timeRepository.dateTimeStream,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return Text("${snapshot.data}");
            } else if (snapshot.hasError) {
              return const Text("An error occured");
            } else {
              return const CircularProgressIndicator();
            }
          }),
        ),
      ),
    );
  }
}
