
import UIKit
class DetailViewController: UIViewController {
    
    @IBOutlet weak var characterLabel:UILabel!
    @IBOutlet weak var pinyinLabel:UILabel!
    @IBOutlet weak var exempleTextView:UITextView!
      @IBOutlet weak var definitionTextView:UITextView!
    @IBOutlet weak var scoreLabel:UILabel!
    
    
    var haveBackItem = true
    
    var mot:Mot!
  
    
    @IBAction func dissmissA(){
        dismiss(animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text=String(mot.score)
        characterLabel.text=mot.character
        pinyinLabel.text=mot.pinyin
        exempleTextView.text=mot.exemple
 
        definitionTextView.text=mot.definition
  
        if !haveBackItem {
            navigationItem.hidesBackButton = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   }
