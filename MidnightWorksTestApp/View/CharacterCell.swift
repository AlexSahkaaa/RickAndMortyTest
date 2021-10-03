//
//  CharacterCell.swift
//  MidnightWorksTestApp
//
//  Created by Alex Kolsa on 03.10.2021.
//

import SwiftUI
import Kingfisher

struct CharacterCell: View {
    @EnvironmentObject var viewModel: MainViewModel
    var character: Character
    @State var episode: String = ""
    
    var body: some View {
        HStack {
            KFImage(URL(string: character.image))
                .resizable()
                .scaledToFit()
                .frame(width: 125, height: 125)
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color.orange)
                Spacer()
                Text(character.location.name)
                    .minimumScaleFactor(0.75)
                    .lineLimit(1)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color.black.opacity(0.5))
                Spacer()
                Text("Episode:")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color.black.opacity(0.5))
                Text(episode)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color.black.opacity(0.5))
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 6)
        }
        .onAppear(perform: {
            viewModel.fetchFirstSeenEpisode(url: character.episode.first ?? "") { firstEpisode in
                episode = firstEpisode
            }
        })
        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .topLeading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 8, y: 5)
        .padding(.vertical, 8)
    }
}
