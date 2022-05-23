//
//  ViewController1.swift
//  Proje
//
//  Created by Rabia on 24.05.2022.
//

import UIKit

class ViewController1: UIViewController {

    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeToGreen(_ sender: Any) {
        UIView.animate(withDuration: 1){
            self.view.backgroundColor = UIColor.green
        }
    }
    
    @IBAction func changeToRed(_ sender: Any) {
        UIView.animate(withDuration: 1){
            self.view.backgroundColor = UIColor.red
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
