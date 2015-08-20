//
//  MOJOReplicatorLayer.swift
//  CustomReplicatorTest
//
//  Created by Abel Domingues on 8/10/15.
//  Copyright (c) 2015 Abel Domingues. All rights reserved.
//

import UIKit

class MOJOReplicatorLayer: CALayer {
  
  var instanceShape : CAShapeLayer! {
    didSet {
      updateLayers()
    }
  }
  
  var instanceCount : Int = 4 {
    didSet {
      updateLayers()
    }
  }
  
  var instanceLayers = [CAShapeLayer]()
  
  override init()
  {
    super.init()
    
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func updateLayers()
  {
    // 1. Check if we have an existing set of replicated sublayers, zap it (along with the contents of the instanceLayers array) if we do
    if self.sublayers != nil {
      self.sublayers.removeAll(keepCapacity: false)
      self.instanceLayers.removeAll(keepCapacity: false)
    }
    // 2. Calculate a rotation angle based on instanceCount
    var angle = Float(M_PI * 2.0) / Float(instanceCount)
    // 3. Create a sublayer for each instance
    for index in 1...self.instanceCount {
      // configure a new shape layer
      var layer = CAShapeLayer()
      layer.frame = self.bounds
      layer.backgroundColor = UIColor.clearColor().CGColor
      // if instanceShape exists, copy its properties over to the new layer
      if self.instanceShape != nil {
        layer.strokeColor = instanceShape.strokeColor
        layer.opacity = instanceShape.opacity
        layer.lineWidth = instanceShape.lineWidth
        layer.lineCap = instanceShape.lineCap
        layer.path = instanceShape.path
      } else {
        // otherwise, set the layer's properties to some reasonable defaults
        layer.strokeColor = UIColor.whiteColor().CGColor
        layer.lineWidth = 2.0
        layer.lineCap = kCALineCapRound
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0))
        path.addLineToPoint(CGPoint(x: self.bounds.size.width / 2.0, y: 0))
        layer.path = path.CGPath
      }
      // 4. Apply a rotation transform to the layer, based on our calculated angle
      layer.transform = CATransform3DMakeRotation(CGFloat(Float(index) * angle), 0.0, 0.0, 1.0)
      // 5. Store a reference to the layer in our instanceLayers array...
      instanceLayers.append(layer)
      // 6. And, finally, add the shape layer to self
      self.addSublayer(layer)
    }
  }
  
}
