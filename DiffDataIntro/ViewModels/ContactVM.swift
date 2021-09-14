//
//  ContactVM.swift
//  DiffDataIntro
//
//  Created by Myles Cashwell on 9/8/21.
//

import Foundation

class ContactViewModel: ObservableObject {
    @Published var name             = ""
    @Published var isFav            = false
    @Published var contactTextField = ""
    @Published var sectionType      = SectionType.ceo
}
