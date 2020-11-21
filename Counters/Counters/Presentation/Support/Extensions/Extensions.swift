//
//  Extensions.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import UIKit

enum FontSizeApp: CGFloat {
    case s17 = 17.0
    case s24 = 24.0
    case s33 = 33.0
}

extension UILabel{
    func setCustomFont(size: FontSizeApp, color: ColorsApp, customFont: FontsApp) {
        self.font = UIFont(name: customFont.getFontName(), size: size.rawValue)
        self.textColor = UIColor(named: color.rawValue)
    }
}



enum TypErrorCounter{
    case create
    case increment
    case delete
    
    func getTitleAlert()->String{
        switch self {
        case .create:
            return NSLocalizedString("createErrorAlertTitle", comment: "createErrorAlertTitle")
        case .increment:
            return NSLocalizedString("incrementErrorAlertTitle", comment: "incrementErrorAlertTitle")
        case .delete:
            return NSLocalizedString("deleteErrorAlertTitle", comment: "deleteErrorAlertTitle")
        }
    }
}

fileprivate var activityView : UIView?
extension UIViewController{
    
    func showActivity(){
        activityView = UIView(frame: self.view.bounds)
        guard let _ = activityView else{return}
        activityView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let atvIndicator = UIActivityIndicatorView(style: .large)
        atvIndicator.color = .white
        atvIndicator.center = activityView!.center
        atvIndicator.startAnimating()
        activityView?.addSubview(atvIndicator)
        self.view.addSubview(activityView!)
    }
    
    func hideActivity(){
        activityView?.removeFromSuperview()
        activityView = nil
    }
    
    func showCounterAlert(typeAlert: TypErrorCounter, action: (() -> Void)?){
        let message:String = NSLocalizedString("offLineMessage", comment: "offLineMessage")
        let dismissTtitle:String = NSLocalizedString("dismissTitle", comment: "dismissTitle")
        let alert = UIAlertController(title: typeAlert.getTitleAlert(), message: message, preferredStyle: .alert)
        
        switch typeAlert {
        case .increment:
            let retryTitle:String = NSLocalizedString("retry", comment: "retry")
            alert.addAction(UIAlertAction(title: dismissTtitle, style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: retryTitle, style: .default, handler: { [weak self](handler) in
                guard let _ = self else{return}
                guard let actionParam = action else{return}
                _ = actionParam
            }))
            break
        case .create,.delete:
            alert.addAction(UIAlertAction(title: dismissTtitle, style: .cancel, handler: nil))
            break
        }
        
        self.present(alert, animated: true)
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
}

extension UIColor{
    static var primaryBlackColorApp:UIColor? {return UIColor(named: ColorsApp.primaryBlackColorApp.rawValue)}
    static var primaryGraceColorApp:UIColor? {return UIColor(named: ColorsApp.primaryGraceColorApp.rawValue)}
    static var primaryOrangeColorApp:UIColor? {return UIColor(named: ColorsApp.primaryOrangeColorApp.rawValue)}
    static var primaryWhiteColorApp:UIColor? {return UIColor(named: ColorsApp.primaryWhiteColorApp.rawValue)}
    static var secundaryBlackColorApp:UIColor? {return UIColor(named: ColorsApp.secundaryBlackColorApp.rawValue)}
    static var secundaryGraceColorApp:UIColor? {return UIColor(named: ColorsApp.secundaryGraceColorApp.rawValue)}
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
