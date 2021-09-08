//
//  ContactsVC.swift
//  DemoProject
//
//  Created by Admin on 08/09/21.
//

import UIKit
import RealmSwift

class ContactsVC: UIViewController {
    
    let realm = try! Realm()
    var contacts: Results<Contact>!
    
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var contactsTableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        contacts = realm.objects(Contact.self).sorted(byKeyPath: "name")
    }

   
    @IBAction func addContactClicked(_ sender: UIButton) {
        if !nameTextField.text!.isEmpty && !phoneNumTextField.text!.isEmpty{
        try! realm.write {
            let someContact = Contact()
            someContact.name = nameTextField.text!
            someContact.Phone = phoneNumTextField.text!
            realm.add(someContact)
        }
        nameTextField.text = ""
        phoneNumTextField.text = ""
        phoneNumTextField.resignFirstResponder()
        contacts = realm.objects(Contact.self).sorted(byKeyPath: "name")
        contactsTableView.reloadData()
        } else {
        let alert = UIAlertController(title: "", message: "Some details are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert,animated:true)
        }
    }
}

extension ContactsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = tableView.dequeueReusableCell(withIdentifier: "contact")
        let item = contacts[indexPath.row]
        contact?.textLabel?.text = item.name
        contact?.detailTextLabel?.text = item.Phone
        return contact!
    }
}
