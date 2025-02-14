//
//  SimpleViewController.swift
//  ARKit-Sampler
//
//  Created by Shuichi Tsutsumi on 2017/09/20.
//  Copyright © 2017 Shuichi Tsutsumi. All rights reserved.
//

import UIKit
import ARKit

class SimpleViewController: UIViewController {
  
  var modelURL: URL?
  
  var sceneView: ARSCNView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    sceneView = ARSCNView(frame: view.bounds)
    view.addSubview(sceneView)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if let modelURL = modelURL {
      print("modelURL", modelURL)
      
      // sceneView.allowsCameraControl = true

      do {
        let scene = try SCNScene(url: modelURL, options: nil)
        sceneView.scene = scene
      } catch {
        print("Failed to load scene from:", modelURL)
        let alert = UIAlertController(title: "Error", 
                                    message: "Failed to load 3D model", 
                                    preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    sceneView.session.run(ARWorldTrackingConfiguration())
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    sceneView.session.pause()
  }
}
