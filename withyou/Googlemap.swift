//
//  Googlemap.swift
//  withyou


import UIKit
import MapKit
import CoreLocation
import Foundation

class Googlemap: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // طلب إذن الوصول للموقع
        locationManager.requestWhenInUseAuthorization()
        
        // التحقق من حالة خدمات الموقع
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            print("Location services are not enabled")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            if CLLocationManager.locationServicesEnabled() {
                locationManager.startUpdatingLocation()
            }
        case .denied, .restricted:
            print("User denied or restricted location access.")
        case .notDetermined:
            print("Location authorization not determined.")
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            // إيقاف التحديث لتوفير الطاقة بعد الحصول على الموقع
            locationManager.stopUpdatingLocation()
            
            // تكبير الخريطة لموقع المستخدم
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
            mapView.setRegion(region, animated: true)
            
            // البحث عن العيادات النفسية
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "عيادة نفسية"
            request.region = mapView.region
            
            let search = MKLocalSearch(request: request)
            search.start { (response, error) in
                guard let response = response else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                // عرض النتائج على الخريطة
                for item in response.mapItems {
                    let annotation = MKPointAnnotation()
                    annotation.title = item.name
                    annotation.coordinate = item.placemark.coordinate
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

