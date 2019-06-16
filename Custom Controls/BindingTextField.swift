//
//  BindingTextField.swift
//  Weather
//
//  Created by 민송경 on 16/06/2019.
//  Copyright © 2019 민송경. All rights reserved.
//

import Foundation
import UIKit

//creating binding text
class BindingTextField: UITextField {
    //pass a callback
    var textChangeClosure: (String) -> () = { _ in }
    
    //need to tell the text box whenever typing started
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    //bind function that going to set to closure
    //escaping -> pass in string back to the caller
    func bind(callback: @escaping (String) -> ()) {
        self.textChangeClosure = callback
        //going to set the callback
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    private func commonInit() {
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if let text = textField.text {
            self.textChangeClosure(text)
        }
    }
}
