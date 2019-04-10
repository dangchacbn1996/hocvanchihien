//
//  LoginViewController.swift
//  HocVanChiHien
//
//  Created by DC on 4/9/19.
//  Copyright © 2019 Ngo Dang Chac. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfUserName : UITextField!
    @IBOutlet weak var tfPassword : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginView(){
        self.view.endEditing(true)
        let email = tfUserName.text ?? ""
        let password = tfPassword.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else {
                Toast.shared.makeToast(string: "Sai tài khoản!", inView: self!.view)
                return
            }
            guard error == nil else {
                print("AccInfo: \(error?.localizedDescription)")
                Toast.shared.makeToast(string: error?.localizedDescription ?? "", inView: self!.view)
                return
            }
            if let userInfo = user?.user {
                print("AccInfo: \(userInfo.uid)")
                print("AccInfo: \(userInfo.email)")
                print("AccInfo: -----------------")
            }
        }
    }

}
