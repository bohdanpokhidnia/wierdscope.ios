//
//  String.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import UIKit

extension String {
    var localize: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func toImage(size: CGSize) -> UIImage? {
        let nsString = (self as NSString)
        let fontSize = (size.width + size.height) / 2
        let stringAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        let imageSize = nsString.size(withAttributes: stringAttributes)
        
        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        UIColor.clear.set()
        UIRectFill(CGRect(origin: CGPoint(), size: imageSize))
        nsString.draw(at: CGPoint.zero, withAttributes: stringAttributes)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
