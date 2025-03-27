import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:project02/core/shared_pref.dart';
import 'package:project02/core/yatta.dart';
import 'package:project02/widgets/favorite_icon.dart';

///
/// Character Screen
/// Displays detailed information about a character
/// Includes character stats, skills, and eidolons
///
/// @param id: character ID
///
/// author: Jason Chen
/// version: 1.0.0
/// since: 2025-03-27
///

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

  /// Format description with optional parameters
  RichText formatDescription(
    String description,
    List<dynamic>? params, {
    TextStyle baseStyle = const TextStyle(
      fontSize: 14,
      height: 1.4,
      color: CupertinoColors.secondaryLabel,
    ),
  }) {
    // split by newlines
    final lines = description.split('\\n');
    final List<TextSpan> spans = [];

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      _addUnderlinedText(line, spans);

      // add newline except for the last line
      if (i < lines.length - 1) {
        spans.add(const TextSpan(text: '\n'));
      }
    }

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: _processParamsAndCleanTags(spans, params),
      ),
    );
  }

  /// Add underlined text to spans
  void _addUnderlinedText(String line, List<TextSpan> spans) {
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
  }

  List<TextSpan> _processParamsAndCleanTags(
    List<TextSpan> spans,
    List<dynamic>? params,
  ) {
    final resultSpans = <TextSpan>[];

    for (final span in spans) {
      String text = span.text ?? '';
      final spanStyle = span.style;

      // replace <unbreak>#\d+[i]</unbreak> with params
      if (params != null && params.isNotEmpty) {
        final regex = RegExp(r'<unbreak>#(\d+)\[i\]</unbreak>');
        text = text.replaceAllMapped(regex, (match) {
          final paramIndex = int.parse(match.group(1)!) - 1;
          if (paramIndex >= 0 && paramIndex < params.length) {
            return params[paramIndex].toString();
          }
          return match[0]!;
        });
      }

      // remove <unbreak></unbreak> tags, keep content
      text = text.replaceAllMapped(
        RegExp(r'<unbreak>(.*?)</unbreak>'),
        (match) => match.group(1) ?? '',
      );

      resultSpans.add(TextSpan(text: text, style: spanStyle));
    }

    return resultSpans;
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
                : Container(
                  color: CupertinoColors.systemGroupedBackground,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        child: Image.network(
                          yatta.getGachaIconUrl(widget.id),
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: _buildTabContent(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }

  /// Build radar chart for character stats
  Widget _buildStatChart(dynamic characterUpgrades) {
    final titles = [
      'Attack',
      'Defence',
      'HP',
      'Speed',
      'Crit Chance',
      'Crit Damage',
      'Aggro',
    ];

    final dataEntries = [
      RadarEntry(value: (characterUpgrades['attackBase']).toDouble()),
      RadarEntry(value: (characterUpgrades['defenceBase']).toDouble()),
      RadarEntry(value: (characterUpgrades['hPBase']).toDouble()),
      RadarEntry(value: (characterUpgrades['speedBase']).toDouble()),
      RadarEntry(value: (characterUpgrades['criticalChance']) * 100),
      RadarEntry(value: (characterUpgrades['criticalDamage']) * 100),
      RadarEntry(value: (characterUpgrades['baseAggro']).toDouble()),
    ];

    return SizedBox(
      height: 300,
      child: RadarChart(
        RadarChartData(
          radarShape: RadarShape.circle,
          dataSets: [
            RadarDataSet(
              fillColor: CupertinoTheme.of(
                context,
              ).primaryColor.withValues(alpha: 0.2),
              borderColor: CupertinoTheme.of(context).primaryColor,
              borderWidth: 2,
              dataEntries: dataEntries,
            ),
          ],
          radarBorderData: const BorderSide(
            color: CupertinoColors.systemGrey,
            width: 1,
          ),
          getTitle: (index, angle) {
            return RadarChartTitle(text: titles[index]);
          },
          ticksTextStyle: const TextStyle(
            color: CupertinoColors.secondaryLabel,
            fontSize: 12,
          ),
          tickCount: 5,
          titleTextStyle: const TextStyle(
            color: CupertinoColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// Build custom tab bar, sorry cupertino tab bar is extremely ugly
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

  /// Build tab button
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

  /// Build tab content
  /// 0: About
  /// 1: Stats
  /// 2: Skills
  /// 3: Eidolons
  Widget _buildTabContent() {
    final characterName = characterDetail['name'];
    final characterFaction = characterDetail['fetter']['faction'];
    final characterDescription = characterDetail['fetter']['description'];
    final characterSkills = characterDetail['traces']['mainSkills'];
    final characterUpgrades = characterDetail['upgrade'][0]['skillBase'];
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_buildStatChart(characterUpgrades)],
        );
      case 2:
        return const Text("Skills");
      case 3:
        return SingleChildScrollView(
          child: Column(
            children:
                characterEidolons.entries.map<Widget>((entry) {
                  final eidolon = entry.value;
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
                    child: Column(
                      spacing: 4,
                      children: [
                        Row(
                          spacing: 4,
                          children: [
                            Image.network(
                              yatta.getSkillIcon(eidolon['icon']),
                              width: 24,
                            ),
                            Expanded(
                              child: Text(
                                eidolon['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        description,
                      ],
                    ),
                  );
                }).toList(),
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
