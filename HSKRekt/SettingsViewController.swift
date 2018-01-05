
import UIKit

extension UIFont {
    
    func withTraits(traits:UIFontDescriptorSymbolicTraits...) -> UIFont {
        let descriptor = self.fontDescriptor.withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits))
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    
    func boldItalic() -> UIFont {
        return withTraits(traits: .traitBold, .traitItalic)
    }
    
}



class SettingsViewController: UIViewController {

    @IBOutlet weak var hskLevelSegmentedControl:UISegmentedControl!
    @IBOutlet weak var voiceEnabledSwitch:UISwitch!
    
    let defaults = UserDefaults.standard
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        hskLevel=hskLevelSegmentedControl.selectedSegmentIndex+1
        voiceEnabled=voiceEnabledSwitch.isOn
         defaults.set(voiceEnabled, forKey: "voiceEnabled")
        defaults.set(hskLevel, forKey: "hskLevel")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // custom le segmentedControl
     let font=UIFont(name: "PingFang SC" , size: 19)?.bold()
        hskLevelSegmentedControl.setTitleTextAttributes([NSAttributedStringKey.font:font!] , for: .normal)
      

       hskLevelSegmentedControl.selectedSegmentIndex=hskLevel-1
        voiceEnabledSwitch.isOn=voiceEnabled
        
        

        // Do any additional setup after loading the view.
    }

   
}
