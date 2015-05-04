//
//  MapRootViewController.swift
//  DriveSense
//
//  Created by Matt Kostelecky on 5/3/15.
//  Copyright (c) 2015 Matt Kostelecky. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapRootViewController: UIViewController, MKMapViewDelegate{
  
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak private var topContainer: UIView!
 
  
  @IBOutlet var bottomBar: UIView!

  @IBOutlet weak var tripLabel: UILabel!
  @IBOutlet weak var durationLabel: UILabel!
 
  var recording: Bool!
  var locationManager: CLLocationManager!
  var tripRecorder: TripRecorder!
  var frameIn: CGRect!
  var frameContainer: CGRect!
  var secondsCounting: NSInteger!
  var durationTimer: NSTimer!
  
  override func viewDidLoad() {
    self.recording = false
    self.tripRecorder = TripRecorder.sharedInstance
    self.locationManager = self.tripRecorder.getLocationManager()
    mapView.delegate = self
    //durationTimer = NSTimer()
    secondsCounting = 0;
    
  }
  
  override func viewDidAppear(animated: Bool) {
    mapView.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
//frameIn = topContainer.frame
    frameContainer = bottomBar.frame
    durationLabel.text = NSString(format: "%d seconds", secondsCounting) as String
    animateOut()
    
  }
  
  @IBAction func togglePlayButton(sender: AnyObject) {
    if (recording == false) {
      playButton.setBackgroundImage(UIImage(named: "pause"), forState: UIControlState.Normal)
      recording = true
      self.durationTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "incrementTimer", userInfo: nil, repeats: true)
      secondsCounting = 0
      self.tripRecorder.startRecording()
      animateIn()
    } else {
      playButton.setBackgroundImage(UIImage(named: "play"), forState: UIControlState.Normal)
      recording = false
      self.durationTimer.invalidate()
      self.tripRecorder.stopRecording()
      animateOut()
    }
  }
  func incrementTimer(){
    secondsCounting = secondsCounting + 1
    durationLabel.text = NSString(format: "%d seconds", secondsCounting) as String
  }
  func animateIn(){
    UIView.animateWithDuration(0.25, animations: {
      self.bottomBar.frame = self.frameContainer
    })
  }
  
  func animateOut(){
    UIView.animateWithDuration(0.25, animations: {
      let y = self.view.frame.size.height
      var newFrame = self.frameContainer
      newFrame.origin.y = y
      self.bottomBar.frame = newFrame
    })
  }
}
