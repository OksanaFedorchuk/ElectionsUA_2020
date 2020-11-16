//
//  ChapterEntity.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 26.10.2020.
//

import Foundation
import SQLite

class ChapterEntity {
    
    static let shared = ChapterEntity()
    
    private let tblChapters = Table("chapters")
    
    private let number = Expression<String>("number")
    private let title = Expression<String>("title")
    private let bookNumber = Expression<String>("book_number")
    
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
            print("Fail creating the table Chapters. Error: \(error)")
        }
    }
    
    func getChaptersFiltered(by selectedBook: String) -> [[String]] {
        var chapters = [[String]]()
        do {
            let filterCondition = (bookNumber == selectedBook)
            if let chaptersTable = try Database.shared.connection?.prepare(self.tblChapters.filter(filterCondition)) {
                for chapter in chaptersTable {
                    let number = chapter[ChapterEntity.shared.number]
                    let title = chapter[ChapterEntity.shared.title]
                    chapters.append([number, title])
                }
            }
        } catch {
            print("Cannot list query objects in tblChapters. Error: \(error), \(error.localizedDescription)")
        }
        return chapters
    }
}
