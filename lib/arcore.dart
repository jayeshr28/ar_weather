import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARCore extends StatefulWidget {
  ARCore({Key? key}) : super(key: key);

  @override
  _ARCoreState createState() => _ARCoreState();
}

class _ARCoreState extends State<ARCore> {
  late ArCoreController arCoreController;
  _onArCoreViewCreated(ArCoreController _arCoreController) {
    arCoreController = _arCoreController;
    _addImage(arCoreController);
    // _addSphere(arCoreController);
    // _addCube(arCoreController);
    // _addCylinder(arCoreController);
  }

  _addSphere(ArCoreController _arCoreController) async {
    final ByteData bytes = await rootBundle.load('asset/images/test2.jpg');
    final Uint8List list = bytes.buffer.asUint8List();
    final material = ArCoreMaterial(
      color: Colors.yellow,
      textureBytes: list,
    );
    final image = ArCoreImage(width: 2500, height: 3000, bytes: list);
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.4,
    );

    final node = ArCoreNode(
      image: image,
      // degreesPerSecond: 0.001,
      // shape: sphere,
      position: vector.Vector3(0, -2, -1),
    );
    _arCoreController.addArCoreNode(node);
  }

  _addImage(ArCoreController _arCoreController) async {
    final ByteData bytes = await rootBundle.load('asset/images/sun.png');
    final Uint8List list = bytes.buffer.asUint8List();

    final image = ArCoreImage(width: 100, height: 100, bytes: list);
    final node = ArCoreNode(
      // objectUrl:
      //     'https://developers.arcgis.com/javascript/latest/sample-code/import-gltf/live/canoe.glb',
      image: image,
      position: vector.Vector3(0, 0, -1),
    );
    _arCoreController.addArCoreNode(node);
  }

  _addCylinder(ArCoreController _arCoreController) {
    final material = ArCoreMaterial(
      color: Colors.yellow,
      reflectance: 1,
    );
    final cylinder = ArCoreCylinder(
      materials: [material],
      radius: 0.015,
      height: 0.1,
    );
    final node1 = ArCoreRotatingNode(
      shape: cylinder,
      position: vector.Vector3(0.1, -0.3, -1),
      // rotation: vector.Vector4());
    );
    final node2 =
        ArCoreNode(shape: cylinder, position: vector.Vector3(0.1, -0.2, -1));
    _arCoreController.addArCoreNode(node1);
    _arCoreController.addArCoreNode(node2);
  }

  _addCube(ArCoreController _arCoreController) {
    final material = ArCoreMaterial(
      color: Colors.pink,
      metallic: 1,
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    final node = ArCoreNode(
      name: "Cube",
      shape: cube,
      position: vector.Vector3(0.5, -3, -3),
    );
    _arCoreController.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
      ),
    );
  }
}
