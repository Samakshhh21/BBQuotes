//
//  CharacterView.swift
//  BBQuotes
//
//  Created by Samaksh Sangwan on 11/10/25.
//

import SwiftUI


struct CharacterView: View {
    let character : Char
    let show : String
    
    @State private var statusExpanded: Bool = false
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment : .top) {
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFit()
            }
            
            ScrollViewReader { proxy in
                ScrollView {
                    AsyncImage(url: character.images[0]) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .frame(width: geo.size.width/1.2, height: geo.size.height/2)
                            .padding(.top , 90)
                    } placeholder: {
                        ProgressView()
                    }
                    VStack(alignment: .leading) {
                        Text(character.name)
                            .font(.largeTitle)
                        
                        Text("Portrayed by: \(character.portrayedBy)")
                            .font(.subheadline)
                        Divider()
                        
                        Text("\(character.name) Character Info")
                            .font(.title2)
                        
                        Text("Born: \(character.birthday)")
                        
                        Divider()
                        
                        Text("Occupations:")
                        
                        ForEach(character.occupations, id: \.self) { occupation in
                            Text("-\(occupation)")
                                .font(.subheadline)
                        }
                        
                        Divider()
                        Text("Nicknames")
                        if character.aliases.count > 0 {
                            ForEach(character.aliases, id: \.self) { alias in
                                Text("-\(alias)")
                                    .font(.subheadline)
                            }
                        } else {
                            Text("None")
                                .font(.subheadline)
                        }
                        Divider()
                        
                        DisclosureGroup("Status (Spoiler Alert !!)", isExpanded: $statusExpanded) {
                            VStack(alignment: .leading) {
                                Text(character.status)
                                    .font(.title2)
                                if let death = character.death {
                                    AsyncImage(url: death.image) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    Text("How: \(death.details)")
                                    Text("Last words \"\(death.lastWords)\"")
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .tint(.primary)
                        .id("statusSection")
                        .onChange(of: statusExpanded) { newValue, oldValue in
                            if newValue != oldValue {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation {
                                        proxy.scrollTo("statusSection", anchor: .top)
                                    }
                                }
                            }
                        }
                        
                    }
                    .frame(width: geo.size.width/1.25, alignment: .leading)
                    .padding(.top, 60)
                    .padding(.bottom)
                }
                .frame(width: geo.size.width)
                .scrollIndicators(.hidden)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: ViewModel().character,show: "Breaking Bad")
}
