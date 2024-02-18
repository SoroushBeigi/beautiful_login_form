import 'dart:ui';

class AssetPaths {
  /// Shaders
  static const String _shaders = 'assets/shaders';
  static const String bgShader = '$_shaders/bg.frag';
}

Future<FragmentProgram> loadFragmentProgram() async =>
    await _loadFragmentProgram(AssetPaths.bgShader);

Future<FragmentProgram> _loadFragmentProgram(String path) async {
  return (await FragmentProgram.fromAsset(path));
}
