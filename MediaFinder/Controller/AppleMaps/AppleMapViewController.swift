//
//  AppleMapViewController.swift
//  MediaFinder
//
//  Created by Yousef Arafa on 4/19/20.
//  Copyright © 2020 Yousef Arafa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


protocol SendingAddressDelegate {
    func getLocation(address: String)
}

class AppleMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    let locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    var delegate : SendingAddressDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBtn.roundedCorner(radius: 12)
        checkLocationService()
        mapView.delegate = self

    }
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        self.delegate?.getLocation(address: addressLbl.text!)
        dismiss(animated: true, completion: nil)
    }
    

}
extension AppleMapViewController: MKMapViewDelegate , CLLocationManagerDelegate  {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(mapView: mapView)
        let geocoder = CLGeocoder()
        guard let previousLocation = self.previousLocation else {return}
        guard center.distance(from: previousLocation) > 50 else {return}
        self.previousLocation = center
        
        geocoder.reverseGeocodeLocation(center) {[weak self] (placemarks, error) in
            guard let self = self else {return}
            if let _  = error {
                return
            }
            guard let placemark = placemarks?.first else {
                
                return
            }
            let streetNumber = placemark.subThoroughfare
            let streetName = placemark.thoroughfare
            DispatchQueue.main.async {
                self.addressLbl.text = "\(streetNumber ?? "") \(streetName ?? "")"
            }
        }
    }
}
extension AppleMapViewController {
    
    private func setupLocationManger(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location , latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTrackingUserLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    private func startTrackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(mapView: mapView)
    }
    
    private func checkLocationService() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManger()
            checkLocationAuthorization()
        }
        else {
            print("errorSERVICE")
        }
    }
    
    private func getCenterLocation(mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longtiude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longtiude)
    }
}
