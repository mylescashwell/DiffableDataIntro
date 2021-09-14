//
//  ContentView.swift
//  DiffDataIntro
//
//  Created by Myles Cashwell on 9/7/21.
//

import SwiftUI
import LBTATools
//MARK: - ContentView
struct ContactRowView: View {
    @ObservedObject var viewModel: ContactViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
            Text(viewModel.name)
            Spacer()
            Image(systemName: viewModel.isFav ? "star.fill" : "star")
        }.padding(24)
    }
}

//MARK: - DiffableTableViewController
class DiffableSource: UITableViewDiffableDataSource<SectionType, Contact> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

class DiffableTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationView()
        setUpSource()
    }
    
    lazy var source: DiffableSource = .init(tableView: self.tableView) { _, indexPath, contact in
        let cell = ContactCell(style: .default, reuseIdentifier: nil)
        cell.viewModel.name  = contact.name
        cell.viewModel.isFav = contact.isFav
        return cell
    }
    
    private func configureNavigationView() {
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles  = true
        navigationItem.rightBarButtonItem = .init(title: "Add",
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector (addContact))
    }
    
    @objc private func addContact() {
        let addContactVC = AddContactVC(viewModel: ContactViewModel()) { name, sectionType in
            if name.isEmpty {
                self.dismiss(animated: true)
            } else {
                self.dismiss(animated: true)
                var snapshot = self.source.snapshot()
                snapshot.appendItems([.init(name: name)], toSection: sectionType)
                self.source.apply(snapshot)
            }
        }
        let hostingController = UIHostingController(rootView: addContactVC)
        present(hostingController, animated: true)
    }
    
    
    private func setUpSource() {
        var snapshot = source.snapshot()
        snapshot.appendSections([.ceo, .peasants])
        snapshot.appendItems([.init(name: "RJ Scaringe"),
                              .init(name: "Tim Cook"),
                              .init(name: "ME!")], toSection: .ceo)
        
        snapshot.appendItems([.init(name: "Jeff Bezos"),
                              .init(name: "Bill Gates"),
                              .init(name: "Mark Zuckerberg")], toSection: .peasants)
        source.apply(snapshot)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = section == 0 ? "CEOs" : "Other Notable Humans"
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completion in
            completion(true)
            
            var snapshot = self.source.snapshot()
            guard let contact = self.source.itemIdentifier(for: indexPath) else { return }
            snapshot.deleteItems([contact])
            self.source.apply(snapshot)
        }
        
        let favoriteAction = UIContextualAction(style: .normal, title: "Fav") { _, _, completion in
            completion(true)
            var snapshot = self.source.snapshot()
            guard let contact = self.source.itemIdentifier(for: indexPath) else { return }
            contact.isFav.toggle()
            snapshot.reloadItems([contact])
            self.source.apply(snapshot)
        }
        return .init(actions: [deleteAction, favoriteAction])
    }
}

//MARK: - ContentView_Previews
struct DiffableContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        UINavigationController(rootViewController: DiffableTableViewController(style: .insetGrouped))
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiffableContainer()
    }
}
