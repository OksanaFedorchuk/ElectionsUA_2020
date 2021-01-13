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
    
    private let tblChapters = Table(K.Database.Table.Chapters)
    
    private let number = Expression<String>(K.Database.Row.Number)
    private let title = Expression<String>(K.Database.Row.Title)
    private let bookNumber = Expression<String>(K.Database.Row.BookNumber)
    
    init() {
        do {
            if let connection = Database.shared.connection {
                try connection.run(tblChapters.create(temporary: false, ifNotExists: true, withoutRowid: true, block: { (table) in
                    table.column(self.number)
                    table.column(self.title)
                    table.column(self.bookNumber)
                }))
            } else {
            }
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func getChaptersFiltered(by currentItem: String) -> [Chapter] {
        var chapters = [Chapter]()
        do {
            let filterCondition = (bookNumber == currentItem) || (number == currentItem)
            if let chaptersTable = try Database.shared.connection?.prepare(self.tblChapters.filter(filterCondition)) {
                for chapter in chaptersTable {
                    let chapter = Chapter(number: chapter[ChapterEntity.shared.number], title: chapter[ChapterEntity.shared.title], bookNumber: chapter[ChapterEntity.shared.bookNumber])
                    chapters.append(chapter)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return chapters
    }
}
