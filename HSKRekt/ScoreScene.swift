import UIKit
import CoreData
private let reuseIdentifier = "gridCell"

class ScoreScene: UICollectionViewController {
let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest:NSFetchRequest<Mot>=Mot.fetchRequest() 
    
      
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    

        // Do any additional setup after loading the view.
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if hskLevel==2{
        
            return 303}
        
        else {return 153}
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fetchRequest.predicate=NSPredicate(format: "%K == %@", #keyPath(Mot.index), String(indexPath.row))
        let mot=try! context.fetch(fetchRequest).first!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let label=cell.viewWithTag(1000) as! UILabel
        label.text=mot.character
        let scoreLabel=cell.viewWithTag(1001) as! UILabel
        scoreLabel.text=String(mot.score)
        if mot.score<5{
        scoreLabel.backgroundColor=UIColor(colorLiteralRed: 1, green: 0, blue: 0, alpha: 0.5)
        }
        else {scoreLabel.backgroundColor=UIColor(colorLiteralRed: 0, green: 128/256, blue: 0, alpha: 0.5)}
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
