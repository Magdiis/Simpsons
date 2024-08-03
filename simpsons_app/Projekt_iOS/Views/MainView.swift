//
//  MainView.swift
//  Projekt_iOS
//
//  Created by Magdaléna Klimešová on 31.05.2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var episodeViewModel: EpisodeViewModel
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var epis: FetchedResults<Episode>
    @State var FavouriteScrollVisibility: Bool = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                HStack {
                    Image("donut")
                        .resizable()
                        .frame(width: 37, height: 32)
                    Text("Best Ratings")
                        .font(.system(.title,design: .rounded))
                        .foregroundColor(.black)
                    Image("donut")
                        .resizable()
                        .frame(width: 37, height: 32)
                }.padding([.top])
                
                if(episodeViewModel.bestEpisodes.isEmpty){
                    VStack{
                        Text("No episode deserved 5 donuts")
                            .font(.system(.title3,design: .rounded))
                            .foregroundColor(Color("DonutPink"))
                        Image("homerNoBestEpisodes")
                            .resizable()
                            .frame(width: 240, height: 280)
                        
                    }
                
                } else {
                    FavouriteScroll(episodeViewModel: episodeViewModel, forFavourite: false)
                }
                
                BarChart(episodeViewModel: episodeViewModel).onAppear{
                    episodeViewModel.refreshDataToBarChart()
                }
                HStack() {
                    Image("like")
                        .resizable()
                        .frame(width: 31, height: 37)
                    Text("Favourites")
                        .font(.system(.title,design: .rounded))
                        .foregroundColor(.black)
                    Image("like")
                        .resizable()
                        .frame(width: 31, height: 37)
                } 

                if (episodeViewModel.favouriteEpisodes.isEmpty){
                    VStack{
                        Text("Your list of favourite episodes is empty")
                            .font(.system(.title3,design: .rounded))
                            .foregroundColor(Color("DonutPink"))
                        Image("homer")
                            .resizable()
                            .frame(width: 160, height: 210)
                        
                    }
                    .onAppear{
                        episodeViewModel.refreshDataToPieChart()
                    }
                } else{
                    FavouriteScroll(episodeViewModel: episodeViewModel, forFavourite: true)
                    
                    PieChart(episodeViewModel: episodeViewModel)
                    .onAppear{
                        episodeViewModel.refreshDataToPieChart()
                    }
                
            }
                
        }
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    StrokeText(text: "Simpsons", width: 1, color: .black)
                        .foregroundColor(Color("YellowTitle"))
                        .font(.system(.largeTitle,design: .rounded).weight(.heavy))
                }
            }
            
          
        }.onAppear{
            episodeViewModel.refreshBestEpisodes()
            episodeViewModel.refreshFavouriteEpisodes()
        }
        
    }
        
}



