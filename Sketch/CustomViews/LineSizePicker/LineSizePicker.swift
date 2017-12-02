//
//  LineSizePicker.swift
//  Sketch
//
//  Created by Mohamed Salah on 12/2/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit

protocol LinePickerDelegate {
    func lineSizeDidChange (_ size:Double)
    func onDismiss()
}

class LineSizePicker: UIView, CustomView {

    let CONTROLS_AREA = CGFloat(70.0)
    
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var done: UIButton!
    
    var delegate:LinePickerDelegate?
    var currentValue = Int(5)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    class func instanceFromNib() -> LineSizePicker {
        let view = UINib(nibName: "LineSizePicker", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LineSizePicker
        
        return view
    }
    
    func getCurrentView() -> UIViewController {
        
        let view = appDelegate.window?.rootViewController
        var viewController:UIViewController?
        
        if (view?.isMember(of: UINavigationController.self))! {
            let navigationController = view as! UINavigationController
            viewController = navigationController.viewControllers[0]
        } else {
            viewController = view
        }
        
        return viewController!
    }
    
    func show() {
        let view = getCurrentView()
        self.center = view.view.center
        var frame = self.frame
        frame.size.width = view.view.frame.size.width - 30
        frame.origin.y = (view.view.frame.size.height)
        self.frame = frame
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            var frame = self.frame
            frame.origin.y = (view.view.frame.size.height) - (self.CONTROLS_AREA + frame.size.height)
            self.frame = frame
            
        }, completion: nil)
    }
    
    func Dismiss() {
        let view = getCurrentView()
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            var frame = self.frame
            frame.origin.y = (view.view.frame.size.height)
            self.frame = frame
        }) { (done) in
            
        }
        
        delegate?.onDismiss()
    }
    

    @IBAction func onDoneClicked(_ sender: UIButton) {
        currentValue = Int(sizeSlider.value)
        delegate?.lineSizeDidChange(Double(currentValue))
        
        Dismiss()
    }
    
    @IBAction func onLineSizeValueChanged(_ sender: UISlider) {
        value.text = "\(Int(sizeSlider.value))"
    }
    
    
}
