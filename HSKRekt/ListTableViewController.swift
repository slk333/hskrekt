import UIKit

class ListTableViewController: UITableViewController {
let listTitles=["Review Schedule","HSK 1","HSK 2","HSK 3","HSK 4","HSK 5"]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let characterVC=segue.destination as! CharacterTableViewController
        let cell=sender as! UITableViewCell
        let label=cell.viewWithTag(1)! as! UILabel
        characterVC.listeEnCours=label.text!
        if label.text! == "HSK 2"{characterVC.decalage=153}
         if label.text! == "HSK 3"{characterVC.decalage=153+150}
         if label.text! == "HSK 4"{characterVC.decalage=153+150+300}
         if label.text! == "HSK 5"{characterVC.decalage=153+150+300+600}
    }
    
   
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
 

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        let label=cell.viewWithTag(1)! as! UILabel
        label.text=listTitles[indexPath.row]
      
        return cell
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
