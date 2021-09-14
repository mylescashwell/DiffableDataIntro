//
//  ContactCell.swift
//  DiffDataIntro
//
//  Created by Myles Cashwell on 9/8/21.
//

import UIKit
import SwiftUI
import LBTATools

class ContactCell: UITableViewCell {
    let viewModel = ContactViewModel()
    lazy var row  = ContactRowView(viewModel: viewModel)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let hostingController = UIHostingController(rootView: row)
        addSubview(hostingController.view)
        hostingController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
