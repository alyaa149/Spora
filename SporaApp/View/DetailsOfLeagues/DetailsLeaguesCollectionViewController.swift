//
//  DetailsLeaguesCollectionViewController.swift
//  SporaApp
//
//  Created by macOS on 01/06/2025.
//

import UIKit
import Kingfisher
import Lottie

class DetailsLeaguesCollectionViewController: UICollectionViewController, LeagueDetailsViewProtocol, UICollectionViewDelegateFlowLayout {
    
    var lottieView: LottieAnimationView?
    var upcomingEvents: [Event] = []
    var latestEvents: [Event] = []
    var presenter: LeagueDetailsPresenter!
    var leagueId: Int!
    var sportName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let eventNib = UINib(nibName: "UpComingEventsCollectionViewCell", bundle: nil)
        collectionView.register(eventNib, forCellWithReuseIdentifier: "eventCell")
        
        let lottieNib = UINib(nibName: "LottieeCollectionViewCell", bundle: nil)
        collectionView.register(lottieNib, forCellWithReuseIdentifier: "lottieCell0")
        collectionView.register(lottieNib, forCellWithReuseIdentifier: "lottieCell1")
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        
        presenter = LeagueDetailsPresenter(view: self)
        presenter.loadLeagueDetails(sportName: sportName, leagueId: leagueId)
        let headerNib = UINib(nibName: "SectionHeaderView", bundle: nil)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "SectionHeaderView")

    }

    
    func displayUpcomingEvents(_ events: [Event]) {
        self.upcomingEvents = events
        collectionView.reloadSections(IndexSet(integer: 0))
        showLottieAnimationIfNeeded()
    }
    
    func displayLatestEvents(_ events: [Event]) {
        self.latestEvents = events
        collectionView.reloadSections(IndexSet(integer: 1))
        showLottieAnimationIfNeeded()
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            switch sectionIndex {
            case 0: return self.createHorizontalSection()
            case 1: return self.createVerticalSection()
            default: return nil
            }
        }
    }
    
    private func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(300),
            heightDimension: .absolute(200)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(250)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 16,
            bottom: 10,
            trailing: 16
        )
        let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(50)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createVerticalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(170))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        let headerSize = NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1.0),
              heightDimension: .absolute(50)
          )
          let header = NSCollectionLayoutBoundarySupplementaryItem(
              layoutSize: headerSize,
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top
          )
          section.boundarySupplementaryItems = [header]
        return section
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return upcomingEvents.isEmpty ? 1 : upcomingEvents.count
        case 1: return latestEvents.isEmpty ? 1 : latestEvents.count
        default: return 0
        }
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if upcomingEvents.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lottieCell0", for: indexPath) as! LottieeCollectionViewCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! UpComingEventsCollectionViewCell
                let event = upcomingEvents[indexPath.item]
                configure(cell: cell, with: event, section: 0)
                return cell
            }
        case 1:
            if latestEvents.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lottieCell1", for: indexPath) as! LottieeCollectionViewCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! UpComingEventsCollectionViewCell
                let event = latestEvents[indexPath.item]
                configure(cell: cell, with: event, section: 1)
                return cell
            }
        default:
            fatalError("Unexpected section")
        }
    }

    func configure(cell: UpComingEventsCollectionViewCell, with event: Event?, section: Int) {
        guard let event = event else {
            cell.team1name.text = ""
            cell.team2name.text = ""
            cell.score.text = ""
            cell.date.text = ""
            cell.time.text = ""
            cell.team1Img.image = nil
            cell.team2Img.image = nil
            cell.layer.borderColor = nil
            return
        }
        
        cell.team1name.text = event.event_home_team
        cell.team2name.text = event.event_away_team
        cell.score.text = event.event_final_result ?? ""
        cell.date.text = event.event_date
        cell.time.text = event.event_time
        
        if let team1Url = URL(string: event.home_team_logo ?? "") {
            cell.team1Img.kf.setImage(with: team1Url)
        }
        
        if let team2Url = URL(string: event.away_team_logo ?? "") {
            cell.team2Img.kf.setImage(with: team2Url)
        }
        
        cell.layer.borderColor = (section == 0 ? UIColor.systemOrange : UIColor.systemGreen).cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 12
    }
    
    func showLottieAnimationIfNeeded() {
        let isEmpty = upcomingEvents.isEmpty && latestEvents.isEmpty
        
        if isEmpty {
            if lottieView == nil {
                setupLottieAnimation()
            }
         
            collectionView.backgroundView?.bringSubviewToFront(lottieView!)
        } else {
            removeLottieAnimation()
        }
    }

    private func setupLottieAnimation() {
        lottieView = LottieAnimationView(name: "splash")
        lottieView?.contentMode = .scaleAspectFit
        lottieView?.loopMode = .loop
        
        let containerView = UIView(frame: collectionView.bounds)
        containerView.backgroundColor = .clear
        
        lottieView?.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(lottieView!)
        
        NSLayoutConstraint.activate([
            lottieView!.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            lottieView!.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            lottieView!.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            lottieView!.heightAnchor.constraint(equalTo: lottieView!.widthAnchor)
        ])
        
        collectionView.backgroundView = containerView
        lottieView?.play()
    }

    private func removeLottieAnimation() {
        lottieView?.stop()
        lottieView?.removeFromSuperview()
        lottieView = nil
        collectionView.backgroundView = nil
    }

override func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath
) -> UICollectionReusableView {
    guard kind == UICollectionView.elementKindSectionHeader,
          let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "SectionHeaderView",
            for: indexPath
          ) as? SectionHeaderView else {
        return UICollectionReusableView()
    }
    
    switch indexPath.section {
    case 0:
        header.titleLabel.text = "Upcoming Events"
        header.titleLabel.textColor = .systemOrange
    case 1:
        header.titleLabel.text = "Latest Events"
        header.titleLabel.textColor = .systemGreen
    default:
        header.titleLabel.text = "Teams"
    }
    
    return header
}
}
