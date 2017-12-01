//
//  SketchViewController.swift
//  Sketch
//
//  Created by Mohamed Salah on 12/1/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

class SketchViewController: UIViewController {

    // UI Controllers
    @IBOutlet weak var colorPicker: UIButton!
    @IBOutlet weak var brushSize: UIButton!
    @IBOutlet weak var pencil: UIButton!
    @IBOutlet weak var eraser: UIButton!
    @IBOutlet weak var undo: UIButton!
    @IBOutlet weak var redo: UIButton!
    
    var buttons:[UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        buttons = [colorPicker, brushSize, pencil, eraser, undo, redo]
        self.pencil.isSelected = true
    }

    func deselectAllButtonsExcept(_ button:UIButton) {
        for button in buttons {
            button.isSelected = false
        }
        
        button.isSelected = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UI Controllers callbacks
    
    @IBAction func colorPickerDidClicked(_ sender: UIButton) {
        deselectAllButtonsExcept(sender)
    }
    
    @IBAction func DidClicked(_ sender: UIButton) {
        deselectAllButtonsExcept(sender)
    }
    
    @IBAction func pencilDidClicked(_ sender: UIButton) {
        deselectAllButtonsExcept(sender)
    }
    
    @IBAction func eraserDidClicked(_ sender: UIButton) {
        deselectAllButtonsExcept(sender)
    }
    
    @IBAction func undoDidClicked(_ sender: UIButton) {
        deselectAllButtonsExcept(sender)
    }
    
    @IBAction func redoDidClicked(_ sender: UIButton) {
        deselectAllButtonsExcept(sender)
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
