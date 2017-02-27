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

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            }
        })
    }


}

