import 'package:flutter/material.dart';
import 'package:frontend/utils/shared.dart';
import 'package:frontend/views/users/agent/side_bar.dart';

class AgentHolder extends StatefulWidget {
  const AgentHolder({super.key});

  @override
  State<AgentHolder> createState() => _AgentHolderState();
}

class _AgentHolderState extends State<AgentHolder> {
  @override
  void initState() {
    agentPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    agentPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: <Widget>[
            const AgentSideBar(),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: darkColor),
                child: PageView.builder(
                  controller: agentPageController,
                  itemBuilder: (BuildContext context, int index) => agentScreens[index],
                  itemCount: agentScreens.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
