import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        //self.sceneView.autoenablesDefaultLighting = true
    }

    @IBAction func add(_ sender: Any) {
        
        // 1 variant
//        let node = SCNNode()
//        node.geometry = SCNText(string: "Hello", extrusionDepth: 1)
//        //node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
//        //node.localRotate(by: SCNQuaternion()
//        node.position = SCNVector3(0,0,0)
//        self.sceneView.scene.rootNode.addChildNode(node)
        
        // 2 variant
//        let firstText = SCNText(string: "Hello", extrusionDepth: 1)
//        let textMaterial = SCNMaterial()
//        textMaterial.diffuse.contents = UIColor.purple
//        firstText.materials = [textMaterial]
//        let textNode = SCNNode(geometry: firstText)
//        textNode.position = SCNVector3(0,0,0)
//        self.sceneView.scene.rootNode.addChildNode(textNode)
        
        // 3 variant
//        let text = SCNText(string: "Hello", extrusionDepth: 1)
//        text.firstMaterial?.diffuse.contents = UIColor.purple
//        text.font = UIFont(name: "Arial", size: 35)
//        let textNode = SCNNode(geometry: text)
//        textNode.position = SCNVector3(0, -1, -1)
//        self.sceneView.scene.rootNode.addChildNode(textNode)
        
        // 4 variant
        let string = "Привет :)"
        let text = SCNText(string: string, extrusionDepth: 0.1)
        text.font = UIFont.systemFont(ofSize: 1)
        text.flatness = 0.005
        let textNode = SCNNode(geometry: text)
        let fontScale: Float = 0.01
        textNode.scale = SCNVector3(fontScale, fontScale, fontScale)
        
        let (min, max) = (text.boundingBox.min, text.boundingBox.max)
        let dx = min.x + 0.5 * (max.x - min.x)
        let dy = min.y + 0.5 * (max.y - min.y)
        let dz = min.z + 0.5 * (max.z - min.z)
        textNode.pivot = SCNMatrix4MakeTranslation(dx, dy, dz)
        
        let width = (max.x - min.x) * fontScale
        let height = (max.y - min.y) * fontScale
        let plane = SCNPlane(width: CGFloat(width), height: CGFloat(height))
        let planeNode = SCNNode(geometry: plane)
        planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green.withAlphaComponent(0.5)
        planeNode.geometry?.firstMaterial?.isDoubleSided = true
        planeNode.position = textNode.position
        textNode.eulerAngles = planeNode.eulerAngles
        planeNode.addChildNode(textNode)
        planeNode.position = SCNVector3(0, 0, -0.5)
        
        self.sceneView.scene.rootNode.addChildNode(planeNode)
        
        
        
        
        
        
        
        /////////////
//        let node = SCNNode()
//        node.geometry = SCNPlane(width: 0.2, height: 0.2)
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
//        node.position = SCNVector3(0,0,0)
//        self.sceneView.scene.rootNode.addChildNode(node)
        //node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        //node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        //        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        //        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        //        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        //        node.position = SCNVector3(x,y,z)
        
    }
    
    @IBAction func reset(_ sender: Any) {
        restartSession()
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}

