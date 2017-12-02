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
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var sketchPersenterActions:SketchPersenterActions = SketchPresenter() as! SketchPersenterActions
    var buttons:[UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        buttons = [colorPicker, brushSize, pencil, eraser]
        self.pencil.isSelected = true
        self.sketchPersenterActions.attachView(self)
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
        sketchPersenterActions.showColorPicker()
    }
    
    @IBAction func DidClicked(_ sender: UIButton) {
        deselectAllButtonsExcept(sender)
        sketchPersenterActions.showSizeSlider()
    }
    
    @IBAction func pencilDidClicked(_ sender: UIButton) {
        deselectAllButtonsExcept(sender)
        sketchPersenterActions.setCurrentToolPencil()
    }
    
    @IBAction func eraserDidClicked(_ sender: UIButton) {
        deselectAllButtonsExcept(sender)
        sketchPersenterActions.setCurrentToolEraser()
    }
    
    @IBAction func undoDidClicked(_ sender: UIButton) {
        sketchPersenterActions.undoAction()
    }
    
    @IBAction func redoDidClicked(_ sender: UIButton) {
        sketchPersenterActions.redoAction()
    }
    
    @IBAction func loadImageDidClicked(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
//            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func resetImageDidClicked(_ sender: UIButton) {
        sketchPersenterActions.resetAllDrawings()
    }
    
    @IBAction func saveImageDidClicked(_ sender: UIButton) {
        sketchPersenterActions.SavePicture(self.backgroundImage)
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

   
    
    deinit {
        self.sketchPersenterActions.detachView(self)
    }
}

extension SketchViewController: SketchViewDelegate {
    
    func frame() -> CGRect{
        return self.containerView.bounds
    }
    
    func backToPencil() {
        deselectAllButtonsExcept(pencil)
    }
    
    // Attach the drawing View
    func addSketchView(_ sketch:UIView) {
        sketch.backgroundColor = UIColor.clear
        self.containerView.addSubview(sketch)
    }
    
    // Undo & Redo
    func undoAvilable(_ isAvailable:Bool) {
        undo.isEnabled = isAvailable
        undo.isSelected = isAvailable
    }
    func redoAvilable(_ isAvailable:Bool){
        redo.isEnabled = isAvailable
        redo.isSelected = isAvailable
    }
    
    // Attach View (colorPicker or brushSize)
    func attachCustomView(_ customView:CustomView){
        
        self.view.addSubview(customView as! UIView)
        (customView as! UIView).isHidden = true
        customView.Dismiss()
    }
    
    func showCustomView(_ customView:CustomView){
        (customView as! UIView).isHidden = false
        customView.show()
    }
    
    func dismissCustomView(_ customView:CustomView) {
        customView.Dismiss()
    }
    
    func clearBackground() {
        self.backgroundImage.image = nil
    }
}

extension SketchViewController :UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] {
            backgroundImage.image = (image as! UIImage)
        }
        dismiss(animated:true, completion: nil)
    }
    
    
     public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
}
