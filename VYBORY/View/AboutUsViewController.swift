//
//  AboutUsViewController.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 04.12.2020.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    
    @IBOutlet weak var aboutUsLabel: UILabel!
    
    override func viewDidLoad() {
        
        
        
        let plainAttributedString = NSMutableAttributedString(string:
                                                                """
            Громадянська мережа ОПОРА – одна з провідних неурядових та позапартійних всеукраїнських організацій громадського контролю у сфері виборів.
            З 2007 року ОПОРА аналізує виборчий процес, проводить спостереження за всіма його етапами, працює над удосконаленням виборчого законодавства відповідно до міжнародних стандартів. Загалом за цей час до моніторингу виборів було залучено понад 20 тисяч кваліфікованих спостерігачів.

            Для своїх спостерігачів, та усіх інших учасників виборчого процесу ми розробили цей мобільний додаток із виборчим кодексом та верифікатором протоколу, який знадобиться вам у ніч підрахунку голосів. Тепер виборчий кодекс буде завжди із вами, а зручний пошук дозволить швидко знайти необхідну статтю.

            Отримати усю оперативну інформацію про перебіг Місцевих виборів 2020 року Ви можете тут: \n \n
            """, attributes: nil)
        
        let attributedLinkString = NSMutableAttributedString(string: "Вебсайт \n", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemTeal, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.systemTeal, NSAttributedString.Key.attachment: URL(string: "https://oporaua.org/")!])
        
        
        let attributedLinkString1 = NSMutableAttributedString(string: "Мапа порушень \n", attributes:[NSAttributedString.Key.foregroundColor: UIColor.systemTeal, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.systemTeal, NSAttributedString.Key.attachment: URL(string: "https://oporaua.org/map-reports")!])
        
        let attributedLinkString2 = NSMutableAttributedString(string: "Все про виборчі дані та соцмережі \n", attributes:[NSAttributedString.Key.foregroundColor: UIColor.systemTeal, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.systemTeal, NSAttributedString.Key.attachment: URL(string: "https://danivyboriv.net/")!])
        
        let attributedLinkString3 = NSMutableAttributedString(string: "Аналізатор політичної реклами \n \n", attributes:[NSAttributedString.Key.foregroundColor: UIColor.systemTeal, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.systemTeal, NSAttributedString.Key.attachment: URL(string: "https://fb.oporaua.org/")!])
        
        let plainAttributedString1 = NSMutableAttributedString(string: "І не забувайте стежити за нами в соціальних мережах:", attributes: nil)
        
        let fullAttributedString = NSMutableAttributedString()
        
        fullAttributedString.append(plainAttributedString)
        fullAttributedString.append(attributedLinkString)
        fullAttributedString.append(attributedLinkString1)
        fullAttributedString.append(attributedLinkString2)
        fullAttributedString.append(attributedLinkString3)
        fullAttributedString.append(plainAttributedString1)
        
        aboutUsLabel.attributedText = fullAttributedString
    }
}
