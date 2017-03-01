//
//  ViewController.swift
//  EJW-Social
//
//  Created by Eric Walters on 2/25/17.
//  Copyright © 2017 Eric Walters. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var passwordField: FancyField!
    @IBOutlet weak var emailField: FancyField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }
    

    @IBAction func facebookButtonTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("ERIC: Unable to authenticate with Facebook \(error)")
            } else if result?.isCancelled == true {
                print("ERIC: User cancelled facebook authentication")
            } else {
                print("ERIC: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
            
            
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("ERIC: Unable to authenticate with Firebase - \(error)")
            } else {
                print("ERIC: Successfully authenticated with Firebase")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
                
            }
        })
    }

    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("ERIC: Email User Authenticated with Firebase")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                    
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("ERIC: Unable to authenticate with Firebase using email")
                        } else {
                            print("ERIC: Successfully authenticated with Firebase")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                            
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String) {
        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("ERIC: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }

}

