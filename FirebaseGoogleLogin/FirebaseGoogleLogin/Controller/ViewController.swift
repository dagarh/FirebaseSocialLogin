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
        
        setupGoogleCustomButton()
        
        /* I added this so that everytime we can signIn again and again for sanity testing. */
        GIDSignIn.sharedInstance().signOut()
    }
    
    fileprivate func setupGoogleButton() {
        // Configure the sign-in button look/feel
        let loginButton = GIDSignInButton(frame: CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50))
        view.addSubview(loginButton)
    }
    
    fileprivate func setupGoogleCustomButton() {
        let myLoginButton = UIButton(type: .system)
        myLoginButton.frame = CGRect(x: 16, y: 116, width: view.frame.width - 32, height: 50)
        myLoginButton.backgroundColor = .orange
        myLoginButton.setTitle("Custom Google Sign in", for: .normal)
        myLoginButton.setTitleColor(.white, for: .normal)
        myLoginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        myLoginButton.addTarget(self, action: #selector(handleCustomGoogleSignin), for: .touchUpInside)
        
        view.addSubview(myLoginButton)
    }
    
    @objc func handleCustomGoogleSignin() {
        GIDSignIn.sharedInstance().signIn()
    }
    
}

extension ViewController: GIDSignInUIDelegate {
    
}

