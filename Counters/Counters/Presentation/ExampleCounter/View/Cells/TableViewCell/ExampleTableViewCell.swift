//
//  ExampleTableViewCell.swift
//  Counters
//
//  Created by Jhonatahan on 11/23/20.
//

import UIKit

class ExampleTableViewCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: ExampleCounterPresenterProtocol?
    
    static let identifier = "exampleTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "ExampleTableViewCell", bundle: nil)
    }
    
    var sectionCell:Int=0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(ExampleCollectionViewCell.nib(), forCellWithReuseIdentifier: ExampleCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        setupViewCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupViewCell(){
        self.backgroundColor = .clear
        collectionView.backgroundColor = .clear
    }
    
}


extension ExampleTableViewCell{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.getNumferOfRowForSection(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExampleCollectionViewCell.identifier, for: indexPath) as! ExampleCollectionViewCell
        cell.title = presenter?.getTitleExample(section: self.sectionCell, row: indexPath.row)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let parentView = (self.parentViewController as? ExampleCounterController) else{return}
        parentView.delegate?.fillCounterField(title: presenter?.getTitleExample(section: self.sectionCell, row: indexPath.row) ?? "")
        parentView.presenter.routerToPrevius()
    }
}
