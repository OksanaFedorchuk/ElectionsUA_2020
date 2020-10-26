//
//  ChapterEntity.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 26.10.2020.
//

import Foundation
import SQLite

class ChaptersEntity {
    static let shared = ChaptersEntity()
    
    let chapters = Table("chapters")
    let number = Expression<String>("number")
    let title = Expression<String>("title")
    let bookNumber = Expression<String>("book_number")
}
