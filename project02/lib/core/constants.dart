class Constants {
  /// List of paths
  List<String> paths = [
    'Paths',
    'Destruction',
    'The Hunt',
    'Erudition',
    'Harmony',
    'Nihility',
    'Preservation',
    'Abundance',
    'Rememberance',
  ];

  /// Codebase to Readable
  Map<String, String> pathsMap = {
    'Warlock': 'Nihility',
    'Shaman': 'Harmony',
    'Mage': 'Erudition',
    'Rogue': 'The Hunt',
    'Knight': 'Preservation',
    'Warrior': 'Destruction',
    'Priest': 'Abundance',
    'Memory': 'Rememberance',
  };

  /// Codebase to Icon
  Map<String, String> pathsIconMap = {
    'Warlock': 'IconProfessionWarlockSmall',
    'Shaman': 'IconProfessionShamanSmall',
    'Mage': 'IconProfessionMageSmall',
    'Rogue': 'IconProfessionRogueSmall',
    'Knight': 'IconProfessionKnightSmall',
    'Warrior': 'IconProfessionWarriorSmall',
    'Priest': 'IconProfessionPriestSmall',
    'Memory': 'IconProfessionMemorySmall',
  };

  /// List of types
  List<String> types = [
    'Elements',
    'Physical',
    'Fire',
    'Ice',
    'Lightning',
    'Wind',
    'Quantum',
    'Imaginary',
  ];

  /// Codebase to Readable
  Map<String, String> typesMap = {
    'Imaginary': 'Imaginary',
    'Thunder': 'Lightning',
    'Quantum': 'Quantum',
    'Fire': 'Fire',
    'Ice': 'Ice',
    'Wind': 'Wind',
    'Physical': 'Physical',
  };

  /// Codebase to Icon
  Map<String, String> typesIconMap = {
    'Imaginary': 'IconAttributeImaginary',
    'Thunder': 'IconAttributeThunder',
    'Quantum': 'IconAttributeQuantum',
    'Fire': 'IconAttributeFire',
    'Ice': 'IconAttributeIce',
    'Wind': 'IconAttributeWind',
    'Physical': 'IconAttributePhysical',
  };
}
