//
//  TripRecorder.swift
//  DriveSense
//
//  Created by Matt Kostelecky on 5/3/15.
//  Copyright (c) 2015 Matt Kostelecky. All rights reserved.
//

import Foundation
import UIKit
import MapKit

private let _TripRecorderSharedInstance = TripRecorder()

class TripRecorder: NSObject, CLLocationManagerDelegate {
  
  static let sharedInstance = _TripRecorderSharedInstance
  private var locationManager: CLLocationManager!
  
  
  override init() {
    super.init()
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = 1
    locationManager.requestWhenInUseAuthorization()

  }
 
  func getLocationManager() -> CLLocationManager {
    return locationManager
  }
  func startRecording() {
    locationManager.startUpdatingLocation()
  }
  
  func stopRecording() {
    locationManager.stopUpdatingLocation()
  }
  
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    var location: CLLocation = (locations as NSArray).objectAtIndex(0) as! CLLocation
    println(NSString(format: "latitude: %f, longitude: %f", location.coordinate.latitude, location.coordinate.longitude))
  }
}
