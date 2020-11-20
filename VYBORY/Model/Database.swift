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
            
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first! as String
            
            connection = try Connection("\(path)/code.db")
            print("Database created")
            
        } catch {
            
            connection = nil
            print ("Cannot connect to Database. Error is: \(error), \(error.localizedDescription)")
        }
    }
}
