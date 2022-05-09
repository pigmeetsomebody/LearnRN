//
//  AppDelegate.swift
//  FashionInspiration
//
//  Created by 朱彦谕 on 2022/4/22.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabbarVC: MainHomeTabViewController?
    var mainNavVC: MainNavigationController?
    
    // database
    var realm = try? Realm()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.tintAdjustmentMode = .normal
        window?.backgroundColor = .white
        tabbarVC = MainHomeTabViewController()
        mainNavVC = MainNavigationController(rootViewController: tabbarVC ?? UIViewController())
        window?.rootViewController = mainNavVC
        window?.makeKeyAndVisible()
        
//        realmMigration()
//        do {
//            realm = try? Realm()
//        }
        return true
    }
}

// MARK: - Realm -
extension AppDelegate {
    
    private func realmMigration() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
         
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if oldSchemaVersion < 1 {
                    // the magic happens here: `id` is the property you specified
                    // as your primary key on your Model
                }
            })
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
}

