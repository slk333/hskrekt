import UIKit
import CoreData
import AVFoundation
class AutoEvalViewController: UIViewController {
    
    // Variables et constantes
    let context=(UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var currentMot:Mot!
var confirmationMode=false
    
    var showTimer=Timer()
    
    // let speechSynthesizer = AVSpeechSynthesizer()
    
    // Outlets
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var definitionLabel:UITextView!
    @IBOutlet weak var pinyinLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
 //  @IBOutlet weak var scoreLabel: UILabel!
    
    
    // IBActions
    

    
    @IBAction func confusedAction(_ sender: UIButton){
        guard !confirmationMode else {confirm()
            return}
        confirmationMode=true
        currentMot.date=Date(timeIntervalSinceNow: 0).timeIntervalSinceReferenceDate
        try! context.save()
        
        
    changeAnswerButtonToVoidAndDisabled(true)
        b2.setTitle("→", for: .normal)
      b2.isEnabled=true
        
    }
    
    
    @IBAction func correctAction(_ sender: UIButton) {
        guard !confirmationMode else {confirm()
            return}
        confirmationMode=true
        
        
            // Mise à jour du score
        if currentMot.score<10{currentMot.score+=1}
     //   scoreLabel.text=String(currentMot.score)
   scoreButtonsAction()
        
        // passe en mode "confirmer pour question suivante"
        changeAnswerButtonToVoidAndDisabled(true)
        b3.setTitle("→", for: .normal)
        b3.isEnabled=true
        
        
        
        
        
        
        
    }
    

    
    @IBAction func wrongAction(_ sender: UIButton) {
        guard !confirmationMode else {confirm()
            return}
        confirmationMode=true
        
    
            // Mise à jour du score
        if currentMot.score>3{currentMot.score=3}
        else {
        if currentMot.score>1{currentMot.score-=2}
        else{ if currentMot.score==1{currentMot.score=0}}}
            scoreButtonsAction()
        
        changeAnswerButtonToVoidAndDisabled(true)
        b1.setTitle("→", for: .normal)
        b1.isEnabled=true
        
        
        
        
        
    }
    
    // Fonctions
    
    
    
    func confirm(){
        toggleOff()
        createNewQuestion()
        confirmationMode=false
    }
    
    // Fin du click d'un bouton (enregistrement du score et effacement des boutons de score)
    func scoreButtonsAction(){
     //   scoreLabel.text=String(currentMot.score)
      //  scoreLabel.isHidden=false
        updateExpirationDateAndSave()
        
       
    }
    
    
    // Mettre à jour la date d'expiration
    
   func updateExpirationDateAndSave(){
    let tempsÀajouter=100*pow(3, Double(currentMot.score))
    currentMot.date=Date(timeIntervalSinceNow: tempsÀajouter).timeIntervalSinceReferenceDate
    try! context.save()
    }
    
    
    // Enlever l'interface de réponse
    func toggleOff(){
    
        b1.setTitle("", for: .normal)
        b2.setTitle("", for: .normal)
        b3.setTitle("", for: .normal)
        definitionLabel.text=""
        pinyinLabel.text=""
    }
    
    
    // Afficher l'interface de réponse
    func toggleOn(){
        // affiche l'interface de réponse
        definitionLabel.text=currentMot.definition
        pinyinLabel.text=currentMot.pinyin
        changeAnswerButtonToVoidAndDisabled(false)
        
       /* let utterance=AVSpeechUtterance(string: currentMot.character)
        utterance.voice=AVSpeechSynthesisVoice.init(language: "zh-CN")
       speechSynthesizer.speak(utterance) */
        // prévoit  la nouvelle question
       
        
    }
    
    // Déclenche une nouvelle question si tous les boutons  sont relâchés
    func prepareForNewQuestion(){
        guard (!b1.isTouchInside && !b2.isTouchInside && !b3.isTouchInside) else{
         
            return}
        createNewQuestion()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        
    }
    
    func changeAnswerButtonToVoidAndDisabled(_ yes:Bool){
        if yes{
            b1.setTitle("", for: .normal)
            b2.setTitle("", for: .normal)
            b3.setTitle("", for: .normal)
            b1.isEnabled=false
            b2.isEnabled=false
            b3.isEnabled=false
        }
        else{
            b1.setTitle("✗", for: .normal)
            b2.setTitle("≋", for: .normal)
            b3.setTitle("✓", for: .normal)
            b1.isEnabled=true
            b2.isEnabled=true
            b3.isEnabled=true
        
        }
    }
    
    // NOUVELLE QUESTION
    func createNewQuestion(){

        // cacher definition et pinyin et les boutons de réponses
        toggleOff()
        
        // scoreLabel.isHidden=true
        
        // choix d'un nouveau mot
        
        // trouver les mots expirés
        
        let dateOfNow:Double=Date(timeIntervalSinceNow: 0).timeIntervalSinceReferenceDate
        
        let expiredWordsRequest=NSFetchRequest<Mot>(entityName: "Mot")
        expiredWordsRequest.predicate=NSPredicate(format: "%K < %@", #keyPath(Mot.date), String(dateOfNow))
        
        guard  let expiredWords=try? context.fetch(expiredWordsRequest) else{return}
        showTimer=Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: {_ in self.toggleOn()})
       
        
        
        
        
        let rand=Int(arc4random_uniform(UInt32(expiredWords.count)))
   //  print(expiredWords.count)
        currentMot=expiredWords[rand]
        
        // mise à jour de l'interface
        // scoreLabel.text=String(currentMot.score)
        characterLabel.text=currentMot.character
        
        // préparation du dévoilement du pinyin et de la définition dans 3 secondes
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="infoAboutWord"{
            showTimer.invalidate()
            let destination=segue.destination as! DetailViewController
            destination.mot=currentMot}
        
          }
   
    
    
    // Configuration initiale
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        createNewQuestion()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        UIView.setAnimationsEnabled(false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        UIView.setAnimationsEnabled(true)
    }






}

