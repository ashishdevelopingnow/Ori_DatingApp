//
//  MatchViewController.swift
//  Ori_DevelopingNow
//
//  Created by ashish nakoti on 8/9/17.
//  Copyright © 2017 Yuji Hato. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit


class MatchViewController: UIViewController {

    var maleObject : [String : Any]?
    var femaleObject : [String : Any]?
    
    @IBOutlet weak var profileImgMale: UIImageView!
    @IBOutlet weak var profileImgFemale: UIImageView!
    @IBOutlet weak var lblMale: UILabel!
    @IBOutlet weak var lblFemale: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUIData()
    }
    
    func setUIData(){
    
        self.view.layoutIfNeeded()
        self.lblMale.text = maleObject?["name"] as? String
        let fbMImgurl = ((maleObject?["picture"] as! [String : Any])["data"] as! [String : Any])["url"]!
        self.profileImgMale.sd_setImage(with: URL(string: fbMImgurl as! String), placeholderImage: UIImage(named: "male_placeH.jpg"))
        self.profileImgMale.layer.cornerRadius = self.profileImgMale.frame.size.width/2
        self.profileImgMale.clipsToBounds = true
        
        
        self.lblFemale.text = femaleObject?["name"] as? String
        let fbFImgurl = ((femaleObject?["picture"] as! [String : Any])["data"] as! [String : Any])["url"]!
        self.profileImgFemale.sd_setImage(with: URL(string: fbFImgurl as! String), placeholderImage: UIImage(named: "female_placeH.jpg"))
        self.profileImgFemale.layer.cornerRadius = self.profileImgFemale.frame.size.width/2
        self.profileImgFemale.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func matchButtonClicked(_ sender: Any) {
        sendFBAppInvites()
//        MTPopUp(frame: self.view.frame).show(complete: { (index) in
//            
//        }, view: self.view, animationType: MTAnimation.TopToMoveCenter, strMessage: "Work In Progress.", btnArray: ["Okay"], strTitle: "Oops!")
    }
    
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sendFBAppInvites(){
    
        let inviteDialog:FBSDKAppInviteDialog = FBSDKAppInviteDialog()
        if(inviteDialog.canShow()){
            
            let appLinkUrl:NSURL = NSURL(string: "https://www.developingnow.com/")!
            let previewImageUrl:NSURL = NSURL(string: "https://www.developingnow.com/wp-content/uploads/2017/01/developingnow_new_logo_white_01_07_17.png")!
            
            let inviteContent:FBSDKAppInviteContent = FBSDKAppInviteContent()
            inviteContent.appLinkURL = appLinkUrl as URL!
            inviteContent.appInvitePreviewImageURL = previewImageUrl as URL!
            
            inviteDialog.content = inviteContent
//            inviteDialog.delegate = self as! FBSDKAppInviteDialogDelegate
            inviteDialog.show()
        }
    }
    
    
        
}


