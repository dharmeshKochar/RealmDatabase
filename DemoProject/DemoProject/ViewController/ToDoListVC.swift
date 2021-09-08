//
//  ToDoListVC.swift
//  DemoProject
//
//  Created by Admin on 08/09/21.
//

import UIKit
import RealmSwift

class ToDoListVC: UIViewController {

    let realm = try! Realm()
    var tasks: Results<Task>!
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var toDoListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoListTableView.dataSource = self
        toDoListTableView.delegate = self
        tasks = realm.objects(Task.self)
    }
    
    @IBAction func AddToListClicked(_ sender: UIButton) {
        try! realm.write {
            let someTask = Task()
            someTask.task = taskTextField.text!
            realm.add(someTask)
        }
        taskTextField.text = ""
        taskTextField.resignFirstResponder()
        
        tasks = realm.objects(Task.self)
        toDoListTableView.reloadData()
    }
}

extension ToDoListVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = toDoListTableView.dequeueReusableCell(withIdentifier: "taskCell")
        let aTask = tasks[indexPath.row]
        task?.textLabel?.text = aTask.task
        return task!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let atask = tasks[indexPath.row]
            try! realm.write({
                realm.delete(atask)
            })
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}


