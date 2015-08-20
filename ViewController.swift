//
//  ViewController.swift
//  MOJOReplicatorView
//
//  Created by Abel Domingues on 8/20/15.
//  Copyright (c) 2015 Abel Domingues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var timer: NSTimer!
  
  @IBOutlet var replicator: MOJOReplicatorView!

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func animateReplicator(sender: UIButton)
  {
    if sender.titleLabel?.text == "Start" {
      timer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: replicator, selector: "animate", userInfo: nil, repeats: true)
      sender.setTitle("Stop", forState: .Normal)
    } else {
      timer.invalidate()
      sender.setTitle("Start", forState: .Normal)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}

