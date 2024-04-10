//
//  TopDestinationsTVCell.swift
//  Safariyati
//
//  Created by FCI on 06/04/24.
//

import UIKit

class TopDestinationsTVCell: TableViewCell {

    @IBOutlet weak var topcitycv: UICollectionView!
    
    
    var currentPage: Int = 0
    var timer: Timer?
    let pageControl = CustomPageControl()
    var customPageControl: CustomPageControl?// Define UIPageControl as a property
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        topcitycv.restore()
        
    }
    
    
    func setupUI(){
        setupCV()
    }
    
}


extension TopDestinationsTVCell:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func setupCV() {
        let nib = UINib(nibName: "BestFlightCVCell", bundle: nil)
        topcitycv.register(nib, forCellWithReuseIdentifier: "cell")
        topcitycv.delegate = self
        topcitycv.dataSource = self
        let layout = UICollectionViewFlowLayout()
        
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 158, height: 180)
        
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        topcitycv.collectionViewLayout = layout
        topcitycv.backgroundColor = .clear
        topcitycv.showsHorizontalScrollIndicator = false
        topcitycv.bounces = false
        
       // addPageControl()
    }
    
    
    func addPageControl() {
        let customPageControl = CustomPageControl()
        customPageControl.activeImage = UIImage(named: "dot1") // Provide your active dot image
        customPageControl.inactiveImage = UIImage(named: "dot2") // Provide your inactive dot image
        
        customPageControl.numberOfPages = 10 // Update with your actual number of items
        customPageControl.currentPage = 0
        customPageControl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(customPageControl)
        
        NSLayoutConstraint.activate([
            customPageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            customPageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
        
        // Assign customPageControl to the property
        self.customPageControl = customPageControl
        
        // Start auto-scrolling timer
       // startTimer()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BestFlightCVCell {
            
            cell.titlelbl.text = "Dubai"
            
            commonCell = cell
        }
        return commonCell
    }
    
    
}



//MARK: - startTimer
extension TopDestinationsTVCell {
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToNextPage() {
        currentPage += 1
        if currentPage == 10 { // Update with your actual number of items
            currentPage = 0
        }
        let indexPath = IndexPath(item: currentPage, section: 0)
        topcitycv.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        // Use customPageControl instead of pageControl
        customPageControl?.currentPage = currentPage // Update page control's current page
    }
    
    
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // Invalidate timer when user starts dragging manually
        timer?.invalidate()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Restart auto-scrolling timer when user stops dragging
       // startTimer()
    }
}


