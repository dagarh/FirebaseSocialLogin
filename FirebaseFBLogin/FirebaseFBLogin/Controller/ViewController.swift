//
//  ViewController.swift
//  FirebaseFBLogin
//
//  Created by Himanshu Dagar on 31/08/18.
//  Copyright © 2018 Himanshu Dagar. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFBLoginButton()
        
        setupCustomLoginButton()
    }
    
    func setupFBLoginButton() {
        let loginButton = LoginButton(readPermissions: [.publicProfile,.email,.userFriends])
        // Frames are obselete, please use constraints instead
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        view.addSubview(loginButton)
        
        loginButton.delegate = self
    }
    
    func setupCustomLoginButton() {
        let myLoginButton = UIButton(type: .system)
        myLoginButton.frame = CGRect(x: 16, y: 116, width: view.frame.width - 32, height: 50)
        myLoginButton.backgroundColor = .blue
        myLoginButton.setTitle("Custom FB Login here", for: .normal)
        myLoginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        myLoginButton.setTitleColor(.white, for: .normal)
        
        // Handle clicks on the button
        myLoginButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
        
        view.addSubview(myLoginButton)
    }
    
    @objc func handleCustomFBLogin() {
        let loginManager = LoginManager()
        
        loginManager.logIn(readPermissions: [.publicProfile,.email,.userFriends], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error) :
                print("Error occurred during login \(error)")
                
            case .success(let grantedPermissions, let declinedPermissions, let token) :
                print("Successfully logged in with facebook... :]")
                print("GrantedPermissions are: \(grantedPermissions), DeclinedPermissions are : \(declinedPermissions), AccessToken is : \(token)")
                
                /* You can call this only when user is successfully logged in. This is used to consume user's data. */
                self.sendGraphRequest()
                
            case .cancelled :
                print("Login process cancelled by the user!!!")
            }
        }
    }
}

extension ViewController : LoginButtonDelegate {
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error) :
            print("Error occurred during login \(error)")
            
        case .success(let grantedPermissions, let declinedPermissions, let token) :
            print("Successfully logged in with facebook... :]")
            print("GrantedPermissions are: \(grantedPermissions), DeclinedPermissions are : \(declinedPermissions), AccessToken is : \(token)")
            
            /* You can call this only when user is successfully logged in. This is used to consume user's data. */
            sendGraphRequest()
            
        case .cancelled :
            print("Login process cancelled by the user!!!")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("Successfully Logged out with facebook... :]")
    }
    
    func sendGraphRequest() {
        let connection = GraphRequestConnection()
    
        connection.add(GraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"])) { httpResponse, result in
            guard let response = httpResponse, response.statusCode == 200 else {
                print("Server side error occurred!!! ")
                return
            }
            
            print(response.statusCode)
            
            switch result {
                /* This response is different than above response. This is GraphRequest.Response */
            case .success(let response):
                print("Graph Request Succeeded: \(response)")
                
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
        }
        connection.start()
    }
}
