import 'package:flutter/cupertino.dart';
import 'package:project02/core/shared_pref.dart';
import 'package:project02/core/yatta.dart';
import 'package:project02/widgets/favorite_icon.dart';
import 'package:project02/core/constants.dart';

class BuildGridView extends StatelessWidget {
  final List<dynamic> filteredCharacters;
  final bool isLoading;

  const BuildGridView({
    super.key,
    required this.filteredCharacters,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final SharedPref sharedPref = SharedPref();
    final Yatta yatta = Yatta();
    final Constants constants = Constants();

    if (isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (filteredCharacters.isEmpty) {
      return const Center(child: Text('No characters found.'));
    }

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 0,
        childAspectRatio: 1,
      ),
      itemCount: filteredCharacters.length,
      itemBuilder: (context, index) {
        final character = filteredCharacters[index];
        final id = character['id'].toString();
        final name = character['name'];
        final rarity = character['rank'];
        final path = character['types']['pathType'];
        final type = character['types']['combatType'];

        return GestureDetector(
          onTap: () {
            // Curtsy of ChatGPT, my broken version is commented below
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamed('/character', arguments: id);
            // Navigator.pushNamed(context, '/character', arguments: id);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey6,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(yatta.getAvatarIconUrl(id)),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 72,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            CupertinoColors.white.withValues(alpha: 0),
                            rarity == 4
                                ? CupertinoColors.systemPurple.withOpacity(0.8)
                                : CupertinoColors.systemYellow.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Center(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.darkBackgroundGray,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Image(
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            yatta.getTypeIcon(constants.typesIcon[type] ?? ''),
                          ),
                        ),
                        Image(
                          width: 24,
                          height: 24,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            yatta.getPathIcon(constants.pathsIcon[path] ?? ''),
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
          ),
        );
      },
    );
  }
}
