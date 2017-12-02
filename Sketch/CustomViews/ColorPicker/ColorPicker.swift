//
//  ColorPicker.swift
//  Sketch
//
//  Created by Mohamed Salah on 12/1/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit
//import RxSwift

protocol ColorPickerDelegate {
    func colorDidChange (_ color:UIColor)
    func onDismiss()
}



class ColorPicker: UIView, CustomView {

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var colorView: UIImageView!
    
    var delegate:ColorPickerDelegate?
    var red:CGFloat = 255.0
    var green:CGFloat = 255.0
    var blue:CGFloat = 255.0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    var color: Variable<UIColor> = Variable(UIColor.white)

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    class func instanceFromNib() -> ColorPicker {
        let view = UINib(nibName: "ColorPicker", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ColorPicker
        
        view.layer.cornerRadius = 8.0
        view.clipsToBounds = true
        view.colorView.layer.cornerRadius = 8.0
        view.colorView.clipsToBounds = true
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 0.5
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
        frame.origin.x = -(view.view.frame.size.width)
        self.frame = frame
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            self.center = view.view.center
        }, completion: nil)
    }
    
    func Dismiss() {
        let view = getCurrentView()
        self.center = view.view.center
        var frame = self.frame
        
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
            frame.size.width = view.view.frame.size.width - 30
            frame.origin.x = (view.view.frame.size.width)
            self.frame = frame
        }) { (done) in
            if done {
                var frame = self.frame
                frame.size.width = view.view.frame.size.width - 30
                frame.origin.x = -(view.view.frame.size.width)
                self.frame = frame
            }
        }
        
        delegate?.onDismiss()
    }
    
    
    @IBAction func onCancelClicked(_ sender: UIButton) {
        Dismiss()
    }
    
    @IBAction func onDoneClicked(_ sender: UIButton) {
        Dismiss()
        delegate?.colorDidChange(self.colorView.backgroundColor!)
//        color.value = self.colorView.backgroundColor!
    }
    
    @IBAction func colorChange(_ sender: UISlider) {
        
        if sender.tag == 1 {
            red = CGFloat(sender.value)
        } else if sender.tag == 2 {
            green = CGFloat(sender.value)
        } else if sender.tag == 3 {
            blue = CGFloat(sender.value)
        }
        
        self.colorView.backgroundColor = UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    
    
    
}
