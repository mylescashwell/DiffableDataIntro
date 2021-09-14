//
//  AddContactVC.swift
//  DiffDataIntro
//
//  Created by Myles Cashwell on 9/10/21.
//

import SwiftUI

struct AddContactVC: View {
    @ObservedObject var viewModel = ContactViewModel()
    var addingContact: (String, SectionType) -> () = { _, _ in }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Button {
                    self.addingContact(viewModel.contactTextField, viewModel.sectionType)
                } label: {
                    XDismissButton()
                }
            }
            TextField("Name", text: $viewModel.contactTextField)
            
            Picker(selection: $viewModel.sectionType, label: Text("Dont Care"), content: {
                Text("CEOs").tag(SectionType.ceo)
                Text("Other Notable Humans").tag(SectionType.peasants)
            }).pickerStyle(SegmentedPickerStyle())
            
            Button {
                self.addingContact(viewModel.contactTextField, viewModel.sectionType)
            } label: {
                HStack {
                    Spacer()
                    Text("Add Contact")
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                .background(Color.blue)
                .cornerRadius(25)
            }
            Spacer()
        }.padding()
    }
}

struct AddContactVC_Previews: PreviewProvider {
    static var previews: some View {
        AddContactVC()
    }
}
