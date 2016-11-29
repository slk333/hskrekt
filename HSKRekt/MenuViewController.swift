import UIKit
import CoreData
class MenuViewController: UIViewController {
    var scoreGlobalActuel:Int=0
     let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchAllWords=NSFetchRequest<Mot>(entityName: "Mot")
        let allWords=try! context.fetch(fetchAllWords)
       // print("allWords.count")
      //  print(allWords.count)
        for mot in allWords{
            scoreGlobalActuel+=Int(mot.score)
        }
   //     print(scoreGlobalActuel)

    }
    
    override func viewDidLoad() {
        let defaults = UserDefaults.standard
        let isLoaded = defaults.bool(forKey: "isLoaded")
        if !isLoaded{_=Loader()}
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="startTraining"{
            (segue.destination as! EnterWordViewController).scoreGlobalActuel=scoreGlobalActuel
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
