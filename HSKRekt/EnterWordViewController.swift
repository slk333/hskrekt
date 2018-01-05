import UIKit
import CoreData
import AVFoundation




class EnterWordViewController: UIViewController,UITextFieldDelegate {
    
    
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var currentMot:Mot!
    var correctText:String!
    var scoreTotalActuel:Int=0
    var stringToEnter=""
    let defaultGreenColor=UIColor(red: 65/255, green: 199/255, blue: 34/255, alpha: 0.75)
    var incrementUp = Int32(3)

  let speechSynthesizer = AVSpeechSynthesizer()
  let voice=AVSpeechSynthesisVoice.init(language: "zh-CN")
    var utterance=AVSpeechUtterance(string: "我")
    

    
    @IBOutlet weak var characterLabel:UILabel!
    @IBOutlet weak var definitionTV:UITextView!
    @IBOutlet weak var answerTF: UITextField!
    @IBOutlet weak var correctOrFalseSymbolLabel:UILabel!
    @IBOutlet weak var scoreBar:UIProgressView!
    @IBOutlet weak var infoButton: UIButton!
     @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var wrongButton: UIButton!
    
    @IBAction func backFromDefinitionScene(segue:UIStoryboardSegue){
        
        createNewQuestion()
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // on va dans la scene de definition
        guard let _ = sender as? UIButton else{return}
        
        // si c'est via le bouton faux, on réduit le score
        
        decreaseScoreAndSave()
        
        // passer le mot actuel à la dictionaryScene
        (segue.destination as! DetailViewController).mot=currentMot
        (segue.destination as! DetailViewController).haveBackItem = false
}
    
