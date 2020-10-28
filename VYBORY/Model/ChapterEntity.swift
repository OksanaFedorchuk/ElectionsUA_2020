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
            let nserror = error as NSError
            print("Fail creating the table Chapters. Error: \(nserror)")
        }
    }
    
    func getChapterNumbersFiltered(by selectedBook: String) -> [String] {
        var chapterNumbers = Array<String>()
        do {
            let filterCondition = (bookNumber == selectedBook)
            if let chapters = try Database.shared.connection?.prepare(self.tblChapters.filter(filterCondition)) {
                for chapterNumber in chapters {
                    let number = chapterNumber[ChaptersEntity.shared.number]
                    chapterNumbers.append(number)
                }
            }
        } catch {
            let nserror = error as NSError
            print("Cannot list quesry objects in tblChapters. Error: \(nserror), \(nserror.userInfo)")
        }
        return chapterNumbers
    }
    
    func getChapterTitleFiltered(by selectedBook: String) -> [String] {
        var chapterTitles = Array<String>()
        do {
            let filterCondition = (bookNumber == selectedBook)
            if let titles = try Database.shared.connection?.prepare(self.tblChapters.filter(filterCondition)) {
                for chapterTitle in titles {
                    let title = chapterTitle[ChaptersEntity.shared.title]
                    chapterTitles.append(title)
                }
            }
        } catch {
            let nserror = error as NSError
            print("Cannot list quesry objects in tblChapters. Error: \(nserror), \(nserror.userInfo)")
        }
        return chapterTitles
    }
}
