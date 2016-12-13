
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
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        hskLevel=hskLevelSegmentedControl.selectedSegmentIndex+1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // custom le segmentedControl
     let font=UIFont(name: "PingFang SC" , size: 19)?.bold()
        hskLevelSegmentedControl.setTitleTextAttributes([NSFontAttributeName:font!] , for: .normal)
        hskLevelSegmentedControl.selectedSegmentIndex=hskLevel-1
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
