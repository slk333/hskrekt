import UIKit
import CoreData
import AVFoundation
class EnterWordViewController: UIViewController,UITextFieldDelegate {
    
    
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var currentMot:Mot!
    var correctText:String!
    var scoreGlobalActuel:Int=0
    var stringToEnter=""
    
    @IBOutlet weak var characterLabel:UILabel!
    @IBOutlet weak var answerTF: UITextField!
    @IBOutlet weak var correctOrFalseSymbolLabel:UILabel!
    @IBOutlet weak var scoreBar:UIProgressView!
    @IBOutlet weak var infoButton: UIButton!
    
    let defaultGreenColor=UIColor(colorLiteralRed: 65/255, green: 199/255, blue: 34/255, alpha: 0.75)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! DetailViewController).mot=currentMot

    
    }
    
    @IBAction func textChanged(_ sender: UITextField) {
        // CHECK ANSWER
        
        if sender.text==currentMot.pinyin{
          
            // si c'est la bonne réponse
            
            // augmentation du score si il n'y a pas eu de mauvaise réponse
            if correctOrFalseSymbolLabel.text! != "✗"{
           
                if currentMot.score<10{currentMot.score+=1}
            updateExpirationDateAndSave()
                 scoreGlobalActuel+=1
            //    print(currentMot.score)
            
            }

            // gestion de l'interface
            correctOrFalseSymbolLabel.textColor=defaultGreenColor
            correctOrFalseSymbolLabel.text="✓"
            
            
            // schedule la new question dans 1 seconde
            _=Timer.scheduledTimer(withTimeInterval: 1.1, repeats: false, block: {_ in self.createNewQuestion()})
            sender.keyboardType = .default
            sender.reloadInputViews()
            
            
            
        }
        else if sender.text?.characters.count==currentMot.pinyin.characters.count {
            // si c'est la mauvaise réponse, baisser le score une fois, et ignorer les prochaines mauvaises réponses, jusqu'à ce que l'utilisateur ait la bonne réponse
            guard correctOrFalseSymbolLabel.text != "✗" else {return}
            
            // première mauvaise réponse
            // gestion de l'interface
            correctOrFalseSymbolLabel.text="✗"
            correctOrFalseSymbolLabel.textColor=UIColor(colorLiteralRed: 1, green: 0, blue: 0, alpha: 0.75)
            // mise à jour du score
            if currentMot.score>3{currentMot.score=3}
            else {
                if currentMot.score>1{currentMot.score-=2}
                else{ if currentMot.score==1{currentMot.score=0}}}
           updateExpirationDateAndSave()
            scoreGlobalActuel-=1
          //  print(currentMot.score)
            
            
            return}
        else if correctText[correctText.index(correctText.startIndex, offsetBy: sender.text!.characters.count)] == " "  && !stringToEnter.isEmpty{
            
        sender.text?.append(" ")
            
        }
        
        
    }
    
    
    func toggleOff(){
    correctOrFalseSymbolLabel.text=""
        answerTF.text=""
    }
    
    func updateExpirationDateAndSave(){
        let tempsÀajouter=100*pow(3, Double(currentMot.score))
        currentMot.date=Date(timeIntervalSinceNow: tempsÀajouter).timeIntervalSinceReferenceDate
        try! context.save()
    }
    
    // REAGIR AU TEXTE ENTRÉ
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        stringToEnter=string
       
        if textField.text?.characters.count==correctText.characters.count && !string.isEmpty{
        return false
        }
        
        if string.isEmpty{
            guard let characterToDeleteIndex=correctText.index(correctText.startIndex, offsetBy: range.location,limitedBy:correctText.index(before: correctText.endIndex)) else{return true}
            if Int(String(correctText[characterToDeleteIndex])) != nil{
                textField.keyboardType = .numbersAndPunctuation
                textField.reloadInputViews()
                return true
            }
            else if textField.keyboardType == .numbersAndPunctuation{
                textField.keyboardType = .default
                textField.reloadInputViews()
                return true
            }
            return true
        
        
        }
      
     
        /* Il faut obtenir le caractère qui suit celui qui est entré. L'index du caractère entré correspond au lowerbound du range modifié, et l'index du caractère suivant correspond au upperBound du range modifié*/
        
        guard let existingFollowingCharacterIndex=correctText.index(correctText.startIndex, offsetBy: range.location+1,limitedBy:correctText.index(before: correctText.endIndex))
            
            else{
                // on est dans la situation où l'utilisateur est en train d'écrire le dernier caractère du mot à étudier, donc le dernier ton
                
               
                
                // CHECK LA REPONSE
                
               
                return true
        }
        
        // cas où l'utilisateur doit encore écrire au moins un caractère après celui qu'il est en train d'écrire
        
        // si le prochain caractère qu'il devra écrire est un entier, switch le clavier
        
        if Int(String(correctText[existingFollowingCharacterIndex])) != nil{
            textField.keyboardType = .numbersAndPunctuation
            textField.reloadInputViews()
        }
            
            // si le prochain caractère est une lettre et que le clavier est numérique, le mettre en mode lettres
            
        else if textField.keyboardType == .numbersAndPunctuation {textField.keyboardType = .default
            textField.reloadInputViews() }
        
        
        // si le prochain caractère à entrer est un espace, prévoir un timer pour rajouter automatiquement l'espace
        
        
        // à défaut de régles particulières, autoriser l'écriture
        return true
    }
    
    func createNewQuestion(){
        toggleOff()
        scoreBar.progress=Float(scoreGlobalActuel)/Float(1530)
        
        // choix d'un nouveau mot
        // trouver les mots expirés
        let dateOfNow:Double=Date(timeIntervalSinceNow: 0).timeIntervalSinceReferenceDate
        let expiredWordsRequest=NSFetchRequest<Mot>(entityName: "Mot")
        expiredWordsRequest.predicate=NSPredicate(format: "%K < %@", #keyPath(Mot.date), String(dateOfNow))
        let sorting=NSSortDescriptor(key: "date", ascending: true)
        expiredWordsRequest.sortDescriptors=[sorting]
        
        guard  let expiredWords=try? context.fetch(expiredWordsRequest) else {return}
        
            if expiredWords.count != 0{
                // si il y a un mot à réviser, on prend le plus ancien
            currentMot=expiredWords.first
            }
            
            else{
                
            // Il n'y a plus de mot à réviser
         //   print("Il n'y a plus de mot à réviser")
            // 1) il reste des mots jamais révisés
                
            let fetchNeverSeenWordRequest=NSFetchRequest<Mot>(entityName: "Mot")
            fetchNeverSeenWordRequest.predicate=NSPredicate(format: "%K == %@", #keyPath(Mot.date), "1000000000")
            if let neverSeenWords=try? context.fetch(fetchNeverSeenWordRequest){
               // print("neverSeenWordsCount : \(neverSeenWords.count)")
            currentMot=neverSeenWords[Int(arc4random_uniform(UInt32(neverSeenWords.count)))]
            }
                // il ne reste plus du tout de mots à réviser

            else {
            answerTF.text="Come back later !😂"
            characterLabel.text=""
            infoButton.isHidden=true
                 return
                }
           
        
        }
        
        
        
        // choix d'un mot au hasard
       
        
        // mise à jour de l'interface
      
        characterLabel.text=currentMot.character
        correctText=currentMot.pinyin!
      
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createNewQuestion()
        answerTF.becomeFirstResponder()
        
        
        
        // Do any additional setup after loading the view.
    }
}
