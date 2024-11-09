//
//  AppDelegate.swift
//  withyou
//
//  Created by Abdullah on 06/05/1446 AH.
//

//
//  AppDelegate.swift
//  withyou
//
//  Created by Abdullah on 06/05/1446 AH.
//

import UIKit
import Firebase // استيراد Firebase إذا كنت تستخدمه

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // يتم استدعاء هذه الدالة عند اكتمال إطلاق التطبيق
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // تهيئة Firebase إذا كنت تستخدمه
        FirebaseApp.configure()
        
        // نقطة التهيئة الرئيسية للتطبيق بعد الإطلاق
        print("Application did finish launching")
        return true
    }

    // MARK: UISceneSession Lifecycle

    // يتم استدعاء هذه الدالة عند إنشاء جلسة جديدة (Scene Session)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // تكوين الجلسة باستخدام الإعداد الافتراضي
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // يتم استدعاء هذه الدالة عند حذف جلسات (Scene Sessions)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // تحرير أي موارد مرتبطة بجلسات تم حذفها.
        print("Scene sessions discarded: \(sceneSessions)")
    }
}
