//
//  GameViewController.swift
//  LifeIsAGame
//
//  Created by Ezra Black on 7/27/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        var count = 0
        let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
//        var containers: [SCNBox] = []
//        while count <= 24 {
//            let B = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
//            containers.append(B)
//            count += 1
//        }
//        count = 0
        
        
     
        // create a new scene
        let scene = SCNScene()
        
        //create a generic cube node
        let s = SCNNode(geometry: box)
        let s2 = SCNNode(geometry: box)
        let s3 = SCNNode(geometry: box)
        let s4 = SCNNode(geometry: box)
        let s5 = SCNNode(geometry: box)
        let s6 = SCNNode(geometry: box)
        let s7 = SCNNode(geometry: box)
        let s8 = SCNNode(geometry: box)
        let s9 = SCNNode(geometry: box)
        scene.rootNode.addChildNode(s)
        scene.rootNode.addChildNode(s2)
        scene.rootNode.addChildNode(s3)
        scene.rootNode.addChildNode(s4)
        scene.rootNode.addChildNode(s5)
        scene.rootNode.addChildNode(s6)
        scene.rootNode.addChildNode(s7)
        scene.rootNode.addChildNode(s8)
        scene.rootNode.addChildNode(s9)
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        s.position = SCNVector3(0, 0, 0)
        s2.position = SCNVector3(0, 1, 0)
        s3.position = SCNVector3(0, -1, 0)
        s4.position = SCNVector3(1, 0, 0)
        s5.position = SCNVector3(-1, 0, 0)
        s6.position = SCNVector3(-1, 1, 0)
        s7.position = SCNVector3(1, 1, 0)
        s8.position = SCNVector3(-1, -1, 0)
        s9.position = SCNVector3(1, -1, 0)
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the node
          
        
        // animate the 3d object
//        s.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 5)))
//        s2.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 5)))
//        s3.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 5)))
//        s4.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 5)))
//        s5.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 5)))
//        s6.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 5)))
//        s7.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 5)))
//        s8.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 5)))
//        s9.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 5)))

        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}
