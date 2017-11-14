//
//  ViewController.swift
//  ARKitPlaying
//
//  Created by AnnGorobchenko on 11/14/17.
//  Copyright © 2017 com.ann. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToSceneView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else {
            
            let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
            if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
                let translation = hitTestResultWithFeaturePoints.worldTransform.translation
                addBox(x: translation.x, y: translation.y, z: translation.z)
            }
            return
        }
        
        node.geometry?.materials.forEach({ material in
            material.diffuse.contents = UIImage(named: "texture\(Int(arc4random_uniform(6)))")
        })
                
    }

}

extension ViewController {
    
    /// Positive x is to the right.
    /// Negative x is to the left.
    /// Positive y is up.
    /// Negative y is down.
    /// Positive z is backward.
    /// Negative z is forward.
    func addBox(x: Float = 0, y: Float = 0, z: Float = -0.2) {
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(x, y, z)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "texture1")
        
        let material1 = SCNMaterial()
        material1.diffuse.contents = UIImage(named: "texture5")
        
        box.materials = [material, material1]
        
        sceneView.scene.rootNode.addChildNode(boxNode)
    }
    
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
}