    @IBAction func skip(_ sender: UIButton){
        if correctOrFalseSymbolLabel.text! != "✗"{
            
            
          increaseScoreAndSave()
            
        }
        
        // gestion de l'interface
        correctOrFalseSymbolLabel.textColor=defaultGreenColor
        correctOrFalseSymbolLabel.text="✓"
        characterLabel.text=currentMot.character
        answerTF.text=currentMot.pinyin
        // afficher la définition
        skipButton.isEnabled=true
        wrongButton.isEnabled=false
        definitionTV.text=currentMot.definition
        // VOICE
        if voiceEnabled{
            self.speechSynthesizer.speak(utterance)}
        
        
        
        
        // schedule la new question dans 1 seconde
        
        _=Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in self.createNewQuestion()})
        
        
    }
    
    func increaseScoreAndSave(){
        
        if currentMot.score < 6 {incrementUp = 3}
        if currentMot.score >= 6 {incrementUp = 2}
        if currentMot.score >= 8 {incrementUp = 1}
        if currentMot.score == 10 {incrementUp = 0}
        if currentMot.score == 11 {incrementUp = -1}
        currentMot.score += incrementUp
        updateExpirationDateAndSave()
        scoreTotalActuel += Int(incrementUp)
    }
    
    func decreaseScoreAndSave(){
        if currentMot.score>3{currentMot.score=3}
        else {
            if currentMot.score>1{currentMot.score-=2}
            else{ if currentMot.score==1{currentMot.score=0}}}
        updateExpirationDateAndSave()
        scoreTotalActuel-=1
        
    }
    
    
    
    @IBAction func textChanged(_ sender: UITextField) {
        // User a écrit quelque chose
        // Vérifier si c'est juste
        
        if sender.text==currentMot.pinyin{
          
            // c'est la bonne réponse
            
            // augmentation du score si il n'y a pas eu de mauvaise réponse
            if correctOrFalseSymbolLabel.text! != "✗"{
           
                increaseScoreAndSave()
            
            }

            // gestion de l'interface
            correctOrFalseSymbolLabel.textColor=defaultGreenColor
            correctOrFalseSymbolLabel.text="✓"
            characterLabel.text=currentMot.character
            answerTF.text=currentMot.pinyin
            // afficher la définition
            skipButton.isHidden=true
            definitionTV.text=currentMot.definition
            // VOICE
            if voiceEnabled{
                self.speechSynthesizer.speak(utterance)}
           
            
            
            
            // schedule la new question dans 1 seconde
            _=Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: {_ in self.createNewQuestion()})

            
            
            
        }
            // c'est faux (ou incomplet)
        else if sender.text?.count==currentMot.pinyin.count {
            // si c'est la mauvaise réponse, baisser le score une fois, et ignorer les prochaines mauvaises réponses, jusqu'à ce que l'utilisateur ait la bonne réponse
            guard correctOrFalseSymbolLabel.text != "✗" else {return}
            
            // première mauvaise réponse
            // gestion de l'interface
            correctOrFalseSymbolLabel.text="✗"
            correctOrFalseSymbolLabel.textColor=UIColor(red: 1, green: 0, blue: 0, alpha: 0.75)
            characterLabel.text=currentMot.character
            answerTF.text=currentMot.pinyin
            // mise à jour du score
            
            decreaseScoreAndSave()
            
            return}
            
            // insertion automatique d'un espace si c'est le prochain caractère à entrer
        else if correctText[correctText.index(correctText.startIndex, offsetBy: sender.text!.count)] == " "  && !stringToEnter.isEmpty{
            
        sender.text?.append(" ")
            
        }
        
        
    }
    
    
    func toggleOff(){
        
        correctOrFalseSymbolLabel.text=""
        answerTF.text=""
        definitionTV.text=""
    }
    
    func updateExpirationDateAndSave(){
        // définition d'une nouvelle date de révision et sauvegarde
        
        let tempsÀajouter=100*pow(3, Double(currentMot.score))
        currentMot.date=Date(timeIntervalSinceNow: tempsÀajouter).timeIntervalSinceReferenceDate
        try! context.save()
    }
    
    
    // l'utilisateur est en train d'écrire un caractère ou de supprimer un caractère
    // vérifier si on le laisse écrire et si on change de clavier
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        stringToEnter=string
       
        
        // on ne peut pas écrire plus de caractères qu'il y en a dans la bonne réponse.
        if textField.text?.count==correctText.count && !string.isEmpty{
        return false
        }
        
        // l'utilisateur est en train de supprimer un caractère : on change le clavier pour que l'utilisateur puisse entrer le chiffre si il se trouve désormais dans la position où il faut entrer un ton.
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
      
        // l'utilisateur n'est pas en train de supprimer, il est en train d'écrire.
     
        /* Il faut étudier le caractère qui suit celui qui est entré pour voir si il s'agit d'un chiffre ou d'un espace. L'index du caractère entré correspond au lowerbound du range modifié, et l'index du caractère suivant correspond au upperBound du range modifié*/
        
        guard let existingFollowingCharacterIndex=correctText.index(correctText.startIndex, offsetBy: range.location+1,limitedBy:correctText.index(before: correctText.endIndex))
            
            else{
                textField.keyboardType = .default
                textField.reloadInputViews()
                // on est dans la situation où l'utilisateur est en train d'écrire le dernier caractère du mot à étudier, donc le dernier ton
                
               // il ne faut pas étudier le prochain caractère car il n'y en a pas.
                
               
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
        
        // à défaut de régles particulières, autoriser l'écriture
        return true
    }
    
    func createNewQuestion(){
        // mise à jour interface
        skipButton.isEnabled=true
        wrongButton.isEnabled=true
        toggleOff()
         answerTF.isEnabled=true
        scoreBar.progress=Float(scoreTotalActuel)/Float(wordsNumberForCurrentLevel*10)
        print(Float(scoreTotalActuel)/Float(wordsNumberForCurrentLevel*10))
        
        // choix d'un nouveau mot
        // Vérifier si il y a des mot à réviser
        let currentDateAsNumber:Double=Date(timeIntervalSinceNow: 0).timeIntervalSinceReferenceDate
               let expiredWordsRequest=NSFetchRequest<Mot>(entityName: "Mot")
        
        // PREDICATES
      
            let restrictionPredicate=NSPredicate(format: "%K < %@", #keyPath(Mot.index), String(wordsNumberForCurrentLevel))
            let reviewPredicate=NSPredicate(format: "%K < %@", #keyPath(Mot.date), String(currentDateAsNumber))
            expiredWordsRequest.predicate=NSCompoundPredicate(andPredicateWithSubpredicates: [restrictionPredicate,reviewPredicate])
            
        
        
        
        
        let sorting=NSSortDescriptor(key: "date", ascending: true)
        expiredWordsRequest.sortDescriptors=[sorting]
        
        guard  let expiredWords=try? context.fetch(expiredWordsRequest) else {return}
        
            if expiredWords.count != 0{
                // si il y a un mot à réviser, on prend le plus ancien
            currentMot=expiredWords.first
            }
            
            else{
                
            // Il n'y a plus de mot à réviser
     
            // 1) il reste des mots jamais apparus
                
            let fetchNeverSeenWordRequest=NSFetchRequest<Mot>(entityName: "Mot")
              
                
                    let restrictionPredicate=NSPredicate(format: "%K < %@", #keyPath(Mot.index), String(wordsNumberForCurrentLevel))
                    let newPredicate=NSPredicate(format: "%K == %@", #keyPath(Mot.date), "1000000000")
                    fetchNeverSeenWordRequest.predicate=NSCompoundPredicate(andPredicateWithSubpredicates: [restrictionPredicate,newPredicate])
                
   
               

                                guard let neverSeenWords=try? context.fetch(fetchNeverSeenWordRequest)else{return}
              
                if neverSeenWords.count != 0{
                    currentMot=neverSeenWords[Int(arc4random_uniform(UInt32(neverSeenWords.count)))]
                
                }
            
                // il ne reste plus du tout de mots à réviser

            else {
                    skipButton.isHidden=true
            answerTF.text="Come back later!"
                    answerTF.isEnabled=false
            characterLabel.text=""
            infoButton.isHidden=true
                 return
                }
           
        
        }
        
        
        // mise à jour de l'interface
      
        characterLabel.text=""
        
        definitionTV.text=currentMot.definition
        correctText=currentMot.pinyin!
        if voiceEnabled{
        utterance=AVSpeechUtterance(string: currentMot.character)
            utterance.voice=self.voice
            
        }
        
        
        
    }
    
    override func viewDidLoad() {
        let textFieldAppearance = UITextField.appearance()
        textFieldAppearance.keyboardAppearance = .dark
        super.viewDidLoad()
        createNewQuestion()
       // answerTF.becomeFirstResponder()
        
        
        
        // Do any additional setup after loading the view.
    }
}
