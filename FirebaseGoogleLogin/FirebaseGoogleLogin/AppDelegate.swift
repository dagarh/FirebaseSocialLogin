//
//  AppDelegate.swift
//  FirebaseGoogleLogin
//
//  Created by Himanshu Dagar on 01/09/18.
//  Copyright © 2018 Himanshu Dagar. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        /* We added reversed_client_id in URLSchemes, so that is taking us to the google.com. This method is going to take me back to my app from google.com, which got opened for filling in google credentials. */
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: [:])
    }
}


extension AppDelegate : GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        /* This method would be called when user is signed in */
        if let error = error {
            print("Failed to log into Google: \(error)")
            return
        }
        
        print("User successfully logged in to Google :]")
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print("Error while authenticating with firebase using google's credentials \(error)")
                return
            }
            
            /* Can get any user info here. */
            print("Successfully logged into Firebase with Google: \(String(describing: authResult?.user.email))")
        }
    }
}

