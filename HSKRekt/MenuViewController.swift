import UIKit
import CoreData

// variables globales
var hskLevel=1
var voiceEnabled=true




// MENU VIEW CONTROLLER

class MenuViewController: UIViewController {
    
    var scoreTotalActuel:Int=0
     let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Calculer le score total à partir de la base de donnée
        // les autres view ne font que mettre à jour à ce chiffre, sans calculer à chaque fois le score à partir de la base de donnée.
        
        let motsRequest=NSFetchRequest<Mot>(entityName: "Mot")
        let mots=try! context.fetch(motsRequest)
        scoreTotalActuel=0
        for mot in mots{
            scoreTotalActuel+=Int(mot.score)
        }
   

    }
    
    override func viewDidLoad() {
        // check au lancement de l'application si la base de donné est vide
        
        let defaults = UserDefaults.standard
        let hasHSK2 = defaults.bool(forKey: "hasHSK2")
        if defaults.integer(forKey: "hskLevel")==0{
        defaults.set(true, forKey: "voiceEnabled")
            defaults.set("1",forKey: "hskLevel")
        }
        
        voiceEnabled =  defaults.bool(forKey: "voiceEnabled")
        hskLevel = defaults.integer(forKey: "hskLevel")
     
        if !hasHSK2{_=Loader()}
        super.viewDidLoad()
          }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                // passer scoreTotalActuel à enterWord Scene pour qu'elle affiche et update le score
        if segue.identifier=="toTypePinyinScene"{
            (segue.destination as! EnterWordViewController).scoreTotalActuel=scoreTotalActuel
        }
    }
  }
