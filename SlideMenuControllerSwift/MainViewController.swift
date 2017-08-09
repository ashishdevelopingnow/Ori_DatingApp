//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by DevelopingNow on 12/3/14.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit
import SDWebImage
import MBProgressHUD


class MainViewController: UIViewController {

    @IBOutlet weak var tableViewMale: UITableView!
    @IBOutlet weak var tableViewFemale: UITableView!
    
    var friendsArray = [Any]()
    var femaleFriends = [Any]()
    var maleFriends = [Any]()
    var maleObject : [String : Any]?
    var femaleObject : [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.registerCellNib(DataTableViewCell.self)
        self.title = "Home"
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    
    func fetchFacebookFriendList() {
        let params = ["fields": "id, gender, name, picture"]
        FBSDKGraphRequest.init(graphPath: "me/friends", parameters: params).start { (connection, object, error) in
            if let obj = object as? NSDictionary {
                print(obj)
                self.friendsArray.append(contentsOf: (obj.value(forKey: "data") as! [Any]))
                self.makeGenderBaseFriendList()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "matchViewSegue" {
            let matchVC = segue.destination as! MatchViewController
            matchVC.maleObject = self.maleObject
            matchVC.femaleObject = self.femaleObject
        }
    }
    
    func makeGenderBaseFriendList(){
    
        for items in self.friendsArray {
                print(items)
            let obj = items as! [String : Any]
            if obj["gender"] as! String == "female" {
                femaleFriends.append(items)
            }else{
                maleFriends.append(items)
            }
        }
        MBProgressHUD.hide(for: self.view, animated: true)
        self.tableViewFemale.reloadData()
        self.tableViewMale.reloadData()
    }

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        fetchFacebookFriendList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView != self.tableViewFemale {
            if maleFriends.count == 0 {
                MTPopUp(frame: self.view.frame).show(complete: { (index) in

                }, view: self.view, animationType: MTAnimation.TopToMoveCenter, strMessage: "No Male Friend Found for match.", btnArray: ["Okay"], strTitle: "Oops!")
            }else{
                let obj = maleFriends[indexPath.row] as! [String : Any]
                self.maleObject = obj
            }
        }else{
            if femaleFriends.count == 0 {
                MTPopUp(frame: self.view.frame).show(complete: { (index) in
                    
                }, view: self.view, animationType: MTAnimation.TopToMoveCenter, strMessage: "No Female Friend Found for match.", btnArray: ["Okay"], strTitle: "Oops!")
            }else{
                let obj = femaleFriends[indexPath.row] as! [String : Any]
                self.femaleObject = obj
            }
        }
        if self.femaleObject != nil && self.maleObject != nil {
            self.performSegue(withIdentifier: "matchViewSegue", sender: nil)
        }
        
    }
}

extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableViewMale {
            if maleFriends.count == 0 {
                return 1
            }else{
                return self.maleFriends.count
            }
        }else{
            if femaleFriends.count == 0 {
                return 1
            }else{
                return self.femaleFriends.count
            }
        }
        
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier:"mainCell") as! MainTableViewCell
        
        if tableView != self.tableViewFemale {
            if maleFriends.count==0 {
                cell.lblUserName.text = "0 Found"
            }else{
                let obj = maleFriends[indexPath.row] as! [String : Any]
                cell.lblUserName.text = obj["name"] as? String
                let fbImgurl = ((obj["picture"] as! [String : Any])["data"] as! [String : Any])["url"]!
                cell.userImgView.sd_setImage(with: URL(string: fbImgurl as! String), placeholderImage: UIImage(named: "male_placeH.jpg"))
            }
        }else{
            if femaleFriends.count==0 {
                cell.lblUserName.text = "0 Found"
            }else{
                let obj = femaleFriends[indexPath.row] as! [String : Any]
                cell.lblUserName.text = obj["name"] as? String
                let fbImgurl = ((obj["picture"] as! [String : Any])["data"] as! [String : Any])["url"]!
                cell.userImgView.sd_setImage(with: URL(string: fbImgurl as! String), placeholderImage: UIImage(named: "female_placeH.jpg"))
            }
        }
        
        return cell
    }
}

extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
