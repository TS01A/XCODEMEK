//
//  ViewControllerGoogleMap.swift
//  withyou
//
//  Created by Abdullah on 15/05/1446 AH.
//

import UIKit
import CoreLocation

class ViewControllerGoogleMap: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // طلب إذن للوصول إلى الموقع
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    @IBAction func BTNgotomap(_ sender: Any) {
        // تحقق من صلاحيات الموقع
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            print("خدمة الموقع غير مفعلة!")
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // أوقف التحديث بعد الحصول على الموقع
        locationManager.stopUpdatingLocation()
        
        if let currentLocation = locations.last {
            let latitude = currentLocation.coordinate.latitude
            let longitude = currentLocation.coordinate.longitude
            
            // أنشئ الرابط المخصص باستخدام الموقع الحالي
            if let url = URL(string: "https://www.google.com/maps/search/عيادة+الصحة+النفسية/@\(latitude),\(longitude),10z") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("فشل في تحديد الموقع: \(error.localizedDescription)")
    }
}
