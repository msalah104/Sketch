//
//  ViewController.swift
//  Sketch
//
//  Created by Mohamed Salah on 12/1/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // UI Controllers
    
    
    var colorPicker:ColorPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        colorPicker = ColorPicker.instanceFromNib()
        self.view.addSubview(colorPicker)
        
        colorPicker.center = self.view.center
        colorPicker.show()
        
        self.colorPicker.color.asObservable().subscribe(onNext: { (color) in
            print("Color Changed to : \(String(describing: color))")
        })
    }
    
    @IBAction func show(_ sender: UIButton) {
        self.colorPicker.show()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

