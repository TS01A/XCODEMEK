//
//  VideoViewController.swift
//  withyou
//
//  Created by Abdullah on 18/05/1446 AH.
//

import UIKit

class VideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func BtnVideo1(_ sender: Any) {
        if let url = URL(string: "https://www.youtube.com/watch?app=desktop&v=Fpzpm-XB0oE") {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
               } else {
                   print("نعتذر توجد مشكلة !")
               }
           }
   
    
    
    
    
    @IBAction func BtnVideo2(_ sender: Any) {
        if let url = URL(string: "https://youtu.be/sYp_nXzH9EY?si=b5N4e_mG5GjexmBP") {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
               } else {
                   print("نعتذر توجد مشكلة !")
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
