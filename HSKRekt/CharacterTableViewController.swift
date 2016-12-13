import UIKit
import CoreData
class CharacterTableViewController: UITableViewController {
    
    
    
    // propriétés
    
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var listeEnCours:String!
    let fetchRequest:NSFetchRequest<Mot>=Mot.fetchRequest()
    var decalage=0
    var motsSortedByDate=[Mot]()
    let dateFormatter = DateFormatter()
    var selectedRow=0
    
    
    
    
    // méthodes
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let destination=segue.destination as! DetailViewController
        
        fetchRequest.predicate=NSPredicate(format: "%K == %@", #keyPath(Mot.index), String(selectedRow+decalage))
       var mot=try! context.fetch(fetchRequest).first!
        if listeEnCours=="Review Schedule"{
            mot=motsSortedByDate[selectedRow]
        }

            destination.mot=mot
       
        
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedRow=indexPath.row
        return indexPath
    }
    override func viewDidLoad() {
        super.viewDidLoad()

         let triParDate:NSFetchRequest<Mot>=Mot.fetchRequest()
        if hskLevel==1{
            let restrictionPredicate=NSPredicate(format: "%K < %@", #keyPath(Mot.index), String(153))
            let notNew=NSPredicate(format: "%K != %@", #keyPath(Mot.date),"1000000000")
            triParDate.predicate=NSCompoundPredicate(andPredicateWithSubpredicates: [restrictionPredicate,notNew])
            
        }
        else{ triParDate.predicate=NSPredicate(format: "%K != %@", #keyPath(Mot.date),"1000000000")}
        
        
        
            triParDate.sortDescriptors=[NSSortDescriptor(key: "date", ascending: true)]
        motsSortedByDate=try! context.fetch(triParDate)
        
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "fr_FR")
        
        // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch listeEnCours{
        case "HSK 1":
            return 153
        case "HSK 2":
            return 150
        case "HSK 3":
            return 300
        case "HSK 4":
            return 600
        case "HSK 5":
            return 1200
        case "Review Schedule":
            return motsSortedByDate.count
        default:
            return 0
        }

    }



    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mot:Mot
        if listeEnCours=="Review Schedule"{
        mot=motsSortedByDate[indexPath.row]
        }
        else{
      fetchRequest.predicate=NSPredicate(format: "%K == %@", #keyPath(Mot.index), String(indexPath.row+decalage))
            mot=try! context.fetch(fetchRequest).first!}
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath)
        let characterLabel=cell.viewWithTag(1) as! UILabel
        let scoreLabel=cell.viewWithTag(2) as! UILabel
        characterLabel.text=mot.character
         scoreLabel.text=String(mot.score)
       
            let dateLabel=cell.viewWithTag(3) as! UILabel
        if mot.date != 1000000000{
            let date = Date(timeIntervalSinceReferenceDate: mot.date)
            dateLabel.text=dateFormatter.string(from: date)}
        else{
        dateLabel.text=""
        }
        
        
        
         return cell
    }
    
}
