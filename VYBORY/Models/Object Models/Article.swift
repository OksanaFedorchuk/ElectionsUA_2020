//
//  Article.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 20.11.2020.
//

import Foundation

class Article {
    
    var number: String
    var title: String
    var content: String
    var favourite: Int
    var chapterNumber: String
    
    init(number: String, title: String, content: String, favourite: Int, chapterNumber: String) {
        self.number = number
        self.title = title
        self.content = content
        self.favourite = favourite
        self.chapterNumber = chapterNumber
    }
}
