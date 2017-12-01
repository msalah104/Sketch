//
//  Presenter.swift
//  The Movies DB
//
//  Created by Mohamed Salah on 11/4/17.
//  Copyright © 2017 Mohamed Salah. All rights reserved.
//

import UIKit


protocol ViewDelegate: NSObjectProtocol {
    
}

protocol Presenter : NSObjectProtocol {

    func attachView(_ viewDelegate:ViewDelegate)
    
    func detachView(_ viewDelegate:ViewDelegate)
}

