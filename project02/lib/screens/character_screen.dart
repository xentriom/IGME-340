import 'package:flutter/cupertino.dart';
import 'package:project02/core/yatta.dart';
import 'package:project02/core/shared_pref.dart';
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

  @override
  Widget build(BuildContext context) {
    final SharedPref sharedPref = SharedPref();

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(characterDetail['name'] ?? 'Character'),
        trailing: FavoriteIcon(
          id: widget.id,
          sharedPref: sharedPref,
          onFavoriteChanged: () {
            setState(() {});
          },
        ),
      ),
      child: SafeArea(
        child:
            isLoading
                ? const Center(child: CupertinoActivityIndicator())
                : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(yatta.getGachaIconUrl(widget.id)),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
