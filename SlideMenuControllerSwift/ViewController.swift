//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Ashish Nakoti on 05/08/17.
//  Copyright © 2017 DevelopingNow. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit
import FacebookLogin
import FacebookCore
import MBProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.value(forKey: "user_fb_data") != nil) {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.createMenuView()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginWithFBClicked(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .userFriends, .email], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                self.fetchFacebookData()
            }
        }
    }
    
    func fetchFacebookData() {
        let parameters = ["fields" : "id, name, first_name, last_name, picture.type(large), email , work,gender,about"]
        
        FBSDKGraphRequest.init(graphPath: "me", parameters: parameters).start { (connection, object, error) in
            if let obj = object as? NSDictionary {
                UserDefaults.standard.setValue(obj, forKey: "user_fb_data")
                print(UserDefaults.standard.value(forKey: "user_fb_data")!)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                MBProgressHUD.hide(for: self.view, animated: true)
                appDelegate.createMenuView()
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
