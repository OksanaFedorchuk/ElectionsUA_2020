//
//  Database.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 22.10.2020.
//

import Foundation
import SQLite

class Database {
    static let shared = Database()
    public let connection: Connection?

    init(){
        do {
            let path = Bundle.main.path(forResource: "code", ofType: "db")!
            connection = try Connection(path)
        } catch {
            connection = nil
            let nserror = error as NSError
            print ("Cannot connect to Database. Error is: \(nserror), \(nserror.userInfo)")
        }
    }
}
