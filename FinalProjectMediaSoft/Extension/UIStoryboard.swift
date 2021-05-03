//
//  UIStoryboard.swift
//  FinalProjectMediaSoft
//
//  Created by Alexander Nazarov on 03.05.2021.
//

import UIKit

extension UIStoryboard {
    
    static func viewController<T: UIViewController>(from storyboardName: String, type: T.Type) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
}
