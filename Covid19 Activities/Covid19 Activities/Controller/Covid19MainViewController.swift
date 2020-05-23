
//
//  Covid19MainViewController.swift
//  COVID-19 Activities APP
//
//  Created by Carlos Hernandez on 5/16/20.


//  Copyright © 2020 Carlos Hernandez.
//  All rights reserved.
//  I used/incorporated previous projects, online tutorials
//  and other people's code incorporated on this project.


//  List or Tutorials on video or on documents:
//    https://www.tutorialspoint.com/how-to-make-the-corners-of-a-button-round-in-ios
//    https://www.youtube.com/watch?v=hqWJC9v9osc
//    https://www.youtube.com/watch?v=xpTGEoUMiOE
//    https://www.youtube.com/watch?v=yc5KkTyDSt4
//    https://www.raywenderlich.com/7738344-mapkit-tutorial-getting-started
//    https://www.youtube.com/watch?v=yc5KkTyDSt4
// and lot more that I forgot to write down







import UIKit
import CoreData
import SafariServices




// Global Variables and Constants
let appDelegate = UIApplication.shared.delegate as? AppDelegate

class Covid19MainViewController: UIViewController {
    
    
    //IB Outlets
    @IBOutlet weak var myTableView: UITableView!
    
    //IB Actions
    
    @IBAction func safariBrowsing(_ sender: Any) {
       //Animated auto view controller
       //https://covid19.biglocalnews.org/county-maps/index.html#/
//
//        let myURL = Foundation.URL(string: "https://covid19.biglocalnews.org/county-maps/index.html#/")!

        let anAutoViewController = SFSafariViewController(url: URL(string: "https://covid19.biglocalnews.org/county-maps/index.html#/")!)

        present(anAutoViewController, animated: true)
    }
    
    
    
    
    
    
    
    
    // Varables
    var taskArray = [Task]()
    
    
    // Constants
    let cellid = "CellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        callDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       fetchyData()
        myTableView.reloadData()
    }
    
    func fetchyData(){
        fetchData { (done) in
            if done {
                if taskArray.count > 0 {
                    myTableView.isHidden = false
                } else {
                    myTableView.isHidden = true
                }
            }
        }
    }
    
    func callDelegates(){
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.isHidden = true
    }
    
    


}

extension Covid19MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! ActivitiesAndInterests
        let task = taskArray[indexPath.row]
        cell.taskLbl.text = task.taskDescription
        if task.taskStatus == true {
            cell.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            cell.taskLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deleteData(indexPath: indexPath)
            self.fetchyData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let taskStatusAction = UITableViewRowAction(style: .normal, title: "Completed") { (action, indexPath) in
            self.updateTaskStatus(indexPath: indexPath)
            self.fetchyData()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        taskStatusAction.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        return [deleteAction, taskStatusAction]
    }
    
    
    
}

extension Covid19MainViewController {
    func fetchData(completion: (_ complete: Bool) -> ()) {
         guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do {
            taskArray = try  managedContext.fetch(request) as! [Task]
            
            //to test if date is fetched or not
            //print("Data fetched, no issues")
            completion(true)
        } catch {
            print("Unable to fetch data: ", error.localizedDescription)
            completion(false)
        }
        
    }
    
    func deleteData(indexPath: IndexPath) {
         guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        managedContext.delete(taskArray[indexPath.row])
        do {
            try managedContext.save()
            //to Test if deleted a table view cell/activity
            //print("Data Deleted")
            
        } catch {
            print("Failed to delete data: ", error.localizedDescription)
            
        }
    }
    
    func updateTaskStatus(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let task = taskArray[indexPath.row]
        if task.taskStatus == true {
            task.taskStatus = false
        } else {
            task.taskStatus = true
        }
        do {
            try managedContext.save()
            
            //to test if updates or not
            //print("Data updated")
            
        } catch {
            print("Failed to update data: ", error.localizedDescription)
            
        }
        
    }
    
    
    
    
}
