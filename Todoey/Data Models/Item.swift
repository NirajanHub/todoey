//
//  Data Model.swift
//  Todoey
//
//  Created by Nirajan Chapagain on 4/22/20.
//  Copyright © 2020 Nirajan Chapagain. All rights reserved.
//

import Foundation

class Item : Codable{
    var title: String = ""
    var done: Bool = false
}
