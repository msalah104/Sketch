//
//  SketchPresenter.swift
//  Sketch
//
//  Created by Mohamed Salah on 12/1/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit
import RxSwift

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
    
    // Attach the drawing View
    func addSketchView(_ sketch:UIView)
    
    // Undo & Redo
    func undoUnavilable()
    func redoUnavilable()
    func undoAvilable()
    func redoAvilable()
    
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
    func selectBackgroundPic()
    func saveDrawing()
    
}

class SketchPresenter: NSObject {

    
    
    func setCurrentToolPencil() {
        
    }
    
    func setCurrentToolEraser() {
        
    }
    
    func undoAction(){
        
    }
    
    func redoAction(){
        
    }
    
    func showColorPicker(){
        
    }
    
    func showSizeSlider(){
        
    }
    
    func resetAllDrawings(){
        
    }
    
    func selectBackgroundPic(){
        
    }
    
    func saveDrawing(){
        
    }
}
