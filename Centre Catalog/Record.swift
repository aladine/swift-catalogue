//
//  Record.swift
//  NewRecipe
//
//  Created by Little Lives on 27/6/14.
//  Copyright (c) 2014 com.appcoda. All rights reserved.
//

import Foundation

class Record {
    var id = 0
    var name :NSString = ""
    var code = ""
    var unique_code = ""

    
    init(id: Int, name: String, code: String, unique_code: String) {
        self.id = id
        self.name = name
        self.code = code
        self.unique_code = unique_code
    }
}
