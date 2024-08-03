//
//  episodeViewModel.swift
//  Projekt_iOS
//
//  Created by Magdaléna Klimešová on 31.05.2023.
//

import Foundation
import Combine
import SwiftUI
import CoreData

class EpisodeViewModel: ObservableObject {
    @Published var episodesItemsURL: [EpisodeItemURL] = []
    @Published var episodesItems: [EpisodeItem] = []
    @Published var dataToPieChart: [(Double,Color)] = []
    @Published var dataToBarChart: [SeasonForBarChart] = []
    @Published var favouriteEpisodes: [EpisodeItem] = []
    @Published var bestEpisodes: [EpisodeItem] = []
    var moc: NSManagedObjectContext
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
    }
    
    func fetch() {
        guard let url = URL(string: "https://api.sampleapis.com/simpsons/episodes" ) else {
            return
        }
        let episode = URLSession.shared.dataTask(with: url){ [weak self] data, _,
            error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let episodes = try JSONDecoder().decode([EpisodeItemURL].self, from: data)
                DispatchQueue.main.async {
                    self?.episodesItemsURL = episodes
                    self?.saveToDB()
                }
            } catch {
                print(error)
            }
            
        }
        episode.resume()
    }
    
    func refresh(epis: FetchedResults<Episode>){
        episodesItems = epis.map {
            return EpisodeItem(id: $0.id ?? UUID(), season: $0.season , episode: $0.episode , name: $0.name ?? "", plot: $0.plot ?? "", thumbnailUrl: $0.photo ?? "", isFavourite: $0.isFavourite, userRating: $0.userRating)
        }
        sortEpisodes()
    }
    
    func saveToDB(){
        episodesItemsURL.forEach{ (data) in
            let entity = Episode(context: moc)
            entity.id = UUID()
            entity.name = data.name
            entity.episode = Int16(data.episode)
            entity.season = Int16(data.season)
            entity.plot = data.description
            entity.photo = data.thumbnailUrl
            entity.userRating = Int16(0)
            entity.isFavourite = false
        }
        do {
            try moc.save()
            print("Success")
        } catch let error as NSError{
            print("Error saving to DB: \(error.localizedDescription)")
            print("Error details: \(error.userInfo)")
        }
    }
    
    private func sortEpisodes(){
        episodesItems.sort {
            $0.episode < $1.episode
        }
        episodesItems.sort {
            $0.season < $1.season
        }
    }
    
    func getEpisodeItem(with id: UUID)-> EpisodeItem? {
        return episodesItems.first{$0.id == id }
    }
    
    
    private func getEpisode(with id: UUID) -> Episode? {
        let request = Episode.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        guard let items = try? moc.fetch(request) else {return nil}
        return items.first
    }
    
    func changeRating(id: UUID, newRating: Int){
        if let changedEpisode = getEpisode(with: id){
            changedEpisode.userRating = Int16(newRating)
            save()
        }
    }
    
    func changeFavourite(id: UUID){
        let episode = getEpisode(with: id)
        episode?.isFavourite = !(episode?.isFavourite ?? false)
        save()
    }
    
    private func save(){
        if moc.hasChanges {
            do {
                try moc.save()
            } catch  {
                print(error)
            }
        }
    }
    
    
    
    func refreshDataToPieChart(){
        var counts: [Double] = []
        for i in 1...10{
            counts.append(returnCountOfFavourites(season: Int16(i)))
        }
        
        if (counts.count == 10){
            dataToPieChart = []
            for i in 0...9 {
                dataToPieChart.append((counts[i],colors[i]))
            }
        }
    }
    
    private func returnCountOfFavourites(season: Int16) -> Double {
        var count = 0.0
        for episode in episodesItems {
            if (episode.season == season && episode.isFavourite == true){
                count += 1.0
            }
        }
        return count
    }
    
    
    func refreshDataToBarChart(){
        dataToBarChart = []
        for i in 1...10 {
            dataToBarChart.append(SeasonForBarChart(season: i, average: returnAverage(season: i)))
            //print(returnAverage(season: i))
        }
        
    }
    
    func returnAverage(season: Int) -> Double{
        let episodes = episodesItems.filter{
            $0.season == season
        }
        var sum: Int = 0
        for episode in episodes{
            sum += Int(episode.userRating)
        }
        let result: Double = Double(sum)/Double(episodes.count)
     
        return result
    }
    func refreshBestEpisodes(){
        bestEpisodes = episodesItems.filter{
            return $0.userRating > 4
        }
    }
    
    func refreshFavouriteEpisodes(){
        favouriteEpisodes = episodesItems.filter{
            return $0.isFavourite == true
        }
    }
    
}
