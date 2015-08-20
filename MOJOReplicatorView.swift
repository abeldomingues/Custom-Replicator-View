//
//  MOJOReplicatorView.swift
//  CustomReplicatorTest
//
//  Created by Abel Domingues on 8/9/15.
//  Copyright (c) 2015 Abel Domingues. All rights reserved.
//

import UIKit

class MOJOReplicatorView: UIView {
  
  var replicator : MOJOReplicatorLayer!
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setup()
  }
  
  func setup()
  {
    // 1. Configure a shape layer
    let shapeLayer = CAShapeLayer()
    shapeLayer.frame = CGRect(x: self.bounds.size.width / 2.0, y: 0, width: 1, height: self.bounds.size.height)
    shapeLayer.lineCap = kCALineCapRound
    shapeLayer.lineWidth = 1.0
    shapeLayer.strokeColor = UIColor.whiteColor().CGColor
    shapeLayer.opacity = 0.7
    let path = UIBezierPath()
    path.moveToPoint(CGPoint(x: self.bounds.size.width / 2.0, y: 0))
    path.addLineToPoint(CGPoint(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 4.0))
    shapeLayer.path = path.CGPath
    
    // 2. Configure a replicator with the shape layer we just set up, and tell it how many copies to make
    replicator = MOJOReplicatorLayer()
    replicator.frame = self.bounds
    replicator.instanceShape = shapeLayer
    replicator.instanceCount = 12
    
    // 3. Attach our replicator as a sublayer
    self.layer.addSublayer(replicator)
  }
  
  func animate()
  {
    // 1. Set up a pair of animation blocks
    let lineWidthAnimation = CABasicAnimation(keyPath: "lineWidth")
    lineWidthAnimation.duration = 0.15
    lineWidthAnimation.fromValue = replicator.instanceLayers[Int(0)].lineWidth
    lineWidthAnimation.toValue = replicator.instanceLayers[Int(0)].lineWidth * 3.0
    lineWidthAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    lineWidthAnimation.autoreverses = true

    let opacityAnimation = CABasicAnimation(keyPath: "opacity")
    opacityAnimation.duration = 0.15
    opacityAnimation.fromValue = 0.7
    opacityAnimation.toValue = 1.0
    opacityAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    opacityAnimation.autoreverses = true

    // 2. Group the animations into an animation group
    let animationGroup = CAAnimationGroup()
    animationGroup.duration = 0.3
    animationGroup.animations = [lineWidthAnimation, opacityAnimation]
    // 3. Retrieve our replicator's layer count, and generate a random value within its range
    let count = UInt32(replicator.instanceLayers.count)
    let rand = arc4random() % count
    // 4. Add the animation group to our randomly selected layer
      replicator.instanceLayers[Int(rand)].addAnimation(animationGroup, forKey: nil)
  }
  
}
