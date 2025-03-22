import 'package:flutter/cupertino.dart';
import 'package:project02/core/shared_pref.dart';
import 'package:project02/core/yatta.dart';
import 'package:project02/widgets/favorite_icon.dart';

class CharacterScreen extends StatefulWidget {
  final String id;

  const CharacterScreen({super.key, required this.id});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  final Yatta yatta = Yatta();
  bool isLoading = true;
  Map<String, dynamic> characterDetail = {};
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _fetchCharacterDetail();
  }

  Future<void> _fetchCharacterDetail() async {
    try {
      final data = await yatta.getCharacterDetail(widget.id);
      setState(() {
        characterDetail = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        characterDetail = {};
      });
    }
  }

  RichText formatDescription(String description, List<dynamic>? params) {
    if (params != null && params.isNotEmpty) {
      final regex = RegExp(r'<unbreak>#(\d+)\[i\]</unbreak>');
      description = description.replaceAllMapped(regex, (match) {
        final paramIndex = int.parse(match.group(1)!) - 1;
        if (paramIndex >= 0 && paramIndex < params.length) {
          return params[paramIndex].toString();
        }
        return match[0]!;
      });
    }

    description = description.replaceAll(RegExp(r'<unbreak>.*?</unbreak>'), '');

    final lines = description.split('\n');
    final List<TextSpan> spans = [];

    for (final line in lines) {
      final parts = line.split(RegExp(r'(<u>.*?</u>)'));
      for (final part in parts) {
        if (part.startsWith('<u>') && part.endsWith('</u>')) {
          final text = part.substring(3, part.length - 4);
          spans.add(
            TextSpan(
              text: text,
              style: const TextStyle(decoration: TextDecoration.underline),
            ),
          );
        } else {
          spans.add(TextSpan(text: part));
        }
      }

      if (line != lines.last) {
        spans.add(const TextSpan(text: '\n'));
      }
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
          color: CupertinoColors.secondaryLabel,
        ),
        children: spans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SharedPref sharedPref = SharedPref();
    final characterName = characterDetail['name'] ?? 'Character';

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(characterName),
        trailing: FavoriteIcon(id: widget.id, sharedPref: sharedPref),
      ),
      child: SafeArea(
        child:
            isLoading
                ? const Center(child: CupertinoActivityIndicator())
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Image.network(
                            yatta.getGachaIconUrl(widget.id),
                            fit: BoxFit.contain,
                            errorBuilder:
                                (context, error, stackTrace) => const Icon(
                                  CupertinoIcons.person,
                                  size: 100,
                                ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: CupertinoColors.black.withValues(
                                  alpha: .1,
                                ),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildCustomTabBar(),
                              Container(
                                color: CupertinoColors.systemGrey6,
                                height: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: _buildTabContent(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget _buildCustomTabBar() {
    final tabs = ['About', 'Stats', 'Skills', 'Eidolons'];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(tabs.length, (index) {
          return _buildTabButton(
            label: tabs[index],
            index: index,
            isSelected: _selectedTab == index,
          );
        }),
      ),
    );
  }

  Widget _buildTabButton({
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Text(
          label,
          style: TextStyle(
            color:
                isSelected ? CupertinoColors.activeBlue : CupertinoColors.black,
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    final characterName = characterDetail['name'];
    final characterFaction = characterDetail['fetter']['faction'];
    final characterDescription = characterDetail['fetter']['description'];
    final characterEidolons = characterDetail['eidolons'];

    switch (_selectedTab) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              characterName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(characterFaction, style: const TextStyle(fontSize: 16)),
            Text(
              characterDescription,
              style: const TextStyle(
                fontSize: 14,
                color: CupertinoColors.secondaryLabel,
                height: 1.25,
              ),
            ),
          ],
        );
      case 1:
        return const Text("Stats");
      case 2:
        return const Text("Skills");
      case 3:
        return Column(
          children:
              characterEidolons.entries.map<Widget>((entry) {
                final eidolon = entry.value;
                final name = eidolon['name'];
                final description = formatDescription(
                  eidolon['description'],
                  eidolon['params'],
                );

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(CupertinoIcons.star, size: 40),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            description,
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
        );
      default:
        return const SizedBox();
    }
  }
}
