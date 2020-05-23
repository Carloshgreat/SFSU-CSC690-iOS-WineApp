//
//  Covid19AddViewController.swift
//   Carlos Hernandez
//
//incorporated code from: sanamsuri on 06/10/18.




import UIKit
import CoreData
import SafariServices

class ScheduleActivitiesViewController: UIViewController {
    
    // Conected IBOutlets
    @IBOutlet weak var taskTv: UITextView!
    
    
    //Animated Auto Browsers
    
    @IBAction func disnySafariBrowser(_ sender: Any) {
    //Calls the function to animate a safari browser
        presentAnimatedBrowser(urlString: "https://disneyworld.disney.go.com")
    }
    
    
    @IBAction func vegaSafariBrowser(_ sender: Any) {
        //Calls the function to animate a safari browser
            presentAnimatedBrowser(urlString: "https://www.visitlasvegas.com/")
    }
    
    @IBAction func vaticanSafariBrowser(_ sender: Any) {
        //Calls the function to animate a safari browser
            presentAnimatedBrowser(urlString: "http://www.vatican.va/content/vatican/en.html")
    }
    
    @IBAction func nySafariBrowser(_ sender: Any) {
        //Calls the function to animate a safari browser
            presentAnimatedBrowser(urlString: "https://www.nycgo.com/")
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Title of windown/view controller
            navigationItem.title = "Interests & Activities"

        // Do any additional setup after loading the view.
    }
    

    
    func presentAnimatedBrowser(urlString: String){
         //present an Animated auto view controller browser
        
        let animatedBrowser = SFSafariViewController(url: URL(string: urlString)!)
        present(animatedBrowser, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
// Incorporated from tutural documentation
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        saveTask { (done) in
            if done {
                //when we need to return
                //print("We need to return now")
                navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Try again")
            }
        }
    }
    
    
    func saveTask(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let task = Task(context: managedContext)
        task.taskDescription = taskTv.text
        task.taskStatus = false
        
        do {
            try managedContext.save()
            
            //testing when we save an entry/activity
            //print("Data Saved")
            completion(true)
        } catch {
            print("Failed to save data: ", error.localizedDescription)
            completion(false)
        }
        
        
        
    }
    
    
}
