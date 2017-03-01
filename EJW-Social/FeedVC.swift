//
//  FeedVC.swift
//  EJW-Social
//
//  Created by Eric Walters on 3/1/17.
//  Copyright © 2017 Eric Walters. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    @IBAction func signOutTapped(_ sender: Any) {
        let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ERIC: ID removed from keychain \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
