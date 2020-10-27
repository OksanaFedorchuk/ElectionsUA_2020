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
    
    let tblChapters = Table("chapters")
    
    let number = Expression<String>("number")
    let title = Expression<String>("title")
    let bookNumber = Expression<String>("book_number")
    
    init() {
        do {
            if let connection = Database.shared.connection {
                try connection.run(tblChapters.create(temporary: false, ifNotExists: true, withoutRowid: true, block: { (table) in
                    table.column(self.number)
                    table.column(self.title)
                    table.column(self.bookNumber)
                }))
                print ("Table Chapters has been created")
            } else {
                print ("Fail creating the table Chapters")
            }
        }catch {
            let nserror = error as NSError
            print("Fail creating the table Chapters. Error: \(nserror)")
        }
    }
}
