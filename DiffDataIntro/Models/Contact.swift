//
//  Contact.swift
//  DiffDataIntro
//
//  Created by Myles Cashwell on 9/8/21.
//

import Foundation

class Contact: NSObject {
    var name: String
    var isFav: Bool = false
    
    init(name: String) {
        self.name = name
    }
}
