//
//  ExampleCounterPresenter.swift
//  Counters
//
//  Created by Jhonatahan on 11/23/20.
//

import Foundation

protocol ExampleCounterPresenterProtocol{
    func loadData()
    func getCountSections()->Int
    func getSectionTitle(section:Int)->String
    func getNumferOfRowForSection(section:Int)->Int
    func getTitleExample(section:Int, row:Int)->String
    func routerToPrevius()
}

class ExampleCounterPresenter{
    
    
    typealias ExampleCounter = (title:String,examples:[String])
    var dataExamples = [ExampleCounter]()
    
    private weak var view: ExampleCounterControllerProtocol?
    private var router : ExampleCounterRouterProtocol!
    
    init(view: ExampleCounterControllerProtocol?, router : ExampleCounterRouterProtocol!) {
        self.view = view
        self.router = router
    }
}


extension ExampleCounterPresenter:ExampleCounterPresenterProtocol{
    func loadData(){
        let drinksExamples:ExampleCounter = ExampleCounter(title:"DRINKS",examples:["Cups of Coffe","Glasses of water","Frapuccino","Soda"])
        let foodExamples:ExampleCounter = ExampleCounter(title:"FOODS",examples:["Hot-dogs","Cupcakes eaten","Chicken fried","Sandwitch"])
        let miscExamples:ExampleCounter = ExampleCounter(title:"MISC",examples:["Times sneezed","Naps","day dreaming","Party day"])
        dataExamples.append(drinksExamples)
        dataExamples.append(foodExamples)
        dataExamples.append(miscExamples)
    }
    
    func getCountSections()->Int{
        return dataExamples.count
    }
    
    func getSectionTitle(section:Int)->String{
        return dataExamples[section].title
    }
    
    func getNumferOfRowForSection(section:Int)->Int{
        return dataExamples[section].examples.count
    }
    
    func getTitleExample(section:Int, row:Int)->String{
        return dataExamples[section].examples[row]
    }
    
    func routerToPrevius(){
        router.routerToPrevius()
    }
}
