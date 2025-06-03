//
//  LocalDataSource.swift
//  SporaApp
//
//  Created by macOS on 03/06/2025.
//

import Foundation
import CoreData
import UIKit
class FavoriteLeaguesLocalDataSource {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext) {
        self.context = context
        print("Initialized FavoriteLeaguesLocalDataSource with context: \(context)")
    }

    func fetchFavoriteLeagues() -> [LeagueModel] {
        let fetchRequest: NSFetchRequest<LeagueEntity> = LeagueEntity.fetchRequest()

        do {
            let entities = try context.fetch(fetchRequest)
            print("Fetched \(entities.count) leagues from CoreData")
            return entities.map { entity in
                let model = LeagueModel(
                    leagueName: entity.leagueName ?? "",
                    leagueLogo: entity.leagueLogo,
                    league_key: Int(entity.league_key),
                    sportName: entity.sportName ?? ""
                )
                print("Mapped entity to model: \(model)")
                return model
            }
        } catch {
            print("❌ Failed to fetch from CoreData: \(error)")
            return []
        }
    }

    func saveLeague(_ league: LeagueModel) {
        let entity = LeagueEntity(context: context)
        entity.leagueName = league.leagueName
        entity.leagueLogo = league.leagueLogo
        entity.league_key = Int32(league.league_key ?? 0)
        entity.sportName = league.sportName

        do {
            try context.save()
            print("✅ Saved league:")
            print("  - Name : \(league.leagueName)")
            print("  - Sport: \(league.sportName)")
            print("  - Key  : \(league.league_key ?? -1)")
        } catch {
            print("❌ Failed to save league: \(error)")
        }
    }

    func deleteLeague(withKey key: Int) {
        let fetchRequest: NSFetchRequest<LeagueEntity> = LeagueEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "league_key == %d", key)

        do {
            let entities = try context.fetch(fetchRequest)
            if entities.isEmpty {
                print("⚠️ No league found with key: \(key)")
            } else {
                for entity in entities {
                    print("🗑 Deleting league: \(entity.leagueName ?? "Unknown") with key: \(entity.league_key)")
                    context.delete(entity)
                }
                try context.save()
                print("✅ Deleted league(s) with key: \(key)")
            }
        } catch {
            print("❌ Failed to delete league with key \(key): \(error)")
        }
    }
}
