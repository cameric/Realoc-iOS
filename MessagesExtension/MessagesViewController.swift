//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Cam on 6/16/16.
//  Copyright © 2016 Cameric. All rights reserved.
//

import UIKit
import Messages
import MapKit

class MessagesViewController: MSMessagesAppViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        checkAuthentication()

        setupMapView()
      
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    /// MARK: Authentication
    func checkAuthentication() {
        // This needs more checking if user does not allow access to location. We should prompt user to set it in settings
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    /// MARK: Messanger Delegate
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        switch presentationStyle {
        case .compact:
            mapView.isUserInteractionEnabled = false
            mapView.userTrackingMode = .follow
        default:
            mapView.isUserInteractionEnabled = true
            mapView.userTrackingMode = .none
        }
    }
    
    /// MARK: Views
    func setupMapView() {
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.userTrackingMode = .follow
    }
    
    func setupBlurView() {
        let effect = UIBlurEffect(style: .regular)
        blurView.effect = effect
    }
    
    /// MARK: Actions
    @IBAction func sendLocation(_ sender: UIButton) {
        didPressAButton()
        
        let conversation = self.activeConversation
        
        let message = MSMessage()
        message.url = URL(string: "http://www.apple.com")
        let layout = MSMessageTemplateLayout()
        layout.caption = "Location"
        
        conversation?.insert(message, localizedChangeDescription: nil, completionHandler: nil)
    }
    
    @IBAction func realtimeLocation(_ sender: UIButton) {
        didPressAButton()
    }
    
    func didPressAButton() {
        blurView.removeFromSuperview()
    }
    
}
