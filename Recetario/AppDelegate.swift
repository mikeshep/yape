//
//  AppDelegate.swift
//  Recetario
//
//  Created by Miguel Angel Olmedo Perez on 14/12/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = self.window ?? UIWindow()
        self.window!.backgroundColor = UIColor.red
        self.window!.rootViewController = RecipeListBuilder.build()
        self.window!.makeKeyAndVisible()
        return true
    }
}

