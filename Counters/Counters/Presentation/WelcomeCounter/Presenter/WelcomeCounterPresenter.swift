//
//  WelcomeCounterPresenter.swift
//  Counters
//
//  Created by Jhonatahan on 11/19/20.
//

import Foundation

protocol WelcomeCounterPresenterProtocol{
    func goToHome()
    func loadData()
    func getItemData(row:Int)->WelcomeDataModel?
    func getNumberOfRow()->Int
}

class WelcomeCounterPresenter{
    private weak var view: WelcomeCounterControllerProtocol?
    private var router: WelcomeCounterRouterProtocol!
    private var welcomeData = [WelcomeDataModel]()
    init(view: WelcomeCounterControllerProtocol, router: WelcomeCounterRouterProtocol) {
        self.view = view
        self.router = router
    }
}

extension WelcomeCounterPresenter: WelcomeCounterPresenterProtocol{
    func getNumberOfRow() -> Int {
        return welcomeData.count
    }
    
    func goToHome() {
        router.routeToHome()
    }
    
    func loadData(){
        let item1 = WelcomeDataModel(iconContainer: "iconRedRectangle", iconInclude: "iconNumber", title: "WelcomItemTitle1".localized, description: "WelcomItemDescription1".localized)
        let item2 = WelcomeDataModel(iconContainer: "iconYellowRectangle", iconInclude: "iconPersons", title: "WelcomItemTitle2".localized, description: "WelcomItemDescription2".localized)
        let item3 = WelcomeDataModel(iconContainer: "iconGreenRectangle", iconInclude: "iconIdea", title: "WelcomItemTitle3".localized, description: "WelcomItemDescription3".localized)
        welcomeData.append(item1)
        welcomeData.append(item2)
        welcomeData.append(item3)
//        self.view?.reloadData()
    }
    
    func getItemData(row:Int)->WelcomeDataModel?{
        guard welcomeData.count > 0 else{return nil}
        return welcomeData[row]
    }
}
