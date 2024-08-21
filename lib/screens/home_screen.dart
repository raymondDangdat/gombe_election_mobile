import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gombe_election/providers/election_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Election Home"),
      ),
      body: SafeArea(child: Consumer<ElectionProvider>(
          builder: (ctx, electionProvider, child) {
          return  Column(
            children: [
              const SizedBox(height: 20,),
              Center(
                child: Text("${electionProvider.currentElectionStage} Stage", style: const TextStyle(
                  fontSize: 32, fontWeight: FontWeight.w700
                ),),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: electionProvider.candidatesList.length,
                    itemBuilder: (context, index){
                    final candidate = electionProvider.candidatesList[index];

                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10, left: 16, right: 16
                      ),
                      child: Text(candidate['name'], style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 20
                      ),),
                    );

                }),
              ),
            ],
          );
        }
      ))// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}