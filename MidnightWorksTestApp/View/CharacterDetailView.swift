//
//  CharacterDetailView.swift
//  MidnightWorksTestApp
//
//  Created by Alex Kolsa on 02.10.2021.
//

import SwiftUI
import Kingfisher

struct CharacterDetailView: View {
    @ObservedObject var detailViewModel: CharacterDetailViewModel
    @State var episode: String = ""
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                KFImage(URL(string: detailViewModel.choosedCharacter.image))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 170)
                    .cornerRadius(15)
                VStack(alignment: .leading) {
                    Text("Last known location:")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.orange)
                    Text(detailViewModel.choosedCharacter.location.name)
                        .lineLimit(2)
                        .minimumScaleFactor(0.75)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color.black.opacity(0.5))
                    
                    Text("First seen in:")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.orange)
                        .padding(.top, 2)
                    Text(episode)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color.black.opacity(0.5))
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Status:")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.orange)
                            .padding(.top, 2)
                        HStack {
                            Circle().frame(width: 10, height: 10)
                                .foregroundColor(detailViewModel.choosedCharacter.status == "Alive" ? Color.green : Color.red)
                            Text(detailViewModel.choosedCharacter.status)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.black.opacity(0.5))
                        }
                    }
                    
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .topLeading)
            .padding(.vertical)
            .padding(.horizontal)
            .onAppear {
                MainViewModel.access.fetchFirstSeenEpisode(url: detailViewModel.choosedCharacter.episode.first ?? "") { firstEpisode in
                    episode = firstEpisode
                }
            }
            
            VStack {
                HStack {
                    Text("""
                         Also from "\(detailViewModel.choosedCharacter.location.name)"
                         """)
                        .font(.system(size: 18, weight: .bold))
                        .frame(alignment: .leading)
                    Spacer()
                }.padding(.horizontal)
                
                ForEach(detailViewModel.currentLocationCharacters, id: \.self) { character in
                    CharacterCell(character: character)
                        .onTapGesture {
                            detailViewModel.choosedCharacter = character
                            MainViewModel.access.fetchFirstSeenEpisode(url: detailViewModel.choosedCharacter.episode.first ?? "") { firstEpisode in
                                episode = firstEpisode
                            }
                        }
                        .padding(.horizontal)
                }
                
            }
        }
        .navigationBarTitle(detailViewModel.choosedCharacter.name, displayMode: .large)
        .navigationBackButton(color: .black, text: "Back")
    }
}
