//
//  AttrString.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 21.01.2021.
//

import Foundation
import UIKit

extension String {

    func highlightText(
        highlight searchTerm: String?,
        fontSize: CGFloat,
        fontWeight: UIFont.Weight,
        caseInsensitivie: Bool = false
//        font: UIFont = .preferredFont(forTextStyle: .body)
    ) -> NSAttributedString?
    {
        let attributedString = NSMutableAttributedString(string: self)
        
        do {
            //            if there is a searchTerm in string
            if let searchTerm = searchTerm {
                
                let regex = try NSRegularExpression(pattern: searchTerm.trimmingCharacters(in: .whitespacesAndNewlines).folding(options: .diacriticInsensitive, locale: .current), options: .caseInsensitive)
//                let range = (self as NSString).range(of: text, options: caseInsensitivie ? .caseInsensitive : [])
                let range = NSRange(location: 0, length: self.utf16.count)
                attributedString.addAttributes([NSAttributedString.Key.foregroundColor: K.Color.MyPrimaLabel, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight)], range: range)
                
                for match in regex.matches(in: self.folding(options: .diacriticInsensitive, locale: .current), options: .withTransparentBounds, range: range) {
                    attributedString.addAttributes([NSAttributedString.Key.foregroundColor: K.Color.MyBlue, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight)], range: match.range)
                }
            }
            //            if there is no searchTerm in string
            if searchTerm == nil {
                let range = NSRange(location: 0, length: self.utf16.count)
                
                attributedString.addAttributes([NSAttributedString.Key.foregroundColor: K.Color.MyPrimaLabel, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight)], range: range)
            }
            
            return attributedString
            
        } catch {
            debugPrint(error)
            return nil
        }
    }

}
