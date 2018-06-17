
//
//  CircleButton.swift
//  Scriber
//
//  Created by Mehmet Anıl Kul on 23.09.2017.
//  Copyright © 2017 Mehmet Anıl Kul. All rights reserved.
//

import UIKit

@IBDesignable //Degisiklikleri editorde izlemek icin gerekli
class CircleButton: UIButton {

    // Degisiklikleri storyboradda izlemek icin @IBInspectable kullanalim. Bu class'i belirledigimiz buton ile iliskilendirince attribute inspector'de "Corner Radius" isimli bir secenek belirecek. Default olarak 30 verdik. Ancak Editorde de ayni degeri vermeliyiz yoksa simulatorde gozukmez.
    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        didSet {
            setupView()
        }
    }
    
    //Bu gomulu fonskiyon ile degisiklieri build etmeden editor ustunde gorebiliriz
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    //layer CALayer classina ait, UIView icerisinde bulunan bir degisken. Layer'dan sonra gelen cornerRadius, dolayisi ile CALayer classinda ait
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
}
