//
//  QuizPlaygroundVC.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 05/11/23.
//

import UIKit
import Combine

class QuizPlaygroundVC: BaseVC {

    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak private var closeBtn: UIButton!
    @IBOutlet weak private var continueBtn: UIButton!
    
    let viewmodel = QuizPlaygroundViewModel()
    var observers: [AnyCancellable] = []
    
    var isSeletedAnswer = false{
        didSet{
            if self.viewmodel.storeResult.count == self.viewmodel.dataList.count{
                continueBtn.setTitle("View Score", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let ds = data as? [GenerateListResponse] {
            viewmodel.dataList = ds
        }
        
        setupUI()
        
        closeBtn.addTapGesture {
            self.closeVC()
        }
    
    }
    
    func setupUI(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.reloadData()
        
        closeBtn.makeCircular()
        continueBtn.makeCircular()
    
    }
    
    @IBAction func continueBtnTap(_ sender: Any) {
        
        if !isSeletedAnswer{
            
            AppHelper.shared.showAlert(title: "Answer Required", message: "Please select any answer before continue...", vc: self)
            
        }else if viewmodel.storeResult.count < viewmodel.dataList.count{
            
            collectionView.scrollToItem(at: IndexPath(row: viewmodel.storeResult.count, section: 0), at: .left, animated: true)
            isSeletedAnswer = false
            
        }else{
            openVC(QuizResultVC.self, data: self.viewmodel.calculateScore())
        }
        
    }
    
}


extension QuizPlaygroundVC: UICollectionViewDelegate ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewmodel.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuizCollectionViewCell.reuseIdentifier, for: indexPath) as? QuizCollectionViewCell else { return QuizCollectionViewCell() }
        
        
        cell.selectedIndex = viewmodel.storeResult["\(indexPath.row)"]?.loaction ?? nil
        cell.setValues = viewmodel.dataList[indexPath.row]
        
        cell.action.sink { [weak self] result in
            self?.viewmodel.storeResult["\(indexPath.row)"] = result
            self?.isSeletedAnswer = true
        }.store(in: &observers)
        
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
