import 'package:flutter/cupertino.dart';
import 'package:project02/core/shared_pref.dart';
import 'package:project02/core/yatta.dart';
import 'package:project02/widgets/favorite_icon.dart';
import 'package:project02/core/constants.dart';

class BuildListView extends StatelessWidget {
  final List<dynamic> filteredCharacters;
  final bool isLoading;

  const BuildListView({
    super.key,
    required this.filteredCharacters,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final SharedPref sharedPref = SharedPref();
    final Yatta yatta = Yatta();

    if (isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (filteredCharacters.isEmpty) {
      return const Center(child: Text('No characters found.'));
    }

    return ListView.builder(
      itemCount: filteredCharacters.length,
      itemBuilder: (context, index) {
        final character = filteredCharacters[index];
        final id = character['id'].toString();
        final name = character['name'] ?? 'Unknown';
        final rarity = character['rank'] ?? 0;
        final path = character['types']?['pathType'] ?? 'Unknown';
        final type = character['types']?['combatType'] ?? 'Unknown';

        return GestureDetector(
          onTap: () {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamed('/character', arguments: id);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Stack(
              children: [
                Container(
                  height: 96,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 16,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          yatta.getAvatarIconUrl(id),
                          width: 96,
                          height: 96,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(CupertinoIcons.person, size: 96);
                          },
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 4,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: List.generate(
                                rarity,
                                (index) => Icon(
                                  CupertinoIcons.star_fill,
                                  color:
                                      rarity == 4
                                          ? CupertinoColors.systemPurple
                                          : CupertinoColors.systemYellow,
                                  size: 16,
                                ),
                              ),
                            ),
                            Row(
                              spacing: 6,
                              children: [
                                _buildBadge('path', path, yatta),
                                _buildBadge('type', type, yatta),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: FavoriteIcon(id: id, sharedPref: sharedPref),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBadge(String type, String data, Yatta yatta) {
    final Constants constants = Constants();

    final label =
        type == 'path'
            ? constants.paths[data] ?? data
            : constants.types[data] ?? data;
    final iconLabel =
        type == 'path' ? constants.pathsIcon[data] : constants.typesIcon[data];
    final iconUrl =
        type == 'path'
            ? yatta.getPathIcon(iconLabel ?? '')
            : yatta.getTypeIcon(iconLabel ?? '');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey5,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        spacing: 4,
        children: [
          Image.network(iconUrl, width: 16, height: 16),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
