//
//  AboutUsViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 04.12.2020.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var aboutUsLabel: InteractiveLabel?
    
    @IBAction func facebookTapped(_ sender: Any) {
        if let url = K.AboutUsText.URLs.SocialMedia.Facebook {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func twitterTapped(_ sender: Any) {
        if let url = K.AboutUsText.URLs.SocialMedia.Twitter {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func telegramTapped(_ sender: Any) {
        if let url = K.AboutUsText.URLs.SocialMedia.Telegram {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func instagramTapped(_ sender: Any) {
        if let url = K.AboutUsText.URLs.SocialMedia.Instagram {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func youTubeTapped(_ sender: Any) {
        if let url = K.AboutUsText.URLs.SocialMedia.YouTube {
            UIApplication.shared.open(url)
        }
    }
    
    
    override func viewDidLoad() {
        
        
        
        let plainAttributedString = NSMutableAttributedString(
            string: K.AboutUsText.Text.String1,
            attributes: nil
        )
        
        let attributedLinkString = NSMutableAttributedString(
            string: K.AboutUsText.Text.WebsiteLinkString,
            attributes: [
                NSAttributedString.Key.foregroundColor: K.Color.MyBlue,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.underlineColor: K.Color.MyBlue,
                NSAttributedString.Key.attachment: K.AboutUsText.URLs.Platforms.Website
            ])
        
        
        let attributedLinkString1 = NSMutableAttributedString(
            string: K.AboutUsText.Text.MapLinkString,
            attributes:[
                NSAttributedString.Key.foregroundColor: K.Color.MyBlue,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.underlineColor: K.Color.MyBlue,
                NSAttributedString.Key.attachment: K.AboutUsText.URLs.Platforms.Map
            ])
        
        let attributedLinkString2 = NSMutableAttributedString(
            string: K.AboutUsText.Text.DaniLinkString,
            attributes:[
                NSAttributedString.Key.foregroundColor: K.Color.MyBlue,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.underlineColor: K.Color.MyBlue,
                NSAttributedString.Key.attachment: K.AboutUsText.URLs.Platforms.Dani
            ])
        
        let attributedLinkString3 = NSMutableAttributedString(
            string: K.AboutUsText.Text.AnalizatorLinkString,
            attributes:[
                NSAttributedString.Key.foregroundColor: K.Color.MyBlue,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.underlineColor: K.Color.MyBlue,
                NSAttributedString.Key.attachment: K.AboutUsText.URLs.Platforms.Analizator
            ])
        
        let plainAttributedString1 = NSMutableAttributedString(string: K.AboutUsText.Text.String2, attributes: nil)
        
        let fullAttributedString = NSMutableAttributedString()
        
        fullAttributedString.append(plainAttributedString)
        fullAttributedString.append(attributedLinkString)
        fullAttributedString.append(attributedLinkString1)
        fullAttributedString.append(attributedLinkString2)
        fullAttributedString.append(attributedLinkString3)
        fullAttributedString.append(plainAttributedString1)
        
        aboutUsLabel?.attributedText = fullAttributedString
    }
}
