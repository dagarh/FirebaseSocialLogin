//
//  ViewController.swift
//  FirebaseGoogleLogin
//
//  Created by Himanshu Dagar on 01/09/18.
//  Copyright © 2018 Himanshu Dagar. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        // GIDSignIn.sharedInstance().signIn()

        setupGoogleButton()
    }
    
    fileprivate func setupGoogleButton() {
        // Configure the sign-in button look/feel
        let loginButton = GIDSignInButton(frame: CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50))
        view.addSubview(loginButton)
    }
    
}

extension ViewController: GIDSignInUIDelegate {
    
}

