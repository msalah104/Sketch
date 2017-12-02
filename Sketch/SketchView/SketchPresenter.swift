//
//  SketchPresenter.swift
//  Sketch
//
//  Created by Mohamed Salah on 12/1/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit
import Photos
//import RxSwift
//import ATSketch

enum ViewStatus {
    case Drawing
    case NotDrawing
    case Eraseing
    case ChoosingColor
    case ChoosingBrushSize
}

protocol CustomView {
    func show()
    func Dismiss()
}

protocol SketchViewDelegate: ViewDelegate {
    
    func frame() -> CGRect
    func backToPencil()
    func clearBackground()
    
    // Attach the drawing View
    func addSketchView(_ sketch:UIView)
    
    // Undo & Redo
    func undoAvilable(_ isAvailable:Bool)
    func redoAvilable(_ isAvailable:Bool)
    
    // Attach View (colorPicker or brushSize)
    func attachCustomView(_ customView:CustomView)
    func showCustomView(_ customView:CustomView)
    func dismissCustomView(_ customView:CustomView)
}

protocol SketchPersenterActions: Presenter {
    
    func setCurrentToolPencil()
    func setCurrentToolEraser()
    func undoAction()
    func redoAction()
    func showColorPicker()
    func showSizeSlider()
    func resetAllDrawings()
    func SavePicture(_ backgroundImage:UIImageView)
    
}

class SketchPresenter: NSObject, SketchPersenterActions {

    var sketchView: SwiftyDrawView!
    var sketchViewDelegate:SketchViewDelegate!
    var colorPicker = ColorPicker.instanceFromNib()
    var lineSizePicker = LineSizePicker.instanceFromNib()
    //MARK:- Presenter Actions
    
    func attachView(_ viewDelegate:ViewDelegate){
        self.sketchViewDelegate = viewDelegate as! SketchViewDelegate
        
        //Configurations
        self.colorPicker.delegate = self
        self.lineSizePicker.delegate = self
        self.sketchView = SwiftyDrawView.init(frame: self.sketchViewDelegate.frame())
        self.sketchView.delegate = self
//        self.sketchView.currentLineWidth = CGFloat(5.0)
        self.sketchView.currentTool = .pencil
        self.sketchViewDelegate.undoAvilable(self.sketchView.canUndo)
        self.sketchViewDelegate.redoAvilable(self.sketchView.canRedo)
        
        // Attach Views
        sketchViewDelegate.attachCustomView(colorPicker)
        sketchViewDelegate.attachCustomView(lineSizePicker)
        sketchViewDelegate.addSketchView(sketchView)
    }
    
    func detachView(_ viewDelegate:ViewDelegate){
        self.sketchViewDelegate = nil
    }
    
    func setCurrentToolPencil() {
        self.sketchView.currentTool = .pencil
    }
    
    func setCurrentToolEraser() {
        self.sketchView.currentTool = .eraser
    }
    
    func undoAction(){
        self.sketchView.undo()
    }
    
    func redoAction(){
        self.sketchView.redo()
    }
    
    func showColorPicker(){
        sketchViewDelegate.showCustomView(colorPicker)
    }
    
    func showSizeSlider(){
        sketchViewDelegate.showCustomView(lineSizePicker)
    }
    
    func resetAllDrawings(){
        self.sketchView.clearCanvas()
        self.sketchViewDelegate.clearBackground()
    }
    
    func SavePicture(_ backgroundImage:UIImageView){
       let sketch = sketchView.sketchImage.image
        var result:UIImage = sketch!
        
        if backgroundImage.image != nil {
            // Merge tempImageView into mainImageView
            UIGraphicsBeginImageContext(backgroundImage.frame.size)
            backgroundImage.image?.draw(in: CGRect(x: 0, y: 0, width: sketchView.frame.size.width, height: sketchView.frame.size.height), blendMode: .normal, alpha: 1.0)
            sketch?.draw(in: CGRect(x: 0, y: 0, width: sketchView.frame.size.width, height: sketchView.frame.size.height), blendMode: .normal, alpha: 1.0)
            result = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        } else {
            sketchView.backgroundColor = UIColor.white
            result = sketchView.sketchImage.image!
        }
        
        
        
        let imageData = UIImageJPEGRepresentation(result, 0.6)
        let compressedJPGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, self, #selector(SketchPresenter.image(_:didFinishSavingWithError:contextInfo:)), nil)
        sketchView.backgroundColor = UIColor.clear
        
        
        
    }
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        
        var title = "Save Image"
        var message = "Image Saved Successfully"
        
        if error != nil  {
            title = "Error"
            message = (error?.description)!
        }
        //Image saved successfully
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        (sketchViewDelegate as! UIViewController).present(alert, animated: true, completion: nil)
    }
    
}

extension SketchPresenter : ColorPickerDelegate {
    func colorDidChange (_ color:UIColor) {
        self.sketchView.lineColor = color
    }
    
    func onDismiss(){
        sketchViewDelegate.backToPencil()
        self.sketchView.currentTool = .pencil
    }
}

extension SketchPresenter : LinePickerDelegate {
    func lineSizeDidChange (_ size:Double) {
        self.sketchView.lineWidth = CGFloat(size)
        sketchViewDelegate.backToPencil()
        self.sketchView.currentTool = .pencil
    }
    
}

extension SketchPresenter : SwiftyDrawViewDelegate {
    
    func SwiftyDrawDidBeginDrawing(view: SwiftyDrawView) {
        //optional
    }
    
    func SwiftyDrawIsDrawing(view: SwiftyDrawView) {
        //optional
    }
    
    func SwiftyDrawDidFinishDrawing(view: SwiftyDrawView) {
        //optional
    }
    
    func SwiftyDrawDidCancelDrawing(view: SwiftyDrawView) {
        //optional
    }
    
    public func sketchViewUpdatedUndoRedoState(_ sketchView: SwiftyDrawView) {
        self.sketchViewDelegate.undoAvilable(self.sketchView.canUndo)
        self.sketchViewDelegate.redoAvilable(self.sketchView.canRedo)
    }
    
    /*
    public func sketchView(_ sketchView: ATSketchKit.ATSketchView, shouldAccepterRecognizedPathWithScore score: CGFloat) -> Bool{
        NSLog("Score: \(score)")
        if score >= 60 {
            NSLog("ACCEPTED")
            return true
        }
        NSLog("REJECTED")
        return false
    }
    
    public func sketchView(_ sketchView: ATSketchKit.ATSketchView, didRecognizePathWithName name: String){
    }
    
    public func sketchViewOverridingRecognizedPathDrawing(_ sketchView: ATSketchKit.ATSketchView) -> UIBezierPath? {
        return nil
    }
    
    public func sketchViewUpdatedUndoRedoState(_ sketchView: ATSketchKit.ATSketchView) {
        self.sketchViewDelegate.undoAvilable(self.sketchView.canUndo)
        self.sketchViewDelegate.redoAvilable(self.sketchView.canRedo)
    } */
    
    
}

extension UIImage {
    convenience init(view: UIView) {
        
        let capturedImage:UIImage!
        if #available(iOS 10.0, *) {
            
            // for Xcode 9/Swift 3.2/Swift 4 -Paul Hudson's code
            let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
            capturedImage = renderer.image {
                (ctx) in
                view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            }
        } else {
            
            // for Xcode 8/Swift 3
            UIGraphicsBeginImageContextWithOptions((view.bounds.size), view.isOpaque, 0.0)
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
            capturedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
        if let cgImage = capturedImage.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init()
        }
        
        
    }
}
